{ pkgs, ... }:
{
  programs.neovim.plugins = [ pkgs.vimPlugins.lsp_signature-nvim ];

  programs.neovim.extraLuaConfig = builtins.readFile ./lsp-signature.lua;
}
