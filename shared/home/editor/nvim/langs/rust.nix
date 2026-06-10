{ pkgs, ... }:
{
  myNvim.treesitter.parsers = [
    "rust"
  ];

  programs.neovim.extraPackages = [ pkgs.rust-analyzer ];

  programs.neovim.initLua = builtins.readFile ./rust.lua;
}
