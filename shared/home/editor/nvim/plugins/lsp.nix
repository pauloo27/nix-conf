{ pkgs, ... }:
{
  programs.neovim.plugins = [ pkgs.vimPlugins.nvim-lspconfig ];

  programs.neovim.initLua = builtins.readFile ./lsp.lua;
}
