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
    brews = [
      "docker-compose"
      "wireguard-tools"
    ];
    casks = [
      "ghostty"
      "vorssaint"
      "openvpn-connect"
      "freelens"
      "podman-desktop"
      "microsoft-teams"
      "slack"
      "jellyfin"
      "discord"
      "stremio"
      "obsidian"
      "zed"
    ];
    onActivation.cleanup = "zap";
  };
}
