{ pkgs, ... }:
{
  programs.neovim.plugins = [ pkgs.vimPlugins.blink-cmp ];

  programs.neovim.extraLuaConfig = builtins.readFile ./blink.lua;
}
