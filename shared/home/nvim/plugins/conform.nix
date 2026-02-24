{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.myNvim.conform.formatters_by_ft = lib.mkOption {
    type = lib.types.attrsOf (lib.types.listOf lib.types.str);
    default = { };
  };

  config = {
    programs.neovim.plugins = [ pkgs.vimPlugins.conform-nvim ];

    programs.neovim.extraLuaConfig = ''
      require("conform").setup({
        formatters_by_ft = vim.json.decode('${builtins.toJSON config.myNvim.conform.formatters_by_ft}'),
        default_format_opts = {
          lsp_format = "fallback",
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_format = "fallback",
        },
      })
    '';
  };
}
