{ pkgs, ... }:
{
  myNvim.treesitter.parsers = [
    "gleam"
  ];

  programs.neovim.extraPackages = [ pkgs.gleam ];

  programs.neovim.extraLuaConfig = builtins.readFile ./gleam.lua;
}
