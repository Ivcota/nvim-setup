-- TypeScript/JavaScript language configuration

return {
	-- Language metadata
	name = "typescript",
	filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },

	-- LSP configuration
	lsp = {
		server = "ts_ls",
		config = {
			commands = {
				OrganizeImports = {
					function()
						local params = {
							command = "_typescript.organizeImports",
							arguments = { vim.api.nvim_buf_get_name(0) },
							title = "",
						}
						vim.lsp.buf.execute_command(params)
					end,
					description = "Organize Imports",
				},
			},
			preferences = {
				importModuleSpecifierPreference = "relative",
				importModuleSpeciferEnding = "minimal",
			},
		},
	},

	-- Formatting
	formatting = {
		{ "prettier", filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "json" } },
	},

	-- Test adapters (vitest is default, can be overridden per-project with playwright)
	test = {
		adapter = "neotest-vitest",
		config = {},
	},

	-- Note: To use playwright for a specific project, create a .nvim.lua file:
	-- return {
	--   test_overrides = {
	--     typescript = {
	--       adapter = "neotest-playwright",
	--       config = {
	--         options = {
	--           persist_project_selection = true,
	--           enable_dynamic_test_discovery = true,
	--           preset = "headed",
	--         },
	--       },
	--     },
	--   },
	-- }
}
