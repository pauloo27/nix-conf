{ pkgs, ... }:
{
  imports = [
    ../../shared/home/base.nix
    ../../shared/home/shell/zsh.nix
    ../../shared/home/desktop/hyprland/hyprland.nix
    ../../shared/home/desktop/hyprland/waybar_laptop.nix
    ../../shared/home/shell/git.nix
    ../../shared/home/shell/tmux.nix
    ../../shared/home/linux.nix
    ../../shared/home/non-nix.nix

    # nvim + langs
    ../../shared/home/editor/nvim/nvim.nix
    ../../shared/home/editor/nvim/langs/lua.nix
    ../../shared/home/editor/nvim/langs/go.nix
    ../../shared/home/editor/nvim/langs/nix.nix
  ];

  home.packages = [
    pkgs.hello
  ];

  wayland.windowManager.hyprland.settings.monitor = "eDP-1,1920x1080@60,0x0,1";

  home.stateVersion = "25.05";
  home.username = "paulo";
  home.homeDirectory = "/home/paulo";
}
