{ pkgs, ... }:
{
  home.packages = [
    pkgs.xfce.xfconf
    pkgs.dbeaver-bin
  ];
}
