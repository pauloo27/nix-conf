{ pkgs, rstroller, ... }:
{
  home.packages = [
    pkgs.xfconf
    pkgs.dbeaver-bin
    pkgs.freelens-bin
    pkgs.postman
    rstroller.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
