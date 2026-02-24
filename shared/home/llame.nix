{
  pkgs,
  llame,
  config,
  ...
}:
{
  home.packages = [
    llame.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  xdg.configFile."llame/style.css".source = ./llame-style.css;
  xdg.configFile."llame/config.toml".text = ''
    css_file_path = "${config.home.homeDirectory}/.config/llame/style.css"
  '';
}
