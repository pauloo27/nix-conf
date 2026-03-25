{ pkgs, ... }:
{
  myNvim.treesitter.parsers = [
    "go"
    "gomod"
    "gowork"
    "gosum"
  ];

  programs.neovim.plugins = [ pkgs.vimPlugins.nvim-dap-go ];

  programs.neovim.extraPackages = [
    pkgs.gopls
    pkgs.delve
  ];

  programs.neovim.extraLuaConfig = builtins.readFile ./go.lua;
}
