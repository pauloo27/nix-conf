{ pkgs, ... }:
{
  myNvim.treesitter.parsers = [
    "gleam"
  ];

  programs.neovim.extraPackages = [ pkgs.gleam ];

  programs.neovim.initLua = builtins.readFile ./gleam.lua;
}
