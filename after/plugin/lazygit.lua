local lazygit = require("lazygit")
vim.keymap.set("n", "<leader>lg", lazygit.lazygit, { noremap = true, silent = true })
