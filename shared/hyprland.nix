{ pkgs, ... }:
{
  imports = [
    ./hyprlock.nix
  ];

  home.packages = with pkgs; [
    grimblast
    hyprpicker
    rose-pine-hyprcursor
    xfce.xfce4-notifyd
    pavucontrol
  ];
  
  services.hyprpolkitagent.enable = true;

  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      preload = "/home/paulo/medias/pictures/wp.png";
      wallpaper = ",/home/paulo/medias/pictures/wp.png";
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # =======
      # General Config
      # =======
      "$mainMod" = "SUPER";

      exec-once = [
        "hyprctl setcursor rose-pine-hyprcursor 24"
      ];

      input = {
        kb_layout = "us";
        kb_variant = "altgr-intl";
        kb_options = "caps:swapescape";
        follow_mouse = 1;

        touchpad = {
          natural_scroll = false;
        };

        sensitivity = 0;
      };

      general = {
        gaps_in = 2.5;
        gaps_out = 5;
        border_size = 2;
        layout = "dwindle";

        "col.active_border" = "rgba(56526eff)";
        "col.inactive_border" = "rgba(191724ff)";
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      decoration = {
        blur = {
          enabled = true;
          size = 2;
          passes = 2;
          new_optimizations = true;
          xray = true;
          noise = 0;
          contrast = 1;
          brightness = 0.7;
          vibrancy = 0;
          popups = false;
          popups_ignorealpha = 1;
        };

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };

        rounding = 10;
      };

      animations = {
        enabled = true;

        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];

        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fadehyprlan"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };

      misc = {
        disable_hyprland_logo = false;
        disable_splash_rendering = true;
      };

      # =======
      # Keybinds
      # =======
      # Apps
      bind = [
        "$mainMod, Return, exec, alacritty msg --socket \"$XDG_RUNTIME_DIR/alacritty.sock\" create-window || alacritty --socket \"$XDG_RUNTIME_DIR/alacritty.sock\""
        "$mainMod SHIFT, Return, exec, llame"
        "$mainMod, D, exec, smsh ~/.config/smsh/prompt.lua | xargs sh -c"
        "$mainMod, W, exec, flatpak run app.zen_browser.zen"
        "$mainMod, A, exec, nemo"
        "$mainMod SHIFT, P, exec, rstroller-gui"
        "$mainMod SHIFT, E, exec, smsh ~/.config/smsh/power.lua"
        "$mainMod SHIFT, S, exec, grimblast copy area"
        ",Print, exec, smsh ~/.config/smsh/print.lua"
        ",mouse:276, exec, rstroller play-pause"
        ",mouse:21958, exec, rstroller play-pause"
        ",mouse:275, exec, xte \"key F8\""
        "ALT, mouse:276, exec, rstroller volume 0.05+"
        "ALT, mouse:275, exec, rstroller volume 0.05-"
        "$mainMod, mouse:276, exec, rstroller next"
        "$mainMod, mouse:275, exec, rstroller previous"
        "CTRL ALT, E, exec, emo"

        # General
        "$mainMod, P, pseudo" # dwindle
        "$mainMod, Q, killactive"
        "$mainMod, E, togglesplit" # dwindle
        "$mainMod SHIFT, F, togglefloating"
        "$mainMod, t, togglegroup" # tab
        "$mainMod, F, fullscreen"
        "$mainMod SHIFT, T, pin"

        # Move focus with mainMod + vim keys
        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"

        # Named workspaces
        "$mainMod, I, exec, smsh ~/.config/smsh/prompt.lua ~/.config/smsh/prompt.css | xargs hyprctl dispatch workspace name:"
        "$mainMod SHIFT, I, exec,  smsh ~/.config/smsh/prompt.lua ~/.config/smsh/prompt.css | xargs hyprctl dispatch movetoworkspace name:"

        # Scratchpad
        "$mainMod SHIFT, minus, movetoworkspace, special:scratchpad"
        "$mainMod, minus, togglespecialworkspace, scratchpad"

        # Move window with mainMod + SHIFT + vim keys
        "$mainMod SHIFT, h, movewindow, l"
        "$mainMod SHIFT, l, movewindow, r"
        "$mainMod SHIFT, k, movewindow, u"
        "$mainMod SHIFT, j, movewindow, d"

        # Move workspace around monitors with mainMod + Shift + </> keys
        "$mainMod SHIFT, comma, movecurrentworkspacetomonitor, -1"
        "$mainMod SHIFT, period, movecurrentworkspacetomonitor, +1"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod, M, workspace, name:mail"

        # Navigate workspaces with Ctrl + Alt + Arrow
        "CONTROL ALT, LEFT, workspace, e-1"
        "CONTROL ALT, RIGHT, workspace, e+1"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
        "$mainMod SHIFT, M, movetoworkspace, name:mail"

        # Move silent active window to a workspace with mainMod + Ctrl + [0-9]
        "$mainMod CTRL, 1, movetoworkspacesilent, 1"
        "$mainMod CTRL, 2, movetoworkspacesilent, 2"
        "$mainMod CTRL, 3, movetoworkspacesilent, 3"
        "$mainMod CTRL, 4, movetoworkspacesilent, 4"
        "$mainMod CTRL, 5, movetoworkspacesilent, 5"
        "$mainMod CTRL, 6, movetoworkspacesilent, 6"
        "$mainMod CTRL, 7, movetoworkspacesilent, 7"
        "$mainMod CTRL, 8, movetoworkspacesilent, 8"
        "$mainMod CTRL, 9, movetoworkspacesilent, 9"
        "$mainMod CTRL, 0, movetoworkspacesilent, 10"
        "$mainMod CTRL, M, movetoworkspacesilent, name:mail"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # Media keys
      bindle = [
        ",XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute,exec,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioPlay,exec,rstroller play-pause"
        ",XF86AudioPause,exec,rstroller play-pause"
        ",XF86AudioNext,exec,rstroller next"
        ",XF86AudioPrev,exec,rstroller previous"
      ];

      # =======
      # Window Rules
      # =======
      windowrulev2 = [
        "float,class:^(cafe.ndo.Llame)$"
        "noanim,class:^(cafe.ndo.Llame)$"
        "center,class:^(cafe.ndo.Llame)$"
        "size 550 300,class:^(cafe.ndo.Llame)$"

        "float,class:^(cafe.ndo.Rstroller)$"
        "noanim,class:^(cafe.ndo.Rstroller)$"
        "center,class:^(cafe.ndo.Rstroller)$"
        "size 250 200,class:^(cafe.ndo.Rstroller)$"

        "float,class:^(cafe.ndo.SMSH)(.*)$"
        "noanim,class:^(cafe.ndo.SMSH)(.*)$"
        "center,class:^(cafe.ndo.SMSH)(.*)$"
        "size 0 0,class:^(cafe.ndo.SMSH)(.*)$"

        "float,class:^(cafe.ndo.Emo)$"
        "noanim,class:^(cafe.ndo.Emo)$"
        "center,class:^(cafe.ndo.Emo)$"
        "size 450 200,class:^(cafe.ndo.Emo)$"
      ];
    };
  };
}
