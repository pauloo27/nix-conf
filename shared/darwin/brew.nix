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
      "jellyfin-media-player"
      "discord"
      "stremio"
      "pear-devs/pear/pear-desktop"
      "obsidian"
      "zed"
    ];
    onActivation.cleanup = "zap";
  };
}
