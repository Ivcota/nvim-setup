vim.opt.guicursor = ""

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.scrolloff = 8
vim.opt.guicursor = "a:blinkon100"
vim.opt.backup = false
vim.opt.cursorline = true

-- Soft wrapping settings
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.textwidth = 80
