{ pkgs, ... }:
{
  imports = [
    ../../shared/base.nix
    ../../shared/zsh.nix
    ../../shared/desktop.nix
    ../../shared/waybar_laptop.nix
    ../../shared/git.nix
    ../../shared/tmux.nix
    ../../shared/linux.nix
    ../../shared/non-nix.nix
  ];

  home.packages = [
    pkgs.hello
  ];

  wayland.windowManager.hyprland.settings.monitor = "eDP-1,1920x1080@60,0x0,1";

  home.stateVersion = "25.05";
  home.username = "paulo";
  home.homeDirectory = "/home/paulo";
}
