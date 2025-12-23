{
  description = "Home Manager configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    f = {
      url = "https://code.db.cafe/pauloo27/f.git";
      type = "git";
      ref = "master";
    };
  };

  outputs = { nixpkgs, home-manager, f, ... }:
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
          inherit f;
        };
      };

      homeConfigurations.melinda = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./hosts/melinda/home.nix
        ];

        extraSpecialArgs = {
          inherit f;
        };
      };
    };
}
