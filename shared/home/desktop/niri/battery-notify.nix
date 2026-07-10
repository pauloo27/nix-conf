{ pkgs, ... }:
let
  batteryNotify = pkgs.writeShellScript "battery-notify" ''
    set -eu

    bat=/sys/class/power_supply/BAT0
    [ -d "$bat" ] || exit 0

    status=$(cat "$bat/status")
    capacity=$(cat "$bat/capacity")

    # only nag while running on battery
    [ "$status" = "Discharging" ] || exit 0

    notify() {
      urgency="$1"
      icon="$2"
      summary="$3"
      # x-canonical-private-synchronous replaces the previous battery
      # notification instead of stacking a new one every minute
      ${pkgs.libnotify}/bin/notify-send \
        --app-name=battery \
        --urgency="$urgency" \
        --icon="$icon" \
        --hint=string:x-canonical-private-synchronous:battery \
        "$summary" "Battery at ''${capacity}%"
    }

    if [ "$capacity" -le 3 ]; then
      notify critical battery-caution "Battery empty — shutting down"
      # give the notification a moment to reach the daemon before we go down
      sleep 5
      ${pkgs.systemd}/bin/systemctl poweroff
    elif [ "$capacity" -le 10 ]; then
      notify critical battery-caution "Battery critically low"
    elif [ "$capacity" -le 20 ]; then
      notify normal battery-low "Battery low"
    fi
  '';
in
{
  systemd.user.services.battery-notify = {
    Unit.Description = "Notify when the laptop battery is low";
    Service = {
      Type = "oneshot";
      ExecStart = "${batteryNotify}";
    };
  };

  systemd.user.timers.battery-notify = {
    Unit.Description = "Check laptop battery level every minute";
    Timer = {
      OnCalendar = "*:0/1";
      Persistent = false;
    };
    Install.WantedBy = [ "timers.target" ];
  };
}
