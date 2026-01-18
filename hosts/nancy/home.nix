{ pkgs, inputs, ... }:
{

  imports = [
    ../../shared/base.nix
    ../../shared/zsh.nix
    ../../shared/git.nix
    ../../shared/tmux.nix
    ../../shared/desktop.nix
    ../../shared/linux.nix
    ../../shared/hyprland.nix
    ../../shared/waybar_laptop.nix
  ];

  home.packages = [
    pkgs.hello
  ];

  home.stateVersion = "25.05";
  home.username = "paulo";
  home.homeDirectory = "/home/paulo";
}
