{ pkgs, ... }:
{
  imports = [
    ../../shared/home/base.nix
    ../../shared/home/zsh.nix
    ../../shared/home/desktop.nix
    ../../shared/home/waybar_laptop.nix
    ../../shared/home/git.nix
    ../../shared/home/tmux.nix
    ../../shared/home/linux.nix
    ../../shared/home/non-nix.nix
  ];

  home.packages = [
    pkgs.hello
  ];

  wayland.windowManager.hyprland.settings.monitor = "eDP-1,1920x1080@60,0x0,1";

  home.stateVersion = "25.05";
  home.username = "paulo";
  home.homeDirectory = "/home/paulo";
}
