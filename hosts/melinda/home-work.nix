{ pkgs, lib, ... }:
{
  imports = [
    ../../shared/home/base.nix
    ../../shared/home/shell/zsh.nix
    ../../shared/home/shell/git.nix
    ../../shared/home/shell/tmux.nix
    ../../shared/home/linux.nix
    ../../shared/home/non-nix.nix

    # desktop
    (import ../../shared/home/desktop/niri/niri.nix [
      ../../shared/home/desktop/niri/input.kdl
      ./niri-monitors.kdl
    ])

    # nvim + langs
    ../../shared/home/editor/nvim/nvim.nix
    ../../shared/home/editor/nvim/langs/lua.nix
    ../../shared/home/editor/nvim/langs/go.nix
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
      "/home/work/medias/pictures/wallpapers/enabled/1.jpg"
      "/home/work/medias/pictures/wallpapers/enabled/2.jpg"
    ];
    wallpaper = [
      "HDMI-A-1,/home/work/medias/pictures/wallpapers/enabled/1.jpg"
      "DP-1,/home/work/medias/pictures/wallpapers/enabled/2.jpg"
    ];
  };

  home.stateVersion = "25.05";
  home.username = "work";
  home.homeDirectory = "/home/work";
}
