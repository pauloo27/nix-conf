{ ... }:

{
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
