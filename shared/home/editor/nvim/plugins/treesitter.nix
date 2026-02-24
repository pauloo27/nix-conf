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

    programs.neovim.plugins = [
      (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: map (l: p.${l}) config.myNvim.treesitter.parsers))
    ];

    programs.neovim.extraLuaConfig = builtins.readFile ./treesitter.lua;
  };
}
