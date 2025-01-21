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
    dependencies = { "nvim-lua/plenary.nvim" },
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
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- set this to "*" if you want to always pull the latest change, false to update on release
    opts = {
      -- add any opts here
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "hrsh7th/nvim-cmp",            -- autocompletion for avante commands and mentions
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua",      -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter"
    }
  },
  "nvim-neotest/neotest-python"
}

local opts = {}

require("lazy").setup(plugins, opts)
