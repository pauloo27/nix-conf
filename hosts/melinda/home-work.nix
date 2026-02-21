{ pkgs, lib, ... }:
{
  imports = [
    ../../shared/home/base.nix
    ../../shared/home/zsh.nix
    ../../shared/home/git.nix
    ../../shared/home/desktop.nix
    ../../shared/home/tmux.nix
    ../../shared/home/linux.nix
    ../../shared/home/non-nix.nix
    ../../shared/home/nvim/nvim.nix
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
