return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      {
        "<leader>a",
        function()
          require("harpoon"):list():add()
        end,
        desc = "Harpoon Add File",
      },
      {
        "<leader>h",
        function()
          local harpoon = require("harpoon")
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "Harpoon Quick Menu",
      },
      {
        "<C-t>",
        function()
          require("harpoon"):list():select(1)
        end,
        desc = "Harpoon File 1",
      },
      {
        "<C-n>",
        function()
          require("harpoon"):list():select(2)
        end,
        desc = "Harpoon File 2",
      },
    },
    opts = {},
  },
}
