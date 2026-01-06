{ pkgs, f, ... }: {
  imports = [
    ../../shared/base.nix
    ../../shared/zsh.nix
    ../../shared/git.nix
    ../../shared/tmux.nix
    ../../shared/linux.nix
  ];

  home.packages = [ ];

  home.stateVersion = "24.05";
  home.username = "paulo";
  home.homeDirectory = "/home/paulo";
}
