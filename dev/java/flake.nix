{
  description = "Java development environment";

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
        let
          java17Shell = pkgs.mkShell {
            packages = with pkgs; [
              jdk17
              maven
              gradle
              jdt-language-server
            ];
            shellHook = ''
              export JAVA_HOME=${pkgs.jdk17}
            '';
          };
        in
        {
          default = java17Shell;
          "17" = java17Shell;
        }
      );
    };
}
