local harpoon = require("harpoon").setup({
  global_settings = {
    save_on_toggle = true,
  },
})

vim.keymap.set("n", "<leader>a", function()
  harpoon:list():append()
end)
vim.keymap.set("n", "<leader>h", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)

vim.keymap.set("n", "<C-t>", function()
  harpoon:list():select(1)
end)
vim.keymap.set("n", "<C-n>", function()
  harpoon:list():select(2)
end)
vim.keymap.set("n", "<C-m>", function()
  harpoon:list():select(3)
end)
