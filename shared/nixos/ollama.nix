{ ... }:
{
  services.ollama = {
    enable = true;
    # kraken.ndo.cafe -> tailscale0
    host = "100.123.26.28";
  };

  # the bind address only exists once tailscaled has configured tailscale0, so
  # wait for it and keep retrying instead of failing the boot outright
  systemd.services.ollama = {
    after = [ "tailscaled.service" ];
    wants = [ "tailscaled.service" ];
    unitConfig.StartLimitIntervalSec = 0;
    serviceConfig = {
      Restart = "on-failure";
      RestartSec = "5s";
    };
  };

  networking.firewall.extraCommands = ''
    iptables -A INPUT -i tailscale0 -p tcp --dport 11434 -j ACCEPT
  '';
}
