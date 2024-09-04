{
  description = "Home Manager configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
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
      homeConfigurations.paulo = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [ 
          ({ pkgs, ... }: {
            home.packages = [
              pkgs.hello
              pkgs.btop 
              pkgs.ripgrep
              pkgs.starship 
              pkgs.zoxide 
              pkgs.fzf 
              f.defaultPackage.${pkgs.system}
            ];
            home.stateVersion = "24.05";
            home.username = "paulo";
            home.homeDirectory = "/home/paulo";
          })
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
