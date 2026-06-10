{ pkgs, ... }:
{
  programs.neovim.plugins = [ pkgs.vimPlugins.nvim-dap ];

  programs.neovim.initLua = builtins.readFile ./dap.lua;
}
