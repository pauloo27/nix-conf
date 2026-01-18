{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        modules-left = [
          "hyprland/workspaces"
          "hyprland/window"
        ];
        modules-center = [ "custom/rstroller" ];
        modules-right = [
          "pulseaudio"
          "tray"
          "privacy"
          "clock"
        ];

        "custom/rstroller" = {
          exec = "rstroller waybar 2> /tmp/rstroller-log";
          return-type = "json";
          on-click = "rstroller-gui";
          on-scroll-up = "rstroller scroll-player up";
          on-scroll-down = "rstroller scroll-player down";
        };

        privacy = {
          icon-spacing = 4;
          icon-size = 18;
          transition-duration = 250;
          modules = [
            {
              type = "screenshare";
              tooltip = true;
              tooltip-icon-size = 24;
            }
            {
              type = "audio-out";
              tooltip = true;
              tooltip-icon-size = 24;
            }
            {
              type = "audio-in";
              tooltip = true;
              tooltip-icon-size = 24;
            }
          ];
        };

        tray = {
          icon-size = 15;
          spacing = 10;
        };

        pulseaudio = {
          format = "{icon} {volume}% | {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = " {volume}%";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
          };
          on-click = "pavucontrol";
        };

        clock = {
          on-click = "planify";
          format = "<span color='#cba6f7'> </span>{:%H:%M}";
          tooltip-format = "<big>{:%a, %d %b • %H:%M}</big>\n<tt><small>{calendar}</small></tt>";
        };

        "hyprland/window" = {
          format = "  {}";
          max-length = 40;
          separate-outputs = true;
        };

        "hyprland/workspaces" = {
          format = "{name}";
          on-click = "activate";
          all-outputs = false;
        };
      };
    };

    style = ''
      * {
        border: none;
        font-family: 'Comic Code', 'Symbols Nerd Font Mono';
        font-size: 14px;
        min-height: 25px;
      }

      window#waybar {
        background-color: rgba(25, 23, 36, 0.9);
      }

      #workspaces {
        color: #908caa;
      }

      #window {
        color: #908caa;
        margin-right: 0;
        padding-left: 5px;
        padding-right: 10px;
      }

      #workspaces button {
        color: #908caa;
        border-radius: 0;
        font-weight: normal;
      }

      #workspaces button.active {
        color: #cdd6f4;
        font-weight: bold;
      }

      #clock,
      #tray,
      #custom-rstroller,
      #privacy,
      #pulseaudio,
      #network,
      #workspaces,
      #battery {
        color: #cdd6f4;
        padding-left: 10px;
        padding-right: 10px;
      }
    '';
  };
}
