{ lib, ... }:
{
  targets.genericLinux.enable = true;

  # Don't install hyprlock package (use system package), but keep config
  programs.hyprlock.package = lib.mkForce null;
}
