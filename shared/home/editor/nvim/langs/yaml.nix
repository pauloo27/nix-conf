{ pkgs, ... }:
{
  myNvim.treesitter.parsers = [
    "yaml"
  ];

  programs.neovim.extraPackages = [ pkgs.yaml-language-server ];

  programs.neovim.extraLuaConfig = builtins.readFile ./yaml.lua;
}
