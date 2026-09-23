# Weekly disk report: raw stats plus a plain-language verdict, sent by email.
# Env: POOL, DISK_IDS, REPORT_TO, MSMTP_CONFIG, STATE_DIRECTORY (from systemd)
set -uo pipefail

status=OK
summary=()

raise() {
  case "$1" in
    CRITICAL) status=CRITICAL ;;
    ATTENTION) [ "$status" = OK ] && status=ATTENTION ;;
  esac
  summary+=("[$1] $2")
}

note() {
  summary+=("$1")
}

read -r pool_health cap frag < <(zpool list -H -o health,capacity,fragmentation "$POOL")
cap=${cap%\%}
if [ "$pool_health" != ONLINE ]; then
  raise CRITICAL "Pool $POOL is $pool_health: a disk has failed or dropped out. Check it now."
else
  note "Pool $POOL is healthy (ONLINE), ${cap}% full."
fi
if [ "$(zpool status -x "$POOL")" != "pool '$POOL' is healthy" ]; then
  raise ATTENTION "ZFS has logged errors on the pool, see the zpool status below."
fi
if [ "$cap" -ge 80 ]; then
  raise ATTENTION "Pool is ${cap}% full. ZFS gets slow past 80%, time to add space or clean up."
fi

scan=$(zpool status "$POOL" | sed -n 's/^ *scan: //p')
case "$scan" in
  "scrub repaired 0B"*"with 0 errors"*)
    scrub_ts=$(date -d "${scan##* on }" +%s 2>/dev/null || echo 0)
    age=$(( ($(date +%s) - scrub_ts) / 86400 ))
    if [ "$age" -gt 40 ]; then
      raise ATTENTION "Last scrub was $age days ago, it should run monthly. Check zfs-scrub.timer."
    else
      note "Last scrub, $age days ago, read everything and found no errors."
    fi
    ;;
  "scrub in progress"*)
    note "A scrub is running right now."
    ;;
  *)
    raise ATTENTION "Last scrub did not come back clean: $scan"
    ;;
esac

table=$(printf '%-24s %-6s %5s %7s %8s %7s %11s %9s  %s' \
  disk health temp hours defects uncorr non-medium "week +" "last self-test")
disk_issues=0
oldest=0
temps=()
new_counts=()

