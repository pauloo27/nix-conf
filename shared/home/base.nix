{
  pkgs,
  config,
  tldr,
  f,
  nixpkgs,
  ...
}:
{
  imports = [
    tldr.homeManagerModules.default
  ];

  nixpkgs.config.allowUnfree = true;

  nix.registry.nixpkgs.flake = nixpkgs;
  nix.settings.nix-path = [ "nixpkgs=flake:nixpkgs" ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  home.sessionPath = [
    "$HOME/.nix-profile/bin"
  ];

  # Common packages for all hosts
  home.packages = [
    pkgs.cloudflared
    pkgs.ripgrep
    pkgs.claude-code
    pkgs.curl
    pkgs.netcat-openbsd
    pkgs.curlie
    pkgs.btop
    pkgs.gh
    pkgs.wget
    pkgs.forgejo-cli
    pkgs.glow
    pkgs.file
    pkgs.nix-index
    pkgs.zip
    pkgs.unzip
    pkgs.imagemagick
    pkgs.rbw
    pkgs.doggo
    pkgs.wol
    pkgs.bc
    pkgs.jq
    pkgs.yq-go
    f.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  programs.home-manager.enable = true;

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.tldr-go = {
    enable = true;
    viewer = "glow";
  };

  programs.np = {
    enable = true;
    profilesPath = "${config.xdg.configHome}/nix-conf/dev";
    tmuxBaseWindowIndex = 1;
    aliases = {
      psql = {
        package = "postgresql_18";
        command = "psql";
      };
    };
  };

  services.gpg-agent.enable = true;
  services.gpg-agent.pinentry.package = with pkgs; pinentry-curses;
  programs.gpg.enable = true;
  services.ssh-agent.enable = true;

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings."*".AddKeysToAgent = "yes";
  };
}
