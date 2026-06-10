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
    pkgs.vscode-langservers-extracted
    pkgs.biome
    pkgs.prettierd
  ];

  programs.neovim.initLua = builtins.readFile ./js_and_ts.lua;
}
