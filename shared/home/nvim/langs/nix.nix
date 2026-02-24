{ pkgs, ... }:
{
  myNvim.treesitter.parsers = [
    "nix"
  ];

  programs.neovim.extraPackages = [ pkgs.nil ];

  programs.neovim.extraLuaConfig = builtins.readFile ./nix.lua;
}
