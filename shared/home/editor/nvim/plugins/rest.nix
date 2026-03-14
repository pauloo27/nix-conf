{ pkgs, ... }:
{
  myNvim.treesitter.parsers = [
    "http"
    "json"
  ];

  programs.neovim.plugins = [ pkgs.vimPlugins.rest-nvim ];

  home.packages = [ pkgs.jq ];

  programs.neovim.extraLuaConfig = builtins.readFile ./rest.lua;
}
