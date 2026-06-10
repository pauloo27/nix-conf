{ pkgs, ... }:
{
  myNvim.treesitter.parsers = [
    "java"
  ];

  programs.neovim.extraPackages = [ pkgs.jdt-language-server ];

  programs.neovim.initLua = builtins.readFile ./java.lua;
}
