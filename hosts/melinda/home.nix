{ pkgs, ... }:
{
  imports = [
    ../../shared/base.nix
    ../../shared/zsh.nix
    ../../shared/git.nix
    ../../shared/desktop.nix
    ../../shared/tmux.nix
    ../../shared/linux.nix
    ../../shared/non-nix.nix
  ];

  home.packages = [
    pkgs.hello
    pkgs.terraform
  ];

  # Override caps:swapescape for desktop (not needed with custom keyboard)
  wayland.windowManager.hyprland.settings.input.kb_options = "";

  home.stateVersion = "25.05";
  home.username = "paulo";
  home.homeDirectory = "/home/paulo";
}
