-- SQL language configuration

return {
	-- Language metadata
	name = "sql",
	filetypes = { "sql", "mysql", "plsql" },

	-- Formatting
	formatting = {
		{ "sqlfmt", filetypes = { "sql", "mysql", "plsql" } },
	},

	-- SQL uses vim-dadbod for completion, configured separately
	-- No LSP server needed for basic SQL editing
}
