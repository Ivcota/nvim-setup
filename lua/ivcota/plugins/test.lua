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
		},
		config = function()
			local languages = require("ivcota.languages")
			local project = require("ivcota.project")

			-- Get language configs with test adapters
			local lang_configs = languages.get_with_tests()

			-- Apply project-specific overrides
			lang_configs = project.apply_test_overrides(lang_configs)

			-- Build adapter list
			local adapters = {}
			for _, lang_config in ipairs(lang_configs) do
				if lang_config.test then
					local adapter_name = lang_config.test.adapter
					local adapter_config = lang_config.test.config or {}

					local ok, adapter = pcall(require, adapter_name)
					if ok then
						if type(adapter) == "table" and adapter.adapter then
							-- Adapter is a table with adapter function (like neotest-playwright)
							if next(adapter_config) ~= nil then
								table.insert(adapters, adapter.adapter(adapter_config))
							else
								table.insert(adapters, adapter.adapter())
							end
						elseif type(adapter) == "function" then
							-- Adapter is a function
							if next(adapter_config) ~= nil then
								table.insert(adapters, adapter(adapter_config))
							else
								table.insert(adapters, adapter)
							end
						else
							-- Adapter is a module
							table.insert(adapters, adapter)
						end
					else
						vim.notify("Failed to load test adapter: " .. adapter_name, vim.log.levels.WARN)
					end
				end
			end

			require("neotest").setup({ adapters = adapters })

			-- Keymap
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

			-- Future: Load DAP configs from language modules
			-- local languages = require("ivcota.languages")
			-- for _, lang_config in ipairs(languages.get_with_dap()) do
			--   if lang_config.dap then
			--     lang_config.dap.config(dap)
			--   end
			-- end
		end,
	},
}
