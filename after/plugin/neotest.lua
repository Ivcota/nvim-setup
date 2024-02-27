require("neotest").setup({
  adapters = {
    require("neotest-jest")({
      jestCommand = "npm test --",
      jestConfigFile = "custom.jest.config.ts",
      env = { CI = true },
      cwd = function(path)
        return vim.fn.getcwd()
      end,
    }),
  },
})

vim.api.nvim_set_keymap("n", "<leader>t", ":Neotest run<CR>", { noremap = true, silent = true })
