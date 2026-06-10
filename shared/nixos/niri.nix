{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.niri.enable = true;

  services.displayManager.gdm.enable = true;
  services.displayManager.sessionPackages = [ pkgs.niri ];

  security.pam.services.swaylock = { };
}
