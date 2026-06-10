{ pkgs, ... }:
{
  programs.neovim.plugins = [ pkgs.vimPlugins.dressing-nvim ];

  programs.neovim.initLua = builtins.readFile ./dressing.lua;
}
