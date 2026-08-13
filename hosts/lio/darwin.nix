{ ... }:

{
  imports = [
    ../../shared/darwin/base.nix
    ../../shared/darwin/brew.nix
  ];

  system.primaryUser = "paulo";
  system.stateVersion = 7;
}
