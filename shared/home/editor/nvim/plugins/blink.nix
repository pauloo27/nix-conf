{ pkgs, ... }:
{
  programs.neovim.plugins = [ pkgs.vimPlugins.blink-cmp ];

  programs.neovim.initLua = builtins.readFile ./blink.lua;
}
