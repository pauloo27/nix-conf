{
  pkgs,
  lib,
  hostname,
  ...
}:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = false;
      };

      animations = {
        enabled = true;
        bezier = "linear, 1, 1, 0, 0";
        animation = [
          "fadeIn, 1, 5, linear"
          "fadeOut, 1, 5, linear"
          "inputFieldDots, 1, 2, linear"
        ];
      };

      background = [
        {
          monitor = "";
          path = "screenshot";
          blur_passes = 3;
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "400, 50";
          outline_thickness = 3;
          inner_color = "rgba(0, 0, 0, 0.0)";
          outer_color = "rgba(56526eff)";
          check_color = "rgba(56526eff)";
          fail_color = "rgba(ff0066ee)";
          font_color = "rgb(224, 222, 244)";
          fade_on_empty = false;
          rounding = 15;
          font_family = "Monospace";
          placeholder_text = "Input password...";
          fail_text = "$PAMFAIL";
          hide_input = false;
          dots_spacing = 0.3;
          position = "0, -20";
          halign = "center";
          valign = "center";
        }
      ];

      label = [
        {
          monitor = "";
          text = "$TIME";
          font_size = 90;
          font_family = "Monospace";
          position = "-30, 0";
          halign = "right";
          valign = "top";
        }
        {
          monitor = "";
          text = ''cmd[update:60000] date +"%A, %d %B %Y"'';
          font_size = 25;
          font_family = "Monospace";
          position = "-30, -150";
          halign = "right";
          valign = "top";
        }
        {
          monitor = "";
          text = "$LAYOUT";
          font_size = 20;
          font_family = "Monospace";
          position = "0, -100";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "User: $USER | Attempts: $ATTEMPTS";
          font_size = 16;
          font_family = "Monospace";
          position = "0, -140";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "Last fail: $FAIL";
          font_size = 16;
          font_family = "Monospace";
          position = "0, -170";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "PAM prompt: $PAMPROMPT";
          font_size = 16;
          font_family = "Monospace";
          position = "0, -200";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
