{ pkgs, tldr, f, ... }: {
  imports = [
    ./zsh.nix
    ./git.nix
    ./tmux.nix
  ];

  # Common packages for all hosts
  home.packages = [
    pkgs.ripgrep 
    pkgs.gcc 
    pkgs.k9s 
    pkgs.go 
    pkgs.gopls
    pkgs.kubectl 
    pkgs.nerd-fonts.ubuntu-mono
    f.defaultPackage.${pkgs.system}
    tldr.packages.${pkgs.system}.default
  ];
  
  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;

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
