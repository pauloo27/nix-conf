{ pkgs, ... }:
{
  programs.neovim.plugins = [ pkgs.vimPlugins.nvim-lspconfig ];

  programs.neovim.extraLuaConfig = builtins.readFile ./lsp.lua;
}
