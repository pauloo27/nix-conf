{
  description = "Node.js development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
  };

  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          "24" = pkgs.mkShell {
            packages = with pkgs; [
              nodejs_24
              eslint_d
              biome
              nodePackages.npm
              nodePackages.pnpm
              nodePackages.yarn
              nodePackages.typescript
              nodePackages.typescript-language-server
            ];
          };
          "22" = pkgs.mkShell {
            packages = with pkgs; [
              nodejs_22
              eslint_d
              biome
              nodePackages.npm
              nodePackages.pnpm
              nodePackages.yarn
              nodePackages.typescript
              nodePackages.typescript-language-server
            ];
          };
        }
      );
    };
}
