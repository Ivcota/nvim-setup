local snacks = require("snacks")

snacks.setup({
  bigfile = { enabled = true },
  dashboard = { enabled = true },
  explorer = { enabled = true },
  indent = { enabled = true },
  input = { enabled = true },
  notifier = {
    enabled = true,
    timeout = 3000,
  },
  picker = { enabled = true },
  quickfile = { enabled = true },
  scope = { enabled = true },
  scroll = { enabled = false },
  statuscolumn = { enabled = true },
  words = { enabled = true },
  styles = {
    notification = {
      wo = { wrap = true },
    },
  },
})

-- Keybindings
vim.keymap.set("n", "<leader>lg", function() snacks.lazygit() end, { desc = "lazygit" })
vim.keymap.set("n", "<leader>ff", function() snacks.picker.files() end, { desc = "find files" })
vim.keymap.set("v", "<leader>fg", function() snacks.picker.grep_word() end, { desc = "find string" })
vim.keymap.set("n", "<leader>fb", function() snacks.picker.buffers() end, { desc = "find buffers" })

-- LSP
vim.keymap.set("n", "gd", function() snacks.picker.lsp_definitions() end, { desc = "Goto Definition" })
vim.keymap.set("n", "gh", function() snacks.picker.lsp_type_definitions() end, { desc = "Goto Declaration" })
vim.keymap.set("n", "<leader>gr", function() snacks.picker.lsp_references() end, { desc = "References" })

-- Git
vim.keymap.set("n", "<leader>gb", function() snacks.picker.git_branches() end, { desc = "Git Branches" })
vim.keymap.set("n", "<leader>gl", function() snacks.picker.git_log() end, { desc = "Git Log" })
vim.keymap.set("n", "<leader>gL", function() snacks.picker.git_log_line() end, { desc = "Git Log Line" })
vim.keymap.set("n", "<leader>gs", function() snacks.picker.git_status() end, { desc = "Git Status" })
vim.keymap.set("n", "<leader>gS", function() snacks.picker.git_stash() end, { desc = "Git Stash" })
vim.keymap.set("n", "<leader>gd", function() snacks.picker.git_diff() end, { desc = "Git Diff (Hunks)" })
vim.keymap.set("n", "<leader>gf", function() snacks.picker.git_log_file() end, { desc = "Git Log File" })
