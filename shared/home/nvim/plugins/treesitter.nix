{ pkgs, ... }:
{
  programs.neovim.plugins = [
    (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
      p.c
      p.json
      p.lua
      p.vim
      p.vimdoc
      p.query
      p.markdown
      p.markdown_inline
      p.sql
    ]))
  ];

  programs.neovim.extraLuaConfig = builtins.readFile ./treesitter.lua;
}
