local Terminal  = require('toggleterm.terminal').Terminal

-- pressing lt will hide/unhide the terminal window
-- not lazygit just a terminal

vim.keymap.set('n', '<leader>lt', ":ToggleTerm direction='float'<CR>" , { desc = "Toggle floating terminal" })
