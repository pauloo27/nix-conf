{ ... }:

{
  # Nix itself was installed by the upstream installer; leave it alone.
  nix.enable = false;

  # Shells come from home-manager; don't let nix-darwin own /etc/{zshrc,bashrc}.
  programs.zsh.enable = false;
  programs.bash.enable = false;

  system.primaryUser = "paulo";
  system.stateVersion = 7;

  homebrew = {
    enable = true;
    brews = [ "docker-compose" ];
    casks = [
      "ghostty"
      "podman-desktop"
      "microsoft-teams"
      "slack"
      "zed"
    ];
    onActivation.cleanup = "zap";
  };
}
