#!/bin/bash

secret() {
  cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w "${1:-32}" | head -n 1
}

secretx() {
  cat /dev/urandom | tr -dc '[:graph:]' | fold -w "${1:-32}" | head -n 1
}
alias c=clear
alias g=git
alias v=nvim
alias k="kubectl"
alias kc="kubectx"
alias dig="doggo"
alias dog="doggo"
alias p=pnpm

alias diff='diff --color=auto'
alias ls="ls --color=auto"

mkcd () {
  mkdir "$1"
  cd "$1"
}

# push current branch
psc() {
  git push -u origin $(git branch --show-current)
}

# add to .gitignore
ig() {
  echo "$@" >> .gitignore
}

# fjapi — thin curl wrapper for the Forgejo REST API.
#
# Usage:
#   fjapi <METHOD> <path> [data]
#   echo '{"k":"v"}' | fjapi POST repos/owner/repo/issues -
#
# <path> is appended to ${FORGEJO_API_HOST}/api/v1/. A leading slash is fine.
# [data] is a JSON string, or "-" to read the body from stdin, or "@file" to
# read from a file. Omit for GET/DELETE with no body.
#
# Requires: FORGEJO_API_AUTH_USER, FORGEJO_API_AUTH_KEY, FORGEJO_API_HOST.
# Returns non-zero on HTTP >= 400 and prints the response body to stderr.
fjapi() {
  if [ -z "$FORGEJO_API_AUTH_USER" ] || [ -z "$FORGEJO_API_AUTH_KEY" ] || [ -z "$FORGEJO_API_HOST" ]; then
    echo "fjapi: FORGEJO_API_AUTH_USER / FORGEJO_API_AUTH_KEY / FORGEJO_API_HOST not set" >&2
    return 2
  fi
  if [ $# -lt 2 ]; then
    echo "usage: fjapi <METHOD> <path> [data|-|@file]" >&2
    return 2
  fi

  local method path url response status body
  method=$(printf '%s' "$1" | tr '[:lower:]' '[:upper:]')
  path=${2#/}
  url="${FORGEJO_API_HOST%/}/api/v1/${path}"

  local curl_args=(
    -sS
    -u "${FORGEJO_API_AUTH_USER}:${FORGEJO_API_AUTH_KEY}"
    -X "$method"
    -w '\n%{http_code}'
  )

  if [ $# -ge 3 ] && [ -n "$3" ]; then
    curl_args+=(-H 'content-type: application/json')
    case "$3" in
      -)  curl_args+=(--data-binary @-) ;;
      @*) curl_args+=(--data-binary "$3") ;;
      *)  curl_args+=(--data-binary "$3") ;;
    esac
  fi

  response=$(curl "${curl_args[@]}" "$url")
  status=${response##*$'\n'}
  body=${response%$'\n'*}

  if command -v jq >/dev/null 2>&1 && [ -n "$body" ]; then
    printf '%s' "$body" | jq . 2>/dev/null || printf '%s\n' "$body"
  else
    printf '%s\n' "$body"
  fi

  if [ "$status" -ge 400 ]; then
    echo "fjapi: HTTP $status" >&2
    return 1
  fi
}
