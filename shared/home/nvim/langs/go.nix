{ pkgs, ... }:
{
  programs.neovim.extraPackages = [ pkgs.gopls ];

  programs.neovim.extraLuaConfig = builtins.readFile ./go.lua;
}
