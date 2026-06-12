vim.lsp.config("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      check = {
        command = "clippy",
      },
      completion = {
        callable = {
          snippets = "add_parentheses",
        },
      },
    },
  },
})

vim.lsp.enable("rust_analyzer")
