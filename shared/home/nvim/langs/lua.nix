{ pkgs, ... }:
{
  programs.neovim.extraPackages = [ pkgs.lua-language-server ];

  programs.neovim.extraLuaConfig = builtins.readFile ./lua.lua;
}
