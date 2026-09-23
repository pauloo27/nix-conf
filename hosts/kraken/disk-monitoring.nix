{
  pkgs,
  lib,
  ...
}:

let
  ntfyTopicFile = "/var/lib/secrets/ntfy-topic";

  diskIds = [
    "scsi-35000c500571d23bf"
    "scsi-35000c500964ac36f"
    "scsi-35000c500964b5e7b"
    "scsi-35000c500964b723b"
    "scsi-35000c500964bbbd3"
  ];

  # the GE11-firmware drives grow ~13-20k/day while healthy
  nonMediumErrorDailyThreshold = 50000;

  # usage: kraken-ntfy <title> <priority> <tags>, message on stdin
  ntfy = pkgs.writeShellScriptBin "kraken-ntfy" ''
    topic=$(cat ${ntfyTopicFile})
    ${pkgs.curl}/bin/curl -fsS --retry 3 -m 30 \
      -H "Title: $1" -H "Priority: $2" -H "Tags: $3" \
      --data-binary @- "https://ntfy.sh/$topic" > /dev/null
  '';

  smartdNotify = pkgs.writeShellScript "smartd-ntfy" ''
    printf '%s\n' "$SMARTD_FULLMESSAGE" \
      | ${ntfy}/bin/kraken-ntfy "kraken: SMART $SMARTD_FAILTYPE on $SMARTD_DEVICE" high warning
  '';

  nonMediumErrorCheck = pkgs.writeShellScript "smart-nme-check" ''
    set -u
    alerts=()
    for id in ${lib.escapeShellArgs diskIds}; do
      count=$(${pkgs.smartmontools}/bin/smartctl -l error "/dev/disk/by-id/$id" \
        | ${pkgs.gawk}/bin/awk '/^Non-medium error count/ {print $4}')
      if [ -z "$count" ]; then
        alerts+=("$id: could not read non-medium error count")
        continue
      fi
      state="$STATE_DIRECTORY/$id"
      if [ -f "$state" ]; then
        delta=$(( count - $(cat "$state") ))
        if [ "$delta" -gt ${toString nonMediumErrorDailyThreshold} ]; then
          alerts+=("$id: +$delta since last check (now $count)")
        fi
      fi
      echo "$count" > "$state"
    done
    if [ "''${#alerts[@]}" -gt 0 ]; then
      printf '%s\n' "''${alerts[@]}" \
        | ${ntfy}/bin/kraken-ntfy "kraken: non-medium errors growing" high warning
    fi
  '';
in
{
  environment.systemPackages = [ ntfy ];

  services.smartd = {
    enable = true;
    autodetect = false;
    notifications.wall.enable = false;
    # short test Sundays 03:00, long test on the 15th 04:00 (away from the scrub on the 1st)
    defaults.monitored = "-a -s (S/../../7/03|L/../15/./04) -m <nomailer> -M exec ${smartdNotify}";
    devices = map (id: { device = "/dev/disk/by-id/${id}"; }) diskIds;
  };

  services.zfs.zed.settings = {
    # zed.rc is sourced as shell by the zedlets, so the topic is read at runtime
    # and stays out of the nix store
    ZED_NTFY_TOPIC = "$(cat ${ntfyTopicFile})";
    ZED_NOTIFY_VERBOSE = true;
  };

  systemd.services.smart-nme-check = {
    description = "Alert when SAS non-medium error counters grow";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = nonMediumErrorCheck;
      StateDirectory = "smart-nme";
    };
  };

  systemd.timers.smart-nme-check = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
    };
  };
}
