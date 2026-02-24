{ pkgs, ... }:
{
  programs.neovim.extraPackages = [ pkgs.clang-tools ];

  programs.neovim.extraLuaConfig = builtins.readFile ./c.lua;
}
