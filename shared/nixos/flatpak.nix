{ pkgs, ... }: {
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
}
