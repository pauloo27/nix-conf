{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.niri.enable = true;

  services.displayManager.gdm.enable = true;

  security.pam.services.swaylock = { };
}
