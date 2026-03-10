{ pkgs, ... }:
{
  programs.neovim.plugins = [ pkgs.vimPlugins.gitsigns-nvim ];

  programs.neovim.extraLuaConfig = builtins.readFile ./gitsigns.lua;
}
