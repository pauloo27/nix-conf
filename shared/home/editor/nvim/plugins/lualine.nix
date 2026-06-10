{ pkgs, ... }:
{
  programs.neovim.plugins = [
    pkgs.vimPlugins.lualine-nvim
    pkgs.vimPlugins.nvim-web-devicons
  ];

  programs.neovim.initLua = builtins.readFile ./lualine.lua;
}
