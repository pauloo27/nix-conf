{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  services.displayManager.gdm.enable = true;

  security.pam.services.hyprlock = { };
}
