{ pkgs, ... }: {
  home.packages = [
    pkgs.wl-clipboard
    pkgs.nemo
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

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "app.zen_browser.zen.desktop";
      "x-scheme-handler/http" = "app.zen_browser.zen.desktop";
      "x-scheme-handler/https" = "app.zen_browser.zen.desktop";
      "x-scheme-handler/about" = "app.zen_browser.zen.desktop";
      "x-scheme-handler/unknown" = "app.zen_browser.zen.desktop";
    };
  };
}
