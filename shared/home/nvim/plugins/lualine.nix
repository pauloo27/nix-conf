{ pkgs, ... }:
{
  programs.neovim.plugins = [
    pkgs.vimPlugins.lualine-nvim
    pkgs.vimPlugins.nvim-web-devicons
  ];

  programs.neovim.extraLuaConfig = builtins.readFile ./lualine.lua;
}
