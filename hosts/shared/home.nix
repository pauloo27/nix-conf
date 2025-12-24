{ pkgs, f, ... }: {
  imports = [
    ./zsh.nix
    ./git.nix
    ./tmux.nix
  ];

  # Common packages for all hosts
  home.packages = [
    pkgs.ripgrep 
    pkgs.k9s 
    pkgs.go 
    pkgs.gopls
    pkgs.kubectl 
    pkgs.nerd-fonts.space-mono
    f.defaultPackage.${pkgs.system}
  ];
  
  fonts.fontconfig.enable = true;

  # Common home-manager settings
  programs.home-manager.enable = true;

  # Enable SSH agent
  services.ssh-agent.enable = true;

  # SSH configuration
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };
}
