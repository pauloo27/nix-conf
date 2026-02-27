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
    grim
    slurp
    hyprpicker
    swappy
    wl-screenrec
    niri
    xwayland-satellite
  ];

  programs.swaylock = {
    enable = true;
  };

  # TODO: replace? i mean, if it works on niri, should be fine right??
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
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
    config.common = {
      default = [ "gtk" ];
      "org.freedesktop.impl.portal.Screenshot" = [ "gnome" ];
      "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
    };
  };

  xdg.configFile."niri/config.kdl".text = base + "\n" + extras;
}
