{ pkgs, ... }:
{
  programs.waybar.settings.mainBar = {
    modules-right = [
      "pulseaudio"
      "group/laptop"
      "tray"
      "privacy"
      "clock"
    ];

    backlight = {
      format = "{percent}% {icon}";
      format-icons = [ "" "" ];
      scroll-step = 5;
    };

    "group/laptop" = {
      modules = [ "battery" "backlight" ];
      orientation = "horizontal";
      drawer = {
        transition-duration = 500;
        children-class = "not-power";
        transition-left-to-right = false;
      };
    };

    battery = {
      bat = "BAT0";
      weighted-average = true;
      interval = 10;
      states = {
        warning = 30;
        critical = 15;
      };
      format = "{capacity}% {icon}";
      format-charging = "{capacity}% 󰚥 {icon}";
      format-icons = [ "" "" "" "" "" ];
      max-length = 25;
    };
  };
}
