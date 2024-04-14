require("neotest").setup({
	adapters = {
		require("neotest-python"),
	},
})

vim.api.nvim_set_keymap("n", "<leader>t", ":Neotest run<CR>", { noremap = true, silent = true })
