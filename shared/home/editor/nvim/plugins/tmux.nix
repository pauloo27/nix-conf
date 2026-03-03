{ pkgs, ... }:
{
  programs.neovim.plugins = [ pkgs.vimPlugins.tmux-nvim ];

  programs.neovim.extraLuaConfig = builtins.readFile ./tmux.lua;
}
