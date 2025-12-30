{ pkgs, f, ... }: {
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
    pkgs.nerd-fonts.space-mono
    f.defaultPackage.${pkgs.system}
  ];
  
  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;

  services.gpg-agent.enable = true;
  services.gpg-agent.pinentryPackage = with pkgs; pinentry-tty;
  programs.gpg.enable = true;
  services.ssh-agent.enable = true;

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };
}
