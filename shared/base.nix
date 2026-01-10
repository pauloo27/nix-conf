{ pkgs, tldr, f, ... }: {
  imports = [
    tldr.homeManagerModules.default
  ];

  nixpkgs.config.allowUnfree = true;

  # Common packages for all hosts
  home.packages = [
    pkgs.clang
    pkgs.ripgrep
    pkgs.claude-code
    pkgs.btop
    pkgs.k9s
    pkgs.kubectl
    pkgs.glow
    pkgs.file
    f.packages.${pkgs.stdenv.hostPlatform.system}.default
    # TODO: remove this in favor of per-project flake
    pkgs.go
    pkgs.gopls
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

  services.gpg-agent.enable = true;
  services.gpg-agent.pinentry.package = with pkgs; pinentry-curses;
  programs.gpg.enable = true;
  services.ssh-agent.enable = true;

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."*".addKeysToAgent = "yes";
  };
}
