-- CSS language configuration

return {
	-- Language metadata
	name = "css",
	filetypes = { "css", "scss", "less", "vue", "svelte" },

	-- LSP configuration
	lsp = {
		server = "cssls",
		config = {},
	},

	-- CSS files are typically formatted by prettier (if used in the project)
	-- Can be overridden per-project if needed
}
