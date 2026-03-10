{ pkgs, ... }:
{
  programs.neovim.plugins = [ pkgs.vimPlugins.vim-fugitive ];
}
