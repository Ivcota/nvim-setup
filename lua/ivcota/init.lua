require("ivcota.autoload")
require("ivcota.custom_mappings")
require("ivcota.settings")

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
  "nvim-treesitter/nvim-treesitter",
  build = ":masonupdate", -- :masonupdate updates registry contents
  { "rose-pine/neovim",     name = "rose-pine" },
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
      { "hrsh7th/nvim-cmp" },     -- required
      { "hrsh7th/cmp-nvim-lsp" }, -- required
      { "l3mon4d3/luasnip" },     -- required
    },
  },
  "kdheepak/lazygit.nvim",
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" }
  }, 
  "github/copilot.vim",
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {},
  },
  { "akinsho/toggleterm.nvim", version = "*",       config = true },
  "nvimtools/none-ls.nvim",
  "tpope/vim-surround",
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  "vim-airline/vim-airline",
  "vim-test/vim-test",
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
  { "catppuccin/nvim",         name = "catppuccin", priority = 1000 },
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
    { "tpope/vim-dadbod",                     lazy = true },
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
  "mfussenegger/nvim-dap",
  "nvim-treesitter/nvim-treesitter",
  "theHamsta/nvim-dap-virtual-text",
  "mfussenegger/nvim-dap-python",
}

local opts = {}

function SetColorScheme(name)
  -- vim.cmd("colorscheme rose-pine")
  -- vim.cmd([[colorscheme tokyonight]])
  -- vim.g.material_theme_style = "ocean-community"
  -- vim.cmd([[colorscheme material]])
  vim.cmd("colorscheme " .. name)
  vim.opt.termguicolors = true
end

require("lazy").setup(plugins, opts)

SetColorScheme("rose-pine")

print("Hey Iverson! Here's your Neovim ❤️")
