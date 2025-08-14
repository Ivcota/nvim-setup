local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

local plugins = {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.2",
	"nvim-lua/plenary.nvim",
	"nvim-tree/nvim-web-devicons",
	"nvim-treesitter/nvim-treesitter",
	build = ":masonupdate", -- :masonupdate updates registry contents
	{ "rose-pine/neovim", name = "rose-pine" },
	{ "folke/tokyonight.nvim" },
	{
		"vonheikemen/lsp-zero.nvim",
		branch = "v2.x",
		dependencies = {
			-- lsp support
			{ "neovim/nvim-lspconfig" }, -- required
			{
				-- optional
				"williamboman/mason.nvim",
				build = function()
					pcall(vim.cmd, "masonupdate")
				end,
			},
			{ "williamboman/mason-lspconfig.nvim" }, -- optional

			-- autocompletion
			{ "hrsh7th/nvim-cmp" }, -- required
			{ "hrsh7th/cmp-nvim-lsp" }, -- required
			{ "l3mon4d3/luasnip" }, -- required
			{ "onsails/lspkind.nvim" }, -- for completion item formatting
		},
	},
	-- "kdheepak/lazygit.nvim",
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {},
	},
	{ "akinsho/toggleterm.nvim", version = "*", config = true },
	"nvimtools/none-ls.nvim",
	"tpope/vim-surround",
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	"vim-airline/vim-airline",
	"rstacruz/vim-closer",
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
	},
	"windwp/nvim-ts-autotag",
	-- help me identify which plugin is causing the issue
	-- {
	-- 	"j-hui/fidget.nvim",
	-- 	version = "legacy",
	-- },
	"tpope/vim-fugitive",
	-- "preservim/nerdtree",
	{
		"ThePrimeagen/refactoring.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	},
	"folke/zen-mode.nvim",
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	"kaicataldo/material.vim",
	"lewis6991/gitsigns.nvim",
	"f-person/git-blame.nvim",
	"rebelot/kanagawa.nvim",
	"mbbill/undotree",
	"dmmulroy/tsc.nvim",
	"Slotos/telescope-lsp-handlers.nvim",
	{
		"numToStr/Comment.nvim",
		opts = {
			-- add any options here
		},
		lazy = false,
	},
	"tpope/vim-dadbod",
	"kristijanhusak/vim-dadbod-completion",
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		{ "tpope/vim-dadbod", lazy = true },
		{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
	},
	cmd = {
		"DBUI",
		"DBUIToggle",
		"DBUIAddConnection",
		"DBUIFindBuffer",
	},
	init = function()
		-- Your DBUI configuration
		vim.g.db_ui_use_nerd_fonts = 1
	end,
	"nvim-treesitter/nvim-treesitter",
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/neotest-python",
			"marilari88/neotest-vitest",
			"thenbe/neotest-playwright",
		},
	},
	"mfussenegger/nvim-dap",
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
	},
	{
		"zbirenbaum/copilot-cmp",
		dependencies = {
			"zbirenbaum/copilot.lua",
		},
	},
	"NTBBloodbath/doom-one.nvim",
	"navarasu/onedark.nvim",
	{
		"coder/claudecode.nvim",
		dependencies = { "folke/snacks.nvim" },
		config = true,
		keys = {
			{ "<leader>m", nil, desc = "AI/Claude Code" },
			{ "<leader>mc", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
			{ "<leader>mf", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
			{ "<leader>mr", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
			{ "<leader>mC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
			{ "<leader>mm", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
			{ "<leader>mb", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
			{ "<leader>ms", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
			{
				"<leader>ms",
				"<cmd>ClaudeCodeTreeAdd<cr>",
				desc = "Add file",
				ft = { "NvimTree", "neo-tree", "oil" },
			},
			-- Diff management
			{ "<leader>ma", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
			{ "<leader>md", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
		},
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
	},
}

local opts = {}

require("lazy").setup(plugins, opts)
