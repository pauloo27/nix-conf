{ pkgs, ... }:
{
  myNvim.treesitter.parsers = [
    "http"
    "json"
  ];

  programs.neovim.plugins = [ pkgs.vimPlugins.rest-nvim ];

  programs.neovim.extraLuaConfig = builtins.readFile ./rest.lua;
}
