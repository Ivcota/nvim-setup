require("neotest").setup({
	adapters = {
		require("neotest-vitest"),
		require("neotest-jest"),
	},
})

vim.api.nvim_set_keymap("n", "<leader>t", ":Neotest run<CR>", { noremap = true, silent = true })
