{ pkgs, ... }:
{
  myNvim.treesitter.parsers = [
    "go"
    "gomod"
    "gowork"
    "gosum"
  ];

  programs.neovim.extraPackages = [ pkgs.gopls ];

  programs.neovim.extraLuaConfig = builtins.readFile ./go.lua;
}
