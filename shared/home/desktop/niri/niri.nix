# TODO: fix screenshot (replace grimblast with grim+slurp)
# TODO: fix portals so screen sharing works
extraConfigs:
{ pkgs, ... }:
let
  base = builtins.readFile ./base.kdl;
  extras = builtins.concatStringsSep "\n" (map builtins.readFile extraConfigs);
in
{
  imports = [
    ../fonts.nix
    ../../apps/flatpak.nix
    ../gtk.nix
    ../../apps/alacritty.nix
    ../../apps/llame.nix
    ../../apps/mpv.nix
    ../smsh/smsh.nix
    ./waybar.nix
  ];

  home.packages = with pkgs; [
    wl-clipboard
    nemo
    xfce.ristretto
    xarchiver
    xfce.xfce4-notifyd
    pavucontrol
    niri
    xwayland-satellite
    # used in the screenshot tool
    grimblast
    hyprpicker
  ];

  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      preload = "/home/paulo/medias/pictures/wp.png";
      wallpaper = ",/home/paulo/medias/pictures/wp.png";
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-gnome ];
    config.common = {
      default = [ "gtk" ];
      "org.freedesktop.impl.portal.Screenshot" = [ "gnome" ];
      "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
    };
  };

  xdg.configFile."niri/config.kdl".text = base + "\n" + extras;
}
