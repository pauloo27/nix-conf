{ pkgs, ... }:
{
  imports = [
    ./plugins/map-leader.nix
    ./plugins/rose-pine.nix
    ./plugins/telescope.nix
    ./plugins/lualine.nix
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraLuaConfig = builtins.readFile ./init.lua;
  };
}
