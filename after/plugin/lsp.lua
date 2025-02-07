-- Import required modules
local lsp = require("lsp-zero")
local cmp = require("cmp")
local lspconfig = require("lspconfig")

-- LSP setup
lsp.preset("recommended")
lsp.ensure_installed({ "tsserver", "rust_analyzer" })
lsp.nvim_workspace()

-- CMP setup
vim.api.nvim_exec(
	[[
  autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
]],
	true
)
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
	["<C-y>"] = cmp.mapping.confirm({ select = true }),
	["<C-Space>"] = cmp.mapping.complete(),
})
cmp_mappings["<Tab>"] = cmp.mapping.confirm({ select = true })
cmp_mappings["<S-Tab>"] = cmp.mapping.select_prev_item(cmp_select)

lsp.setup_nvim_cmp({
	mapping = cmp_mappings,
	sorting = {
		priority_weight = 2,
		comparators = {
			cmp.config.compare.offset, -- Items closer to the cursor position
			cmp.config.compare.exact, -- Exact matches take precedence
			cmp.config.compare.score, -- Fuzzy matching score
			cmp.config.compare.locality, -- Items near the cursor in the document
			cmp.config.compare.recently_used, -- Favor recently used completions
			cmp.config.compare.kind, -- Group items by their kind/type
			cmp.config.compare.sort_text, -- Sort using the provided sort_text
			cmp.config.compare.length, -- Prefer shorter completion entries
			cmp.config.compare.order, -- Fallback: maintain the original order
		},
	},
})
-- LSP preferences
lsp.set_preferences({
	suggest_lsp_servers = false,
	sign_icons = { error = "E", warn = "W", hint = "H", info = "I" },
})

-- LSP key mappings
local function set_lsp_keymap(mode, key, action)
	local opts = { buffer = 0, remap = false } -- Adjust buffer value if needed
	vim.keymap.set(mode, key, action, opts)
end

lsp.on_attach(function(client, bufnr)
	-- set_lsp_keymap("n", "gd", function() vim.lsp.buf.definition() end)
	-- set_lsp_keymap("n", "gh", function() vim.lsp.buf.hover() end)
	-- set_lsp_keymap("n", "<leader>gr", function() vim.lsp.buf.references() end)
	set_lsp_keymap("n", "<leader>vws", function()
		vim.lsp.buf.workspace_symbol()
	end)
	set_lsp_keymap("n", "<leader>vd", function()
		vim.diagnostic.open_float()
	end)
	set_lsp_keymap("n", "[d", function()
		vim.diagnostic.goto_next()
	end)
	set_lsp_keymap("n", "]d", function()
		vim.diagnostic.goto_prev()
	end)
	set_lsp_keymap("n", "<leader>vca", function()
		vim.lsp.buf.code_action()
	end)
	set_lsp_keymap("n", "<leader>vrn", function()
		vim.lsp.buf.rename()
	end)
	set_lsp_keymap("i", "<C-h>", function()
		vim.lsp.buf.signature_help()
	end)
end)

-- Custom function to organize imports
local function organize_imports()
	local params = {
		command = "_typescript.organizeImports",
		arguments = { vim.api.nvim_buf_get_name(0) },
		title = "",
	}
	vim.lsp.buf.execute_command(params)
end

lspconfig.gopls.setup({})

lspconfig.tsserver.setup({
	on_attach = lsp.on_attach,
	capabilities = lsp.capabilities,
	commands = {
		OrganizeImports = {
			organize_imports,
			description = "Organize Imports",
		},
	},
	preferences = {
		importModuleSpecifierPreference = "relative",
		importModuleSpeciferEnding = "minimal",
	},
})

lspconfig.cssls.setup({
	filetypes = { "css", "scss", "less", "html", "vue", "svelte" },
})

lspconfig.pyright.setup({
	on_attach = lsp.on_attach,
	capabilities = lsp.capabilities,
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				diagnosticMode = "workspace",
				useLibraryCodeForTypes = true,
			},
		},
	},
})

-- Final setup
lsp.setup()
vim.diagnostic.config({ virtual_text = true })
