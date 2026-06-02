# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../shared/nixos/base.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "nodev";

  networking.hostName = "kraken"; # Define your hostname.
  networking.hostId = "e9a52955";

  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.extraPools = [ "tank" ];

  networking.networkmanager.enable = true;
  networking = {
    nameservers = [
      "1.1.1.1"
      "9.9.9.9"
    ];
    interfaces.ens18 = {
      ipv4.addresses = [
        {
          address = "10.0.0.77";
          prefixLength = 24;
        }
      ];
    };
    defaultGateway = {
      address = "10.0.0.10";
      interface = "ens18";
    };
  };

  time.timeZone = "America/Sao_Paulo";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.zsh.enable = true;

  users.users.paulo = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJZi/6VQsVTQLy58jWcG33/JttCoLfaweRX26U2gQ1JD git@pauloo27.dev"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFA9yA40Dw4MrwGXTOFEXbiBQFWNGXTgf6hsyegFYpn5 paulo@melinda"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICqkEFlxrpkOMDPJyt8f6MXniTWuTS82tcQFf5dfExNX paulo@zita"
    ];
  };

  # programs.firefox.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  services.thermald.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  environment.systemPackages = with pkgs; [
    git
    smartmontools
    sdparm
    sysstat
  ];

  services.zfs = {
    autoScrub = {
      enable = true;
      interval = "monthly";
      pools = [ "tank" ];
    };
  };

  services.k3s = {
    enable = true;
    role = "server";
    clusterInit = true;
    extraFlags = "--default-local-storage-path /data/k3s/storage --tls-san k8s.kraken.db.cafe --tls-san kraken.ndo.cafe --tls-san 10.0.0.77 --tls-san 100.123.26.28";
  };

  networking.firewall.extraCommands = ''
    iptables -A INPUT -p tcp -s 10.0.0.0/24 --dport 6443 -j ACCEPT
    iptables -A INPUT -i tailscale0 -p tcp --dport 6443 -j ACCEPT
    iptables -A INPUT -p tcp -s 10.0.0.0/24 --dport 22 -j ACCEPT
    iptables -A INPUT -i tailscale0 -p tcp --dport 22 -j ACCEPT
  '';

  services.smartd = {
    enable = true;
    devices = [
      { device = "/dev/sdb"; }
      { device = "/dev/sdc"; }
      { device = "/dev/sdd"; }
      { device = "/dev/sde"; }
      { device = "/dev/sdf"; }
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs.htop = {
    enable = true;
    settings.show_cpu_temperature = 1;
  };

  # services.openvpn.servers = {
  #   kraken = {
  #     config = "config /etc/ovpn/kraken/kraken.ovpn";
  #   };
  # };

  services.openssh = {
    enable = true;
    openFirewall = false;
    settings.PermitRootLogin = "no";
    settings.PasswordAuthentication = false;
  };

  services.tailscale.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?

}
