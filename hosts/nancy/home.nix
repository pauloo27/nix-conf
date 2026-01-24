{ pkgs, inputs, ... }:
{

  imports = [
    ../../shared/home/base.nix
    ../../shared/home/zsh.nix
    ../../shared/home/git.nix
    ../../shared/home/tmux.nix
    ../../shared/home/desktop.nix
    ../../shared/home/waybar_laptop.nix
    ../../shared/home/linux.nix
  ];

  home.packages = [
    pkgs.hello
  ];

  home.stateVersion = "25.05";
  home.username = "paulo";
  home.homeDirectory = "/home/paulo";
}
