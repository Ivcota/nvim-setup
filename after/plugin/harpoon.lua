local harpoon = require("harpoon").setup({
  global_settings = {
    save_on_toggle = true,
  },
})

vim.keymap.set("n", "<leader>a", function()
  harpoon:list():add()
end, { desc = "Add file to harpoon" })
vim.keymap.set("n", "<leader>h", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Toggle harpoon menu" })

vim.keymap.set("n", "<C-t>", function()
  harpoon:list():select(1)
end, { desc = "Jump to harpoon file 1" })
vim.keymap.set("n", "<C-n>", function()
  harpoon:list():select(2)
end, { desc = "Jump to harpoon file 2" })
vim.keymap.set("n", "<C-m>", function()
  harpoon:list():select(3)
end, { desc = "Jump to harpoon file 3" })
