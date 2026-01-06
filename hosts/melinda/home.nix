{ pkgs, ... }: {
  imports = [
    ../../shared/base.nix
    ../../shared/zsh.nix
    ../../shared/git.nix
    ../../shared/tmux.nix
    ../../shared/linux.nix
  ];

  home.packages = [ 
    pkgs.hello
  ];

  home.stateVersion = "25.05";
  home.username = "paulo";
  home.homeDirectory = "/home/paulo";
}
