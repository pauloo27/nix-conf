{ ... }:
{
  imports = [
    # generic crap most stuff currently need
    ../../shared/home/base.nix

    # shell stuff
    ../../shared/home/shell/zsh.nix
    ../../shared/home/cli/git.nix
  ];

  home.stateVersion = "26.05";
  home.username = "paulo";
  home.homeDirectory = "/Users/paulo";
}
