{ pkgs, ... }:
{
  myNvim.treesitter.parsers = [
    "rust"
  ];

  programs.neovim.extraPackages = [ pkgs.rust-analyzer ];

  programs.neovim.extraLuaConfig = builtins.readFile ./rust.lua;
}
