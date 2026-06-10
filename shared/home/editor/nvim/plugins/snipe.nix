{ pkgs, ... }:
{
  programs.neovim.plugins = [ pkgs.vimPlugins.snipe-nvim ];

  programs.neovim.initLua = builtins.readFile ./snipe.lua;
}
