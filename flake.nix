{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    tldr.url = "github:pauloo27/tldr";
    f = {
      url = "https://code.db.cafe/pauloo27/f.git";
      type = "git";
      ref = "master";
    };
  };

  outputs = { nixpkgs, home-manager, nix-flatpak, f, tldr, ... } @inputs:
    let
      lib = nixpkgs.lib;

      hosts = {
        karen = {
          isNixOS = true;
          arch = "x86_64-linux";
          extraNixosModules = [];
        };
        nancy = {
          isNixOS = true;
          arch = "x86_64-linux";
          extraNixosModules = [nix-flatpak.nixosModules.nix-flatpak];
        };
        zita = {
          isNixOS = false;
          arch = "x86_64-linux";
          extraNixosModules = [];
        };
        melinda = {
          isNixOS = false;
          arch = "x86_64-linux";
          extraNixosModules = [];
        };
      };

      mkNixosSystem = name: config:
        nixpkgs.lib.nixosSystem {
          modules = [
            { nixpkgs.hostPlatform = config.arch; }
            ./hosts/${name}/configuration.nix
          ] ++ config.extraNixosModules;
        };

      mkHomeSystem = name: config:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${config.arch};
          modules = [ ./hosts/${name}/home.nix ];
          extraSpecialArgs = {
            inherit f tldr;
          };
        };

    in {
      # Generate NixOS configurations for hosts with isNixOS = true
      nixosConfigurations = lib.filterAttrs (_: v: v != {}) (
        lib.mapAttrs (name: config:
          if config.isNixOS
          then mkNixosSystem name config
          else {}
        ) hosts
      );

      # Generate Home Manager configurations for all hosts
      homeConfigurations = lib.mapAttrs (name: config:
        mkHomeSystem name config
      ) hosts;
    };
}
