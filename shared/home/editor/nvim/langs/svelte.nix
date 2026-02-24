{ pkgs, ... }:
{
  myNvim.treesitter.parsers = [
    "svelte"
    "css"
    "scss"
  ];

  myNvim.conform.formatters_by_ft = {
    svelte = [ "prettierd" ];
  };

  myNvim.tailwindcss.filetypes = [
    "svelte"
  ];

  programs.neovim.extraPackages = [
    pkgs.svelte-language-server
    pkgs.prettierd
  ];

  programs.neovim.extraLuaConfig = builtins.readFile ./svelte.lua;
}
