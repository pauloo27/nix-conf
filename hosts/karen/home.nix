{ pkgs, f, ... }: {
  imports = [
    ../shared/home.nix
  ];

  home.packages = [ ];

  home.stateVersion = "24.05";
  home.username = "paulo";
  home.homeDirectory = "/home/paulo";
}
