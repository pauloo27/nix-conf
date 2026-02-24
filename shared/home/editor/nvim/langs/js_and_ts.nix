{ pkgs, ... }:
{
  myNvim.treesitter.parsers = [
    "typescript"
    "javascript"
    "jsdoc"
  ];

  myNvim.conform.formatters_by_ft = {
    javascript = [
      "biome"
      "prettierd"
    ];
    javascriptreact = [
      "biome"
      "prettierd"
    ];
    typescript = [
      "biome"
      "prettierd"
    ];
    typescriptreact = [
      "biome"
      "prettierd"
    ];
  };

  myNvim.tailwindcss.filetypes = [
    "javascriptreact"
    "typescriptreact"
    "html"
  ];

  programs.neovim.extraPackages = [
    pkgs.typescript-language-server
    pkgs.biome
    pkgs.prettierd
  ];

  programs.neovim.extraLuaConfig = builtins.readFile ./js_and_ts.lua;
}
