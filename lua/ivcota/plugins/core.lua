-- Core plugins required by other plugins

return {
	-- Plenary - utility functions used by many plugins
	"nvim-lua/plenary.nvim",

	-- Web devicons - file icons
	"nvim-tree/nvim-web-devicons",

	-- Treesitter - syntax highlighting and parsing
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				indent = {
					enable = true,
				},
				auto_install = true,
				ensure_installed = { "c", "lua", "vim", "typescript", "javascript", "rust", "html", "python" },
				highlight = {
					enable = true,
					-- Gracefully disable highlighting if queries are incompatible with parser
					disable = function(lang, buf)
						local ok = pcall(vim.treesitter.query.get, lang, "highlights")
						return not ok
					end,
				},
			})
		end,
	},

	-- FixCursorHold - fixes CursorHold performance issues
	"antoinemadec/FixCursorHold.nvim",

	-- nvim-nio - async I/O library used by neotest
	"nvim-neotest/nvim-nio",

	-- Autotag - auto close/rename HTML tags
	{
		"windwp/nvim-ts-autotag",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
}
