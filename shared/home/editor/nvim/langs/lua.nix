{ pkgs, ... }:
{
  programs.neovim.extraPackages = [ pkgs.lua-language-server ];

  programs.neovim.initLua = builtins.readFile ./lua.lua;
}