for id in $DISK_IDS; do
  out=$(smartctl -x "/dev/disk/by-id/$id")
  health=$(awk '/^SMART Health Status:/ {print $4}' <<<"$out")
  temp=$(awk '/^Current Drive Temperature:/ {print $4}' <<<"$out")
  hours=$(awk '/number of hours powered up/ {printf "%d", $7}' <<<"$out")
  defects=$(awk '/^Elements in grown defect list:/ {print $6}' <<<"$out")
  uncorr=$(awk '/^(read|write|verify):/ {s += $8} END {print s+0}' <<<"$out")
  nme=$(awk '/^Non-medium error count:/ {print $4}' <<<"$out")
  test_desc=$(sed -nE 's/^# 1 +(.*[^ ]) +[0-9]+ +[0-9]+ +(-|[0-9]+) +\[.*/\1/p' <<<"$out" | tr -s ' ')
  test_hours=$(sed -nE 's/^# 1 .* ([0-9]+) +(-|[0-9]+) +\[.*/\1/p' <<<"$out")

  if [ -z "$health" ] || [ -z "$hours" ]; then
    raise ATTENTION "Could not read SMART data from $id. The disk may be gone or not responding."
    disk_issues=1
    table+=$'\n'"$(printf '%-24s unreadable' "$id")"
    continue
  fi

  delta=-
  state="$STATE_DIRECTORY/$id"
  if [ -n "$nme" ]; then
    [ -f "$state" ] && delta=$(( nme - $(cat "$state") ))
    new_counts+=("$id $nme")
  fi

  if [ "$health" != OK ]; then
    raise CRITICAL "Disk $id: the drive itself reports it is failing (health: $health). Replace it."
    disk_issues=1
  fi
  if [ "${defects:-0}" -gt 0 ]; then
    raise ATTENTION "Disk $id has $defects remapped bad sectors. A handful is wear, if it grows week to week the drive is dying."
    disk_issues=1
  fi
  if [ "$uncorr" -gt 0 ]; then
    raise ATTENTION "Disk $id had $uncorr errors it could not fix itself. ZFS covers for it with parity, but the drive is getting unreliable."
    disk_issues=1
  fi
  if [ "${temp:-0}" -gt 50 ]; then
    raise ATTENTION "Disk $id is running hot (${temp}C). Check fans and airflow."
    disk_issues=1
  fi
  if [[ "$test_desc" != *Completed* ]]; then
    raise ATTENTION "Disk $id last self-test did not pass: $test_desc"
    disk_issues=1
  elif [ $(( hours - ${test_hours:-0} )) -gt 192 ]; then
    raise ATTENTION "Disk $id has not run a self-test in $(( (hours - test_hours) / 24 )) days. smartd's test schedule may be broken."
    disk_issues=1
  fi
  if [ "$delta" != - ] && [ "$delta" -gt 350000 ]; then
    raise ATTENTION "Disk $id non-medium errors grew by $delta this week, far above its normal rate. Check cabling and the kernel log."
    disk_issues=1
  fi

  [ "$hours" -gt "$oldest" ] && oldest=$hours
  [ -n "$temp" ] && temps+=("$temp")
  table+=$'\n'"$(printf '%-24s %-6s %4sC %7s %8s %7s %11s %9s  %s' \
    "$id" "$health" "${temp:--}" "$hours" "${defects:--}" "$uncorr" "${nme:--}" "$delta" "$test_desc at ${test_hours}h")"
done

if [ "$disk_issues" -eq 0 ]; then
  read -r tmin tmax < <(printf '%s\n' "${temps[@]}" | sort -n | sed -n '1p;$p' | tr '\n' ' ')
  note "All disks pass SMART: no bad sectors, no unfixable errors, self-tests passing, ${tmin}-${tmax}C."
fi
if [ "$oldest" -gt 60000 ]; then
  note "Oldest disk has $oldest hours on it (~$(( oldest / 8760 )) years). Fine for now, but keep a spare ready."
fi

case "$status" in
  OK) verdict="Everything looks fine. Nothing to do." ;;
  ATTENTION) verdict="Something needs a look. See the [ATTENTION] lines." ;;
  CRITICAL) verdict="Act now. See the [CRITICAL] lines." ;;
esac

body=$(
  echo "Status: $status - $verdict"
  echo
  echo "Summary"
  printf -- '- %s\n' "${summary[@]}"
  echo
  echo "Pool: health=$pool_health capacity=${cap}% fragmentation=$frag"
  echo
  echo "Disks (\"week +\" is non-medium error growth since the last report;"
  echo "~100k/week is normal for the GE11-firmware drives)"
  echo "$table"
  echo
  echo "zpool status"
  zpool status "$POOL"
)

html_body=$(sed -e 's/&/\&amp;/g' -e 's/</\&lt;/g' -e 's/>/\&gt;/g' <<<"$body")

if ! printf 'To: %s\nSubject: kraken disk report: %s\nContent-Type: text/html; charset=utf-8\n\n<pre>\n%s\n</pre>\n' \
  "$REPORT_TO" "$status" "$html_body" | timeout 120 msmtp -C "$MSMTP_CONFIG" -t; then
  echo "weekly disk report email failed to send" | kraken-ntfy "kraken: disk report email failed" high warning
  exit 1
fi

# only after a successful send, so a failed run doesn't reset the weekly baseline
for entry in "${new_counts[@]}"; do
  read -r id nme <<<"$entry"
  echo "$nme" > "$STATE_DIRECTORY/$id"
done
