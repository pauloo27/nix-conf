{ pkgs, inputs, ... }:
{

  imports = [
    # base os stuff
    ../../shared/home/linux.nix

    # generic crap most stuff currently need
    ../../shared/home/base.nix
    ../../shared/home/base-gui.nix

    # shell stuff
    ../../shared/home/shell/zsh.nix
    ../../shared/home/shell/bash.nix
    ../../shared/home/cli/git.nix
    ../../shared/home/cli/tmux.nix

    # desktop
    (import ../../shared/home/desktop/niri/niri.nix [
      ../../shared/home/desktop/niri/input-swapescape.kdl
      ./niri-monitors.kdl
      ../../shared/home/desktop/niri/wallpaper-default.kdl
    ])
    ../../shared/home/desktop/niri/waybar_laptop.nix

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
