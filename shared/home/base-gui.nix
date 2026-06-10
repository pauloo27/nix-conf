{ pkgs, rstroller, ... }:
{
  home.packages = [
    pkgs.xfconf
    pkgs.dbeaver-bin
    rstroller.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
