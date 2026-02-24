{ pkgs, ... }:
{
  myNvim.treesitter.parsers = [
    "helm"
  ];

  programs.neovim.extraPackages = [ pkgs.helm-ls ];

  programs.neovim.extraLuaConfig = builtins.readFile ./helm.lua;
}
