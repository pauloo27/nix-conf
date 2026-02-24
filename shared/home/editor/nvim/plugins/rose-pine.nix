{ pkgs, lib, ... }:
{
  programs.neovim.plugins = [ pkgs.vimPlugins.rose-pine ];

  programs.neovim.extraLuaConfig = lib.mkBefore ''
    vim.cmd("colorscheme rose-pine")
    vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
    vim.cmd("hi NonText guibg=NONE ctermbg=NONE")
    vim.cmd("hi NormalNC guibg=NONE ctermbg=NONE")
  '';
}
