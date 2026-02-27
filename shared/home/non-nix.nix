{ lib, ... }:
{
  targets.genericLinux.enable = true;

  # Don't install swaylock/hyprlock package (use system package), but keep config
  programs.hyprlock.package = lib.mkForce null;
  programs.swaylock.package = lib.mkForce null;

  # Add user flatpak data directory for application launchers
  home.sessionVariables = {
    XDG_DATA_DIRS = lib.mkForce "\${NIX_STATE_DIR:-/nix/var/nix}/profiles/default/share:$HOME/.nix-profile/share:$HOME/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/share/ubuntu:/usr/local/share:/usr/share:/var/lib/snapd/desktop\${XDG_DATA_DIRS:+:$XDG_DATA_DIRS}";
  };
}
