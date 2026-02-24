{ pkgs, ... }:
{
  myNvim.treesitter.parsers = [
    "java"
  ];

  programs.neovim.extraPackages = [ pkgs.jdt-language-server ];

  programs.neovim.extraLuaConfig = builtins.readFile ./java.lua;
}
