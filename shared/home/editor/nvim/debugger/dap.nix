{ pkgs, ... }:
{
  programs.neovim.plugins = [ pkgs.vimPlugins.nvim-dap ];

  programs.neovim.extraLuaConfig = builtins.readFile ./dap.lua;
}
