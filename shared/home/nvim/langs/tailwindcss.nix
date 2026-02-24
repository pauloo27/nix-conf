{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.myNvim.tailwindcss.filetypes = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
  };

  config = {
    programs.neovim.extraPackages = [ pkgs.tailwindcss-language-server ];

    programs.neovim.extraLuaConfig = ''
      vim.lsp.config("tailwindcss", {
        filetypes = vim.json.decode('${builtins.toJSON config.myNvim.tailwindcss.filetypes}'),
      })
      vim.lsp.enable("tailwindcss")
    '';
  };
}
