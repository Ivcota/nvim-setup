vim.keymap.set("n", "<C-S-h>", "<cmd>TmuxResizeLeft<CR>", { silent = true, noremap = true, desc = "Resize tmux pane left" })
vim.keymap.set("n", "<C-S-l>", "<cmd>TmuxResizeRight<CR>", { silent = true, noremap = true, desc = "Resize tmux pane right" })
vim.keymap.set("n", "<C-S-j>", "<cmd>TmuxResizeDown<CR>", { silent = true, noremap = true, desc = "Resize tmux pane down" })
vim.keymap.set("n", "<C-S-k>", "<cmd>TmuxResizeUp<CR>", { silent = true, noremap = true, desc = "Resize tmux pane up" })
