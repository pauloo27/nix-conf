vim.lsp.config("gopls", {
  settings = {
    gopls = {
      experimentalPostfixCompletions = true,
    },
  },
  init_options = {
    usePlaceholders = true,
  },
})

vim.lsp.enable("gopls")
