{ pkgs, f, ... }: {
  # Common packages for all hosts
  home.packages = [
    pkgs.btop
    pkgs.tree
    pkgs.ripgrep
    pkgs.starship
    pkgs.zoxide
    pkgs.fzf
    f.defaultPackage.${pkgs.system}
  ];

  # Common home-manager settings
  programs.home-manager.enable = true;
}
