{ pkgs, lib, ... }:
{
  imports = [
    # base os stuff
    ../../shared/home/linux.nix
    ../../shared/home/non-nix.nix

    # generic crap most stuff currently need
    ../../shared/home/base.nix

    # shell stuff
    ../../shared/home/shell/zsh.nix
    ../../shared/home/shell/git.nix
    ../../shared/home/shell/tmux.nix

    # desktop
    (import ../../shared/home/desktop/niri/niri.nix [
      ../../shared/home/desktop/niri/input.kdl
      ./niri-monitors.kdl
    ])

    # apps
    ../../shared/home/apps/teams.nix
    ../../shared/home/apps/slack.nix

    # nvim + langs
    ../../shared/home/editor/nvim/nvim.nix
    ../../shared/home/editor/nvim/langs/lua.nix
    ../../shared/home/editor/nvim/langs/go.nix
    ../../shared/home/editor/nvim/langs/rust.nix
    ../../shared/home/editor/nvim/langs/nix.nix
    ../../shared/home/editor/nvim/langs/js_and_ts.nix
    ../../shared/home/editor/nvim/langs/svelte.nix
    ../../shared/home/editor/nvim/langs/tailwindcss.nix
    ../../shared/home/editor/nvim/langs/terraform.nix
    ../../shared/home/editor/nvim/langs/yaml.nix
    ../../shared/home/editor/nvim/plugins/wakatime.nix
  ];

  home.packages = [
    pkgs.hello
  ];

  # Override caps:swapescape for desktop (not needed with custom keyboard)
  wayland.windowManager.hyprland.settings.input.kb_options = lib.mkForce "";

  # Monitor setup
  wayland.windowManager.hyprland.settings.monitor = [
    "DP-1,1920x1080@144,1080x600,1"
    "HDMI-A-1,2560x1080@75,0x0,1,transform,1"
  ];

  # Override wallpaper
  services.hyprpaper.settings = lib.mkForce {
    preload = [
      "/home/paulo/medias/pictures/wallpapers/enabled/1.jpg"
      "/home/paulo/medias/pictures/wallpapers/enabled/2.png"
    ];
    wallpaper = [
      "HDMI-A-1,/home/paulo/medias/pictures/wallpapers/enabled/1.jpg"
      "DP-1,/home/paulo/medias/pictures/wallpapers/enabled/2.png"
    ];
  };

  home.stateVersion = "25.05";
  home.username = "paulo";
  home.homeDirectory = "/home/paulo";
}
