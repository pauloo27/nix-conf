{ pkgs, ... }:
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

  xdg.configFile."niri/config.kdl".source = ./config.kdl;
}
