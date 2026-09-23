{ ... }:
{
  services.ntfy-sh = {
    enable = true;
    settings = {
      base-url = "http://kraken.ndo.cafe:2586";
      # kraken.ndo.cafe -> tailscale0
      listen-http = "100.123.26.28:2586";
      # iOS can only be woken through APNs, which ntfy.sh relays for us
      upstream-base-url = "https://ntfy.sh";
    };
  };

  # the bind address only exists once tailscaled has configured tailscale0, so
  # wait for it and keep retrying instead of failing the boot outright
  systemd.services.ntfy-sh = {
    after = [ "tailscaled.service" ];
    wants = [ "tailscaled.service" ];
    unitConfig.StartLimitIntervalSec = 0;
    serviceConfig = {
      Restart = "on-failure";
      RestartSec = "5s";
    };
  };

  networking.firewall.extraCommands = ''
    iptables -A INPUT -i tailscale0 -p tcp --dport 2586 -j ACCEPT
  '';
}
