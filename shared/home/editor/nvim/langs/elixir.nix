{ pkgs, ... }:
{
  myNvim.treesitter.parsers = [
    "elixir"
  ];

  programs.neovim.extraPackages = [ pkgs.elixir-ls ];

  programs.neovim.initLua = builtins.readFile ./elixir.lua;
}
