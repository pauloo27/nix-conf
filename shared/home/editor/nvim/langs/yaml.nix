{ pkgs, ... }:
{
  myNvim.treesitter.parsers = [
    "yaml"
  ];

  programs.neovim.extraPackages = [ pkgs.yaml-language-server ];

  programs.neovim.initLua = builtins.readFile ./yaml.lua;
}
