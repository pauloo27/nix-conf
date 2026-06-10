{ pkgs, ... }:
{
  programs.neovim.plugins = [ pkgs.vimPlugins.tmux-nvim ];

  programs.neovim.initLua = builtins.readFile ./tmux.lua;
}
