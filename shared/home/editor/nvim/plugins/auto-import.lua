local auto_import = function()
  local ft = vim.bo.filetype

  local ts_auto_import = function()
    vim.lsp.buf.code_action({
      apply = true,
      context = {
        only = { "source.addMissingImports.ts" },
        diagnostics = {},
      },
    })
  end

  local fallback_auto_import = function()
    vim.lsp.buf.code_action({
      apply = true,
      context = {
        only = { "source.organizeImports" },
        diagnostics = {},
      },
    })
  end

  local auto_import_per_ft = {
    ["typescript"] = ts_auto_import,
    ["typescriptreact"] = ts_auto_import,
    ["javascript"] = ts_auto_import,
    ["javascriptreact"] = ts_auto_import,
  }

  local handler = auto_import_per_ft[ft]
  if handler ~= nil then
    handler()
  else
    fallback_auto_import()
  end
end

vim.keymap.set("n", "<leader>i", auto_import)
