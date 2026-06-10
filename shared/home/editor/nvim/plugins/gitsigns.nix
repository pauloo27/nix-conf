{ pkgs, ... }:
{
  programs.neovim.plugins = [ pkgs.vimPlugins.gitsigns-nvim ];

  programs.neovim.initLua = builtins.readFile ./gitsigns.lua;
}
