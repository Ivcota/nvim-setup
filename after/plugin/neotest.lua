require("neotest").setup({
  adapters = {
    require("neotest-python"),
    require("neotest-vitest"),
    require('neotest-playwright').adapter({
      options = {
        persist_project_selection = true,
        enable_dynamic_test_discovery = true,
        preset = "headed"
      },
    }),
  }
})
vim.api.nvim_set_keymap("n", "<leader>t", ":Neotest run<CR>", { noremap = true, silent = true })
