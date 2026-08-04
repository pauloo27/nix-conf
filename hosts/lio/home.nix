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
  ];

  home.stateVersion = "26.05";
  home.username = "paulo";
  home.homeDirectory = "/Users/paulo";
}
