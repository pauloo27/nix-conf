{ pkgs, ... }:
let
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
  home.packages = [
    kubernetes-helm-wrapped
    helmfile-wrapped
    pkgs.kustomize
    pkgs.kubectx
    pkgs.awscli2
    pkgs.k9s
    pkgs.kubectl
    pkgs.argocd
    pkgs.terraform
  ];
}
