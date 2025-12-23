{ pkgs, ... }: {
  imports = [
    ../shared/home.nix
  ];

  home.packages = [ 
    pkgs.hello
  ];

  home.stateVersion = "25.05";
  home.username = "paulo";
  home.homeDirectory = "/home/paulo";
}
