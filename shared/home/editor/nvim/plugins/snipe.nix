{ pkgs, ... }:
{
  programs.neovim.plugins = [ pkgs.vimPlugins.snipe-nvim ];

  programs.neovim.extraLuaConfig = builtins.readFile ./snipe.lua;
}
