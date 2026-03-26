{ pkgs, ... }:
{
  imports = [
    # base os stuff
    ../../shared/home/linux.nix
    ../../shared/home/non-nix.nix

    # generic crap most stuff currently need
    ../../shared/home/base.nix

    # shell stuff
    ../../shared/home/shell/zsh.nix
    ../../shared/home/shell/git.nix
    ../../shared/home/shell/tmux.nix

    # desktop
    (import ../../shared/home/desktop/niri/niri.nix [
      ../../shared/home/desktop/niri/input-swapescape.kdl
      ./niri-monitors.kdl
    ])
    ../../shared/home/desktop/niri/waybar_laptop.nix

    # apps
    ../../shared/home/apps/voxtype-cpu.nix

    # infra
    ../../shared/home/infra.nix

    # nvim + langs
    ../../shared/home/editor/nvim/nvim.nix
    ../../shared/home/editor/nvim/langs/lua.nix
    ../../shared/home/editor/nvim/langs/go.nix
    ../../shared/home/editor/nvim/langs/tailwindcss.nix
    ../../shared/home/editor/nvim/langs/js_and_ts.nix
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
