{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.myNvim.treesitter.parsers = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
  };

  config = {
    myNvim.treesitter.parsers = [
      "c"
      "json"
      "lua"
      "vim"
      "vimdoc"
      "query"
      "markdown"
      "markdown_inline"
      "sql"
    ];

    programs.neovim.initLua = ''
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args) pcall(vim.treesitter.start, args.buf) end,
      })
    '';

    programs.neovim.plugins = [
      (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: map (l: p.${l}) config.myNvim.treesitter.parsers))
    ];
  };
}
