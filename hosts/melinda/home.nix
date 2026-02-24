{ pkgs, lib, ... }:
{
  imports = [
    ../../shared/home/base.nix
    ../../shared/home/zsh.nix
    ../../shared/home/git.nix
    ../../shared/home/desktop.nix
    ../../shared/home/tmux.nix
    ../../shared/home/linux.nix
    ../../shared/home/non-nix.nix

    # nvim + langs
    ../../shared/home/nvim/nvim.nix
    ../../shared/home/nvim/langs/lua.nix
    ../../shared/home/nvim/langs/go.nix
    ../../shared/home/nvim/langs/rust.nix
    ../../shared/home/nvim/langs/nix.nix
    ../../shared/home/nvim/langs/js_and_ts.nix
    ../../shared/home/nvim/langs/svelte.nix
    ../../shared/home/nvim/langs/tailwindcss.nix
    ../../shared/home/nvim/langs/terraform.nix
    ../../shared/home/nvim/langs/yaml.nix
    ../../shared/home/nvim/langs/helm.nix
  ];

  home.packages = [
    pkgs.hello
  ];

  # Override caps:swapescape for desktop (not needed with custom keyboard)
  wayland.windowManager.hyprland.settings.input.kb_options = lib.mkForce "";

  # Monitor setup
  wayland.windowManager.hyprland.settings.monitor = [
    "DP-1,1920x1080@144,1080x600,1"
    "HDMI-A-1,2560x1080@75,0x0,1,transform,1"
  ];

  # Override wallpaper
  services.hyprpaper.settings = lib.mkForce {
    preload = [
      "/home/paulo/medias/pictures/wallpapers/enabled/1.jpg"
      "/home/paulo/medias/pictures/wallpapers/enabled/2.png"
    ];
    wallpaper = [
      "HDMI-A-1,/home/paulo/medias/pictures/wallpapers/enabled/1.jpg"
      "DP-1,/home/paulo/medias/pictures/wallpapers/enabled/2.png"
    ];
  };

  home.stateVersion = "25.05";
  home.username = "paulo";
  home.homeDirectory = "/home/paulo";
}
