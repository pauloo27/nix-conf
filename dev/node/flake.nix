{
  description = "Node.js development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
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
        let
          node24Shell = pkgs.mkShell {
            packages = with pkgs; [
              nodejs_24
              eslint_d
              biome
              pnpm
              yarn
              typescript
              typescript-language-server
            ];
          };
        in
        {
          default = node24Shell;
          "24" = node24Shell;
          "22" = pkgs.mkShell {
            packages = with pkgs; [
              nodejs_22
              eslint_d
              biome
              pnpm
              yarn
              typescript
              typescript-language-server
            ];
          };
        }
      );
    };
}
