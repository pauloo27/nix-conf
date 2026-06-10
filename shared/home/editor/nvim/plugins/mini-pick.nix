{ pkgs, ... }:
{
  programs.neovim.plugins = [
    pkgs.vimPlugins.mini-pick
    pkgs.vimPlugins.mini-extra
    pkgs.vimPlugins.mini-files
  ];

  programs.neovim.extraPackages = [
    pkgs.ripgrep
    pkgs.fd
  ];

  programs.neovim.initLua = builtins.readFile ./mini-pick.lua;
}
