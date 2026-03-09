{ pkgs, ... }:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    neo-tree-nvim
    plenary-nvim
    nvim-web-devicons
    nui-nvim
  ];

  programs.neovim.extraLuaConfig = builtins.readFile ./neo-tree.lua;
}
