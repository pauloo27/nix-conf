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

  programs.neovim.initLua = builtins.readFile ./go.lua;
}
