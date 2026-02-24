{ pkgs, ... }:
{
  myNvim.treesitter.parsers = [
    "elixir"
  ];

  programs.neovim.extraPackages = [ pkgs.elixir-ls ];

  programs.neovim.extraLuaConfig = builtins.readFile ./elixir.lua;
}
