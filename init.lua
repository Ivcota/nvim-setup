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
	build = ":MasonUpdate", -- :MasonUpdate updates registry contents
	{ 'rose-pine/neovim', name = 'rose-pine' },
	{'folke/tokyonight.nvim'},
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		dependencies = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},             -- Required
			{                                      -- Optional
				'williamboman/mason.nvim',
				build = function()
					pcall(vim.cmd, 'MasonUpdate')
				end,
			},
			{'williamboman/mason-lspconfig.nvim'}, -- Optional

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},     -- Required
			{'hrsh7th/cmp-nvim-lsp'}, -- Required
			{'L3MON4D3/LuaSnip'},     -- Required
		}
	},
	'kdheepak/lazygit.nvim',
	'github/copilot.vim',
}

local opts = {}


require("lazy").setup(plugins, opts)


vim.cmd('colorscheme rose-pine')
print("hello world")
