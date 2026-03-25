{ pkgs, lib, ... }:
{
  options.myNvim.tailwindcss.filetypes = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
  };

  imports = [
    ./plugins/map-leader.nix
    ./plugins/rose-pine.nix
    ./plugins/telescope.nix
    ./plugins/lualine.nix
    ./plugins/treesitter.nix
    ./plugins/lsp.nix
    ./plugins/conform.nix
    ./plugins/blink.nix
    ./plugins/rest.nix
    ./plugins/tmux.nix
    ./plugins/lsp-signature.nix
    ./plugins/dressing.nix
    ./plugins/neo-tree.nix
    ./plugins/fugitive.nix
    ./plugins/gitsigns.nix
    ./plugins/auto-import.nix
    ./debugger/dap.nix
  ];

  config.programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraLuaConfig = builtins.readFile ./init.lua;
  };
}
