{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Nix settings
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # Nix garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Automatically optimize the Nix store
  nix.optimise = {
    automatic = true;
    dates = [ "weekly" ];
  };
}
