{ pkgs, ... }:
{
  programs.neovim.extraPackages = [ pkgs.clang-tools ];

  programs.neovim.initLua = builtins.readFile ./c.lua;
}
