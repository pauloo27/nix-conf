{
  pkgs,
  llame,
  config,
  ...
}:
{
  imports = [
    ./fonts.nix
    ./flatpak.nix
    ./smsh/smsh.nix
    ./waybar.nix
    ./gtk.nix
    ./alacritty.nix
  ];

  home.packages = [
    pkgs.wl-clipboard
    pkgs.nemo
    pkgs.eog
    llame.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  xdg.configFile."llame/style.css".source = ./llame-style.css;
  xdg.configFile."llame/config.toml".text = ''
    css_file_path = "${config.home.homeDirectory}/.config/llame/style.css"
  '';
}
