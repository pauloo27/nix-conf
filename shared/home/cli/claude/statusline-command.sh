#!/usr/bin/env bash
input=$(cat)

cwd=$(echo "$input" | jq -r '.cwd // ""')
dir=$(basename "$cwd")

model=$(echo "$input" | jq -r '.model.display_name // ""')

used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

branch=$(git -C "$cwd" --no-optional-locks branch --show-current 2>/dev/null)

five_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
seven_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

parts=()

# k8s context — mirrors the starship kubernetes module: cluster name is captured
# from the live context; first match wins.
k8s_users=(work)
k8s_hosts=(zita lio)

host=$(hostname -s 2>/dev/null)
k8s_enabled=""
for u in "${k8s_users[@]}"; do [ "$u" = "$USER" ] && k8s_enabled=1; done
for h in "${k8s_hosts[@]}"; do [ "$h" = "$host" ] && k8s_enabled=1; done

if [ -n "$k8s_enabled" ] && command -v kubectl >/dev/null 2>&1; then
  k8s_ctx=$(kubectl config current-context 2>/dev/null)
  if [ -n "$k8s_ctx" ]; then
    if [[ "$k8s_ctx" =~ ^([[:alnum:]_-]+)-prod$ ]]; then
      # <cluster>-prod  ->  " <cluster>:PROD " in a bold black-on-red block.
      k8s_str=$'\033[1;30;41m '"${BASH_REMATCH[1]}"$':PROD \033[0m'
    elif [ "$k8s_ctx" = "k3d-local-kluster" ]; then
      # local k3d cluster.
      k8s_str=$'\033[32m[local]\033[0m'
    elif [[ "$k8s_ctx" =~ ^([[:alnum:]_]+)-([[:alnum:]_]+) ]]; then
      # <cluster>-<env>  ->  "[<cluster>:<env>]" in the default bold yellow.
      k8s_str=$'\033[1;33m['"${BASH_REMATCH[1]}:${BASH_REMATCH[2]}"$']\033[0m'
    else
      # anything unrecognised — default bold yellow, as-is.
      k8s_str=$'\033[1;33m['"$k8s_ctx"$']\033[0m'
    fi
    parts+=("$k8s_str")
  fi
fi

parts+=("$dir")
[ -n "$branch" ] && parts+=("$branch")
[ -n "$model" ] && parts+=("$model")
if [ -n "$used_pct" ]; then
  printf -v ctx_str "ctx: %.0f%%" "$used_pct"
  parts+=("$ctx_str")
fi

# Rate limit segments — only present for Claude.ai subscribers after first API response
if [ -n "$seven_pct" ]; then
  printf -v week_str "7d: %.0f%%" "$seven_pct"
  parts+=("$week_str")
fi
if [ -n "$five_pct" ]; then
  printf -v five_str "5h: %.0f%%" "$five_pct"
  parts+=("$five_str")
fi

out=""
for part in "${parts[@]}"; do
  [ -n "$out" ] && out="$out | "
  out="$out$part"
done

printf "%s" "$out"
