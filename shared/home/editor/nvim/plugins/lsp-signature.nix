{ pkgs, ... }:
{
  programs.neovim.plugins = [ pkgs.vimPlugins.lsp_signature-nvim ];

  programs.neovim.initLua = builtins.readFile ./lsp-signature.lua;
}
