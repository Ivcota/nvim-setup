return {
  -- Snacks picker overrides
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find" },
      { "<leader>fg", function() Snacks.picker.grep() end, mode = "n", desc = "Grep" },
      { "<leader>fg", function() Snacks.picker.grep_word() end, mode = "v", desc = "Grep Word" },
      { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
      { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
    },
  },

  -- blink.cmp: Tab/S-Tab for completion
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        ["<Tab>"] = { "select_and_accept", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
      },
    },
  },

  -- Disable K → hover (replaced by gh in keymaps.lua)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["*"] = {
          keys = {
            { "K", false },
          },
        },
      },
    },
  },

  -- Commenting remaps: <leader>cc for line, <leader>bc for block
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>cc", "gcc", desc = "Toggle Line Comment", remap = true },
      { "<leader>cc", "gc", mode = "v", desc = "Toggle Line Comment", remap = true },
      { "<leader>bc", "gbc", desc = "Toggle Block Comment", remap = true },
      { "<leader>bc", "gb", mode = "v", desc = "Toggle Block Comment", remap = true },
    },
  },
}
