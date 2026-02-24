{ pkgs, inputs, ... }:
{

  imports = [
    ../../shared/home/base.nix
    ../../shared/home/zsh.nix
    ../../shared/home/git.nix
    ../../shared/home/tmux.nix
    ../../shared/home/hyprland.nix
    ../../shared/home/waybar_laptop.nix
    ../../shared/home/linux.nix

    # nvim + langs
    ../../shared/home/nvim/nvim.nix
    ../../shared/home/nvim/langs/lua.nix
    ../../shared/home/nvim/langs/go.nix
    ../../shared/home/nvim/langs/nix.nix
  ];

  home.packages = [
    pkgs.hello
  ];

  home.stateVersion = "25.05";
  home.username = "paulo";
  home.homeDirectory = "/home/paulo";
}
