local map = vim.api.nvim_set_keymap

-- line numbers
vim.o.nu = true
vim.o.rnu = true
vim.o.cursorline = false

-- enable mouse
vim.o.mouse = "a"

-- <Tab> size and behavior
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2

-- more "natural" spliting behavior
vim.o.splitbelow = true
vim.o.splitright = true

-- show line at column 80
vim.o.colorcolumn = "80"

-- keep undo history in the disk so it persists between sessions
vim.o.undofile = true
vim.o.undodir = vim.fn.expand("~/.cache/undodir")

-- something related to color
vim.o.termguicolors = true

-- leader key
vim.g.mapleader = ","

-- pressing <Esc> inside term will enter normal mode, pressing <C-[> will send
-- <Esc> to the terminal
map("t", "<Esc>", "<C-\\><C-n>", { noremap = true })
map("t", "<C-[>", "<Esc>", { noremap = true })

vim.opt.clipboard = "unnamedplus"

-- "sudo" write
map(
	"n",
	"<leader>W",
	"<cmd>w ! SUDO_ASKPASS=/usr/lib/seahorse/ssh-askpass sudo -A tee % >/dev/null<CR>",
	{ noremap = true }
)
