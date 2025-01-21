require("neotest").setup({
  adapters = {
    require("neotest-python"),
    require("neotest-vitest")
  }
})
vim.api.nvim_set_keymap("n", "<leader>t", ":Neotest run<CR>", { noremap = true, silent = true })
