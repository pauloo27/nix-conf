{ pkgs, ... }:
{
  imports = [
    # base os stuff
    ../../shared/home/linux.nix
    ../../shared/home/non-nix.nix

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
      ../../shared/home/desktop/niri/input.kdl
      ./niri-monitors.kdl
      ./niri-wallpaper.kdl
    ])
    ../../shared/home/desktop/opentabletdriver/opentabletdriver.nix

    # infra
    ../../shared/home/infra.nix

    # apps
    ../../shared/home/apps/teams.nix
    ../../shared/home/apps/slack.nix
    (import ../../shared/home/apps/voxtype.nix "vulkan")

    # nvim + langs
    ../../shared/home/editor/nvim/nvim.nix
    ../../shared/home/editor/nvim/langs/lua.nix
    ../../shared/home/editor/nvim/langs/go.nix
    ../../shared/home/editor/nvim/langs/rust.nix
    ../../shared/home/editor/nvim/langs/nix.nix
    ../../shared/home/editor/nvim/langs/js_and_ts.nix
    ../../shared/home/editor/nvim/langs/svelte.nix
    ../../shared/home/editor/nvim/langs/tailwindcss.nix
    ../../shared/home/editor/nvim/langs/terraform.nix
    ../../shared/home/editor/nvim/langs/yaml.nix
    ../../shared/home/editor/nvim/plugins/wakatime.nix
  ];

  home.packages = [
    pkgs.hello
  ];

  home.stateVersion = "25.05";
  home.username = "paulo";
  home.homeDirectory = "/home/paulo";
}
