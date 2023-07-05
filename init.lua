require("autoload")
require("remap")
require("settings")

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
	'nvim-telescope/telescope.nvim', tag = '0.1.2',
	'nvim-lua/plenary.nvim',
	'nvim-treesitter/nvim-treesitter',
	build = ":masonupdate", -- :masonupdate updates registry contents
	{ 'rose-pine/neovim', name = 'rose-pine' },
	{'folke/tokyonight.nvim'},
	{
		'vonheikemen/lsp-zero.nvim',
		branch = 'v2.x',
		dependencies = {
			-- lsp support
			{'neovim/nvim-lspconfig'},             -- required
			{                                      -- optional
				'williamboman/mason.nvim',
				build = function()
					pcall(vim.cmd, 'masonupdate')
				end,
			},
			{'williamboman/mason-lspconfig.nvim'}, -- optional

			-- autocompletion
			{'hrsh7th/nvim-cmp'},     -- required
			{'hrsh7th/cmp-nvim-lsp'}, -- required
			{'l3mon4d3/luasnip'},     -- required
		}
	},
	'kdheepak/lazygit.nvim',
	'theprimeagen/harpoon',
	'github/copilot.vim',
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		}
	}
}

local opts = {}


require("lazy").setup(plugins, opts)


vim.cmd('colorscheme rose-pine')
print("hello world")
