{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    tldr = {
      url = "https://github.com/pauloo27/tldr.git";
      type = "git";
      ref = "master";
    };
    f = {
      url = "https://code.db.cafe/pauloo27/f.git";
      type = "git";
      ref = "master";
    };
  };

  outputs = { nixpkgs, home-manager, nix-flatpak, f, tldr, ... } @inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations.karen = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/karen/configuration.nix
        ];
      };
      homeConfigurations.karen = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./hosts/karen/home.nix
        ];

        extraSpecialArgs = {
          inherit f tldr;
        };
      };

      nixosConfigurations.nancy = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/nancy/configuration.nix
          nix-flatpak.nixosModules.nix-flatpak
        ];
      };
      homeConfigurations.nancy = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./hosts/nancy/home.nix
        ];

        extraSpecialArgs = {
          inherit f tldr;
        };
      };

      homeConfigurations.zita = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./hosts/zita/home.nix
        ];

        extraSpecialArgs = {
          inherit f tldr;
        };
      };

      homeConfigurations.melinda = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./hosts/melinda/home.nix
        ];

        extraSpecialArgs = {
          inherit f tldr;
        };
      };
    };
}
