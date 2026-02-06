return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      {
        "<leader>t",
        function()
          require("neotest").run.run()
        end,
        desc = "Run Nearest Test",
      },
    },
    opts = {
      -- Add test adapters for your languages here, e.g.:
      -- adapters = { require("neotest-python") }
      adapters = {},
    },
  },
}
