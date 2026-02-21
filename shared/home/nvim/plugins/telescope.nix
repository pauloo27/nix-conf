{ pkgs, ... }:
{
  programs.neovim.plugins = [
    pkgs.vimPlugins.telescope-nvim
    pkgs.vimPlugins.telescope-file-browser-nvim
    pkgs.vimPlugins.plenary-nvim
  ];

  programs.neovim.extraPackages = [
    pkgs.ripgrep
    pkgs.fd
  ];

  programs.neovim.extraLuaConfig = builtins.readFile ./telescope.lua;
}
