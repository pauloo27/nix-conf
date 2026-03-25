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

require("dap-go").setup({
  dap_configurations = {
    {
      type = "go",
      name = "Debug package",
      request = "launch",
      program = "${fileDirname}",
    },
  },
})
