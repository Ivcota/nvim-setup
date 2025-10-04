-- Python language configuration

return {
	-- Language metadata
	name = "python",
	filetypes = { "python" },

	-- LSP configuration
	lsp = {
		server = "pyright",
		config = {
			settings = {
				python = {
					analysis = {
						autoSearchPaths = true,
						diagnosticMode = "workspace",
						useLibraryCodeForTypes = true,
					},
				},
			},
		},
	},

	-- Formatting
	formatting = {
		{ "black", filetypes = { "python" } },
	},

	-- Test adapter
	test = {
		adapter = "neotest-python",
		config = {},
	},
}
