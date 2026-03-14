vim.filetype.add({ extension = { http = "http" } })

require("rest-nvim").setup({
  response = {
    hooks = {
      format = true,
    },
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "json",
  callback = function()
    vim.bo.formatexpr = ""
    vim.bo.formatprg = "jq"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "http",
  callback = function()
    vim.keymap.set(
      "n",
      "<CR>",
      "<cmd>Rest run<CR>",
      { buffer = true, desc = "Run HTTP request" }
    )
  end,
})
