{ pkgs, llame, config, ... }: {
  home.packages = [
    pkgs.wl-clipboard
    pkgs.nemo
    llame.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  programs.alacritty = {
    enable = true;
    theme = "rose_pine";
    settings = {

      window = {
        opacity = 0.9;
        padding = {
          x = 10;
          y = 10;
        };
      };

      font = {
        normal = {
          family = "UbuntuMono Nerd Font";
          style = "Regular";
        };
        size = 12;
      };

      cursor = {
        style = {
          blinking = "On";
        };
      };

      mouse = {
        hide_when_typing = true;
      };
    };
  };

  xdg.configFile."llame/style.css".source = ./llame-style.css;
  xdg.configFile."llame/config.toml".text = ''
    css_file_path = "${config.home.homeDirectory}/.config/llame/style.css"
  '';
}
