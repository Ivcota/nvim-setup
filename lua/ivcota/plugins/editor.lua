-- Editor enhancement plugins

return {
	-- Telescope - fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.2",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			-- Telescope configuration from after/plugin/telescope.lua (currently commented out)
			-- Can be uncommented if needed
		end,
	},

	-- Harpoon - quick file navigation
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")
			harpoon.setup({
				global_settings = {
					save_on_toggle = true,
				},
			})

			vim.keymap.set("n", "<leader>a", function()
				harpoon:list():add()
			end, { desc = "Add file to harpoon" })

			vim.keymap.set("n", "<leader>h", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end, { desc = "Toggle harpoon menu" })

			vim.keymap.set("n", "<C-t>", function()
				harpoon:list():select(1)
			end, { desc = "Jump to harpoon file 1" })

			vim.keymap.set("n", "<C-n>", function()
				harpoon:list():select(2)
			end, { desc = "Jump to harpoon file 2" })

			vim.keymap.set("n", "<C-m>", function()
				harpoon:list():select(3)
			end, { desc = "Jump to harpoon file 3" })
		end,
	},

	-- Refactoring - code refactoring utilities
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("refactoring").setup({})

			vim.keymap.set("x", "<leader>re", ":Refactor extract ", { desc = "Refactor extract" })
			vim.keymap.set("x", "<leader>rf", ":Refactor extract_to_file ", { desc = "Refactor extract to file" })
			vim.keymap.set("x", "<leader>rv", ":Refactor extract_var ", { desc = "Refactor extract variable" })
			vim.keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var", { desc = "Refactor inline variable" })
			vim.keymap.set("n", "<leader>rb", ":Refactor extract_block", { desc = "Refactor extract block" })
			vim.keymap.set(
				"n",
				"<leader>rbf",
				":Refactor extract_block_to_file",
				{ desc = "Refactor extract block to file" }
			)
			vim.keymap.set({ "x", "n" }, "<leader>rv", function()
				require("refactoring").debug.print_var()
			end, { desc = "Debug print variable" })
		end,
	},

	-- Comment - easy commenting
	{
		"numToStr/Comment.nvim",
		lazy = false,
		config = function()
			require("Comment").setup({
				toggler = {
					line = "<leader>cc",
					block = "<leader>bc",
				},
				opleader = {
					line = "<leader>c",
					block = "<leader>b",
				},
			})
		end,
	},

	-- Toggleterm - floating terminal
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup()

			vim.keymap.set("n", "<leader>lt", ":ToggleTerm direction='float'<CR>", { desc = "Toggle floating terminal" })
		end,
	},

	-- Surround - easy surround manipulation
	"tpope/vim-surround",

	-- Closer - auto close brackets
	"rstacruz/vim-closer",

	-- Undotree - visualize undo history
	"mbbill/undotree",

	-- TMUX navigator - seamless vim/tmux navigation
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
	},
}
