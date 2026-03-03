require("mini.pick").setup()
require("mini.extra").setup()
require("mini.files").setup({
  mappings = {
    go_in = "l",
    go_in_plus = "L",
    go_out = "h",
    go_out_plus = "H",
    show_help = "g?",
  },
})

vim.keymap.set("n", "<leader>k", MiniPick.builtin.files)
vim.keymap.set("n", "<leader>g", MiniPick.builtin.grep_live)
vim.keymap.set("n", "<leader>0", MiniPick.builtin.buffers)

vim.keymap.set("n", "<leader>f", function()
  MiniFiles.open(vim.api.nvim_buf_get_name(0))
end)

vim.keymap.set("n", "<leader>F", function()
  MiniFiles.open()
end)
