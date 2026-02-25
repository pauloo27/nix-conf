{ pkgs, inputs, ... }:
{

  imports = [
    # base os stuff
    ../../shared/home/linux.nix

    # generic crap most stuff currently need
    ../../shared/home/base.nix

    # shell stuff
    ../../shared/home/shell/zsh.nix
    ../../shared/home/shell/git.nix
    ../../shared/home/shell/tmux.nix

    # desktop
    ../../shared/home/desktop/hyprland/hyprland.nix
    ../../shared/home/desktop/hyprland/waybar_laptop.nix

    # nvim + langs
    ../../shared/home/editor/nvim/nvim.nix
    ../../shared/home/editor/nvim/langs/lua.nix
    ../../shared/home/editor/nvim/langs/go.nix
    ../../shared/home/editor/nvim/langs/nix.nix
  ];

  home.packages = [
    pkgs.hello
  ];

  home.stateVersion = "25.05";
  home.username = "paulo";
  home.homeDirectory = "/home/paulo";
}
