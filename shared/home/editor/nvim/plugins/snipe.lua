local snipe = require("snipe")
snipe.setup({
  hints = {
    dictionary = "asdfghlwertyuiop",
  },
  ui = {
    position = "cursor",
    preselect_current = true,
    text_align = "file-first",
  },
  sort = "default",
})

vim.keymap.set("n", "<leader>ob", function()
  snipe.open_buffer_menu()
end, { desc = "Open Snipe buffer menu" })
