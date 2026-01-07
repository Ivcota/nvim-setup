-- Testing and debugging plugins

return {
	-- Neotest - test runner
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			-- Test adapters
			"nvim-neotest/neotest-python",
			"marilari88/neotest-vitest",
			"thenbe/neotest-playwright",
			"olimorris/neotest-rspec",
			"nvim-neotest/neotest-go",
		},
		config = function()
			-- Direct adapter configuration (no language registry needed)
			require("neotest").setup({
				adapters = {
					-- JavaScript/TypeScript (Vitest is default, Playwright available)
					require("neotest-vitest"),
					require("neotest-playwright").adapter({
						options = {
							persist_project_selection = true,
							enable_dynamic_test_discovery = true,
						},
					}),

					-- Python
					require("neotest-python")({
						dap = { justMyCode = false },
						runner = "pytest",
					}),

					-- Go
					require("neotest-go"),

					-- Ruby
					require("neotest-rspec"),
				},
			})

			-- Keymaps
			vim.api.nvim_set_keymap("n", "<leader>t", ":Neotest run<CR>", { noremap = true, silent = true })
		end,
	},

	-- DAP - debugger
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")

			-- Python DAP adapter
			dap.adapters.python = {
				type = "executable",
				command = os.getenv("HOME") .. "/.virtualenvs/tools/bin/python",
				args = { "-m", "debugpy.adapter" },
			}

			dap.configurations.python = {
				{
					type = "python",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					pythonPath = function()
						return "python3"
					end,
				},
			}
		end,
	},
}
