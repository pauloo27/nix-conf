{
  description = "Nix flake for Helm and Helmfile with plugins";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/master";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
          };
        };

        kubernetes-helm-wrapped = pkgs.wrapHelm pkgs.kubernetes-helm {
          plugins = with pkgs.kubernetes-helmPlugins; [
            helm-diff
            helm-secrets
            helm-git
            helm-s3
          ];
        };

        helmfile-wrapped = pkgs.helmfile-wrapped.override {
          inherit (kubernetes-helm-wrapped) pluginsDir;
        };

      in
      {
        devShells.default = pkgs.mkShell {
          packages = [
            kubernetes-helm-wrapped
            helmfile-wrapped
            pkgs.kustomize
            pkgs.awscli2
            pkgs.k9s
            pkgs.kubectl
            pkgs.terraform
          ];
        };
      }
    );
}
