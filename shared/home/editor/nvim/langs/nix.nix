{ pkgs, ... }:
{
  myNvim.treesitter.parsers = [
    "nix"
  ];

  programs.neovim.extraPackages = [ pkgs.nil ];

  programs.neovim.initLua = builtins.readFile ./nix.lua;
}
