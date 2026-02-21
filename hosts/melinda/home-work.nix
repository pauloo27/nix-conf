{ pkgs, lib, ... }:
{
  imports = [
    ../../shared/home/base.nix
    ../../shared/home/zsh.nix
    ../../shared/home/git.nix
    ../../shared/home/tmux.nix
    ../../shared/home/linux.nix
    ../../shared/home/non-nix.nix
  ];

  home.stateVersion = "25.05";
  home.username = "work";
  home.homeDirectory = "/home/work";
}
