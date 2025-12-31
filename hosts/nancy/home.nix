{ pkgs, inputs, ... }: {

  imports = [
    ../../shared/home.nix
    ../../shared/desktop.nix
    ../../shared/shared-linux.nix
  ];

  home.packages = [ 
    pkgs.hello
  ];

  home.stateVersion = "25.05";
  home.username = "paulo";
  home.homeDirectory = "/home/paulo";
}
