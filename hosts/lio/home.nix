{ ... }:
{
  imports = [
    # generic crap most stuff currently need
    ../../shared/home/base.nix

    # shell stuff
    ../../shared/home/shell/zsh.nix
    ../../shared/home/shell/bash.nix
    ../../shared/home/cli/git.nix
    ../../shared/home/cli/tmux.nix

    # infra
    ../../shared/home/infra.nix

    # apps
    ../../shared/home/apps/ghostty.nix

    # nvim + langs
    ../../shared/home/editor/nvim/nvim.nix
    ../../shared/home/editor/nvim/langs/lua.nix
    ../../shared/home/editor/nvim/langs/go.nix
    ../../shared/home/editor/nvim/langs/nix.nix
    ../../shared/home/editor/nvim/langs/js_and_ts.nix
    ../../shared/home/editor/nvim/langs/tailwindcss.nix
  ];

  home.stateVersion = "26.05";
  home.username = "paulo";
  home.homeDirectory = "/Users/paulo";
}
