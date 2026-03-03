vim.filetype.add({ extension = { http = "http" } })

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
