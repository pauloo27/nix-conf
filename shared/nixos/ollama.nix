{ ... }:
{
  services.ollama = {
    enable = true;
    # kraken.ndo.cafe -> tailscale0
    host = "100.123.26.28";
  };

  networking.firewall.extraCommands = ''
    iptables -A INPUT -i tailscale0 -p tcp --dport 11434 -j ACCEPT
  '';
}
