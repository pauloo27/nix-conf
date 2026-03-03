{ pkgs, ... }:
{
  programs.neovim.plugins = [ pkgs.vimPlugins.dressing-nvim ];

  programs.neovim.extraLuaConfig = builtins.readFile ./dressing.lua;
}
