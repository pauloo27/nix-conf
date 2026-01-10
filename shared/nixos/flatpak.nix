{ pkgs, ... }:
{
  services.flatpak = {
    enable = true;
    packages = [
      "io.github.zen_browser.zen"
      "com.discordapp.Discord"
    ];
    update.auto = {
      enable = true;
      onCalendar = "daily";
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
