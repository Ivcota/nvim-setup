-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Open netrw
map("n", "<leader>pv", vim.cmd.Ex, { desc = "Open netrw" })

-- Move selected lines in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Scroll with centering
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down + center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up + center" })

-- Paste without yanking in visual mode
map("x", "<leader>p", [["_dP]], { desc = "Paste without yanking" })

-- Yank to system clipboard
map({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to clipboard" })
map("n", "<leader>Y", [["+Y]], { desc = "Yank line to clipboard" })

-- LSP: hover with gh instead of K
map("n", "gh", vim.lsp.buf.hover, { desc = "Hover" })

-- LSP aliases matching <leader>v* prefix
map("n", "<leader>vws", function()
  Snacks.picker.lsp_workspace_symbols()
end, { desc = "Workspace Symbols" })
map("n", "<leader>vd", vim.diagnostic.open_float, { desc = "Diagnostics Float" })
map("n", "<leader>vca", vim.lsp.buf.code_action, { desc = "Code Action" })
map("n", "<leader>vrn", vim.lsp.buf.rename, { desc = "Rename" })

-- Signature help in insert mode with C-h instead of C-k
map("i", "<C-h>", vim.lsp.buf.signature_help, { desc = "Signature Help" })

-- Format with <leader>fm using conform
map({ "n", "v" }, "<leader>fm", function()
  require("conform").format({ lsp_fallback = true })
end, { desc = "Format" })

-- Lazygit
map("n", "<leader>lg", function()
  Snacks.lazygit()
end, { desc = "Lazygit" })

-- Float terminal
map("n", "<leader>lt", function()
  Snacks.terminal()
end, { desc = "Terminal (Float)" })
