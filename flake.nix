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
    llame.url = "github:pauloo27/llame";
    f.url = "git+https://code.db.cafe/pauloo27/f.git";
    smsh.url = "git+https://code.db.cafe/pauloo27/smsh.git";
    np.url = "git+https://code.db.cafe/pauloo27/np.git";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nix-flatpak,
      f,
      tldr,
      llame,
      smsh,
      np,
      ...
    }@inputs:
    let
      lib = nixpkgs.lib;

      hosts = {
        karen = {
          isNixOS = true;
          arch = "x86_64-linux";
          extraNixosModules = [ ];
        };
        nancy = {
          isNixOS = true;
          arch = "x86_64-linux";
          extraNixosModules = [ ];
        };
        zita = {
          isNixOS = false;
          arch = "x86_64-linux";
          extraNixosModules = [ ];
        };
        melinda = {
          isNixOS = false;
          arch = "x86_64-linux";
          extraNixosModules = [ ];
        };
      };

      mkNixosSystem =
        name: config:
        nixpkgs.lib.nixosSystem {
          modules = [
            { nixpkgs.hostPlatform = config.arch; }
            ./hosts/${name}/configuration.nix
          ]
          ++ config.extraNixosModules;
        };

      mkHomeSystem =
        name: config:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${config.arch};
          modules = [
            ./hosts/${name}/home.nix
            nix-flatpak.homeManagerModules.nix-flatpak
            np.homeManagerModules.default
          ];
          extraSpecialArgs = {
            inherit
              f
              tldr
              llame
              smsh
              ;
            hostname = name;
          };
        };

    in
    {
      # Generate NixOS configurations for hosts with isNixOS = true
      nixosConfigurations = lib.filterAttrs (_: v: v != { }) (
        lib.mapAttrs (name: config: if config.isNixOS then mkNixosSystem name config else { }) hosts
      );

      # Generate Home Manager configurations for all hosts
      homeConfigurations = lib.mapAttrs (name: config: mkHomeSystem name config) hosts;

      # Development shell
      devShells =
        lib.genAttrs
          [
            "x86_64-linux"
            "aarch64-linux"
            "x86_64-darwin"
            "aarch64-darwin"
          ]
          (
            system:
            let
              pkgs = nixpkgs.legacyPackages.${system};
            in
            {
              default = pkgs.mkShell {
                packages = with pkgs; [
                  nil # Nix language server
                  nixfmt-rfc-style # Nix formatter
                  stylua # Lua formatter
                  lua-language-server # Lua language server
                ];
              };
            }
          );
    };
}
