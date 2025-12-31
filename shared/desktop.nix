{ pkgs, ... }: {
  programs.firefox.enable = true;

  home.packages = [
    pkgs.wl-clipboard
  ];
}
