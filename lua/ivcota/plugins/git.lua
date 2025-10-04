-- Git-related plugins

return {
	-- Fugitive - Git commands in Vim
	"tpope/vim-fugitive",

	-- Gitsigns - Git decorations
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},

	-- Git blame - show git blame inline
	"f-person/git-blame.nvim",

	-- LazyGit - terminal UI for git (commented out in original config)
	-- "kdheepak/lazygit.nvim",
}
