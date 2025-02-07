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

-- Search
vim.keymap.set("n", "<leader>lg", function() snacks.lazygit() end, { desc = "lazygit" })
vim.keymap.set("n", "<leader>ff", function() snacks.picker.files() end, { desc = "find files" })
vim.keymap.set("v", "<leader>fg", function() snacks.picker.grep_word() end, { desc = "find string" })
vim.keymap.set("n", "<leader>fg", function() snacks.picker.grep() end, { desc = "find string" })
vim.keymap.set("n", "<leader>fb", function() snacks.picker.buffers() end, { desc = "find buffers" })
vim.keymap.set("n", "<leader><space>", function() snacks.picker.smart() end, { desc = "Smart Find Files" })

-- LSP
vim.keymap.set("n", "gd", function() snacks.picker.lsp_definitions() end, { desc = "Goto Definition" })
vim.keymap.set("n", "gh", function() snacks.picker.lsp_type_definitions() end, { desc = "Goto Declaration" })
vim.keymap.set("n", "gr", function() snacks.picker.lsp_references() end, { desc = "References" })

-- Git
vim.keymap.set("n", "<leader>gb", function() snacks.picker.git_branches() end, { desc = "Git Branches" })
vim.keymap.set("n", "<leader>gl", function() snacks.picker.git_log() end, { desc = "Git Log" })
vim.keymap.set("n", "<leader>gL", function() snacks.picker.git_log_line() end, { desc = "Git Log Line" })
vim.keymap.set("n", "<leader>gs", function() snacks.picker.git_status() end, { desc = "Git Status" })
vim.keymap.set("n", "<leader>gS", function() snacks.picker.git_stash() end, { desc = "Git Stash" })
vim.keymap.set("n", "<leader>gd", function() snacks.picker.git_diff() end, { desc = "Git Diff (Hunks)" })
vim.keymap.set("n", "<leader>gf", function() snacks.picker.git_log_file() end, { desc = "Git Log File" })
vim.keymap.set("n", "<leader>gB", function() snacks.gitbrowse() end, { desc = "Git Browse" })
vim.keymap.set("v", "<leader>gB", function() snacks.gitbrowse() end, { desc = "Git Browse" })

-- Diagnostics
vim.keymap.set("n", "<leader>sd", function() snacks.picker.diagnostics() end, { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>sD", function() snacks.picker.diagnostics_buffer() end, { desc = "Diagnostics Buffer" })

-- Picker
vim.keymap.set("n", "<leader>e", function() snacks.explorer() end, { desc = "File Explorer" })

-- Scratchpad
vim.keymap.set("n", "<leader>.", function() snacks.scratch() end, { desc = "Toggle Scratch Buffer" })
vim.keymap.set("n", "<leader>S", function() snacks.scratch.select() end, { desc = "Select Scratch Buffer" })
