{ ... }:
{
  programs.neovim.initLua = builtins.readFile ./spell.lua;
}
