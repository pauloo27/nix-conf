{ pkgs, f, ... }: {
  imports = [
    ./zsh.nix
    ./git.nix
  ];

  # Common packages for all hosts
  home.packages = [
    pkgs.ripgrep
    f.defaultPackage.${pkgs.system}
  ];

  # Common home-manager settings
  programs.home-manager.enable = true;
}
