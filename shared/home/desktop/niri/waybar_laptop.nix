{ pkgs, ... }:
{
  programs.waybar.settings.mainBar = {
    modules-right = [
      "group/laptop"
    ];

    backlight = {
      format = "{percent}% {icon}";
      format-icons = [
        ""
        ""
      ];
      scroll-step = 5;
    };

    memory = {
      interval = 5;
      format = " {}%";
      tooltip-format = "{used:0.1f}G / {total:0.1f}G";
    };

    "group/laptop" = {
      modules = [
        "battery"
        "memory"
        "backlight"
      ];
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
      format = "{icon} {capacity}%";
      format-charging = "{capacity}% 󰚥 {icon}";
      format-icons = [
        ""
        ""
        ""
        ""
        ""
      ];
      max-length = 25;
    };
  };
}
