require("nvim-treesitter.configs").setup({
	indent = {
		enable = true,
	},

	auto_install = true,

	ensure_installed = { "c", "lua", "vim", "typescript", "javascript", "rust" },

	highlight = {
		enable = true,
	},
})
