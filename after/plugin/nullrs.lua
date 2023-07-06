local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.completion.spell,
		null_ls.builtins.formatting.prettier,
	},
})

vim.keymap.set(
	"n",
	"<leader>fm",
	"<cmd>lua vim.lsp.buf.format({ timeout_ms = 8000 })<CR>",
	{ noremap = true, silent = true }
)
