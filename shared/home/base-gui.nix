{ pkgs, rstroller, ... }:
{
  home.packages = [
    pkgs.xfce.xfconf
    pkgs.dbeaver-bin
    rstroller.packages.${pkgs.system}.default
  ];
}
