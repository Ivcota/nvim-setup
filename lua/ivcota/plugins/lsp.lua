-- LSP, completion, and formatting plugins

return {
	-- LSP Zero - LSP configuration framework
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{
				"williamboman/mason.nvim",
				build = function()
					pcall(vim.cmd, "MasonUpdate")
				end,
			},
			{ "williamboman/mason-lspconfig.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "L3MON4D3/LuaSnip" },
			{ "onsails/lspkind.nvim" },
		},
		config = function()
			local lsp = require("lsp-zero")
			local cmp = require("cmp")
			local lspconfig = require("lspconfig")

			-- LSP Zero preset
			lsp.preset("recommended")
			lsp.ensure_installed({ "ts_ls", "rust_analyzer" })
			lsp.nvim_workspace()

			-- CMP setup for SQL completion (dadbod)
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "sql", "mysql", "plsql" },
				callback = function()
					cmp.setup.buffer({
						sources = {
							{ name = "vim-dadbod-completion" },
						},
						formatting = {
							format = require("lspkind").cmp_format({
								mode = "symbol",
								maxwidth = 50,
								ellipsis_char = "...",
							}),
						},
					})
				end,
			})

			-- CMP mappings
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
				sources = {
					{ name = "nvim_lsp" },
					{ name = "supermaven" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				},
				sorting = {
					priority_weight = 2,
					comparators = {
						cmp.config.compare.offset,
						cmp.config.compare.exact,
						cmp.config.compare.score,
						cmp.config.compare.locality,
						cmp.config.compare.recently_used,
						cmp.config.compare.kind,
						cmp.config.compare.sort_text,
						cmp.config.compare.length,
						cmp.config.compare.order,
					},
				},
			})

			-- LSP preferences
			lsp.set_preferences({
				suggest_lsp_servers = false,
				sign_icons = { error = "E", warn = "W", hint = "H", info = "I" },
			})

			-- LSP keymaps
			lsp.on_attach(function(client, bufnr)
				local function set_lsp_keymap(mode, key, action)
					local opts = { buffer = bufnr, remap = false }
					vim.keymap.set(mode, key, action, opts)
				end

				-- Remove default keymaps
				pcall(vim.api.nvim_buf_del_keymap, bufnr, "n", "gr")
				pcall(vim.api.nvim_buf_del_keymap, bufnr, "n", "gh")
				pcall(vim.api.nvim_buf_del_keymap, bufnr, "n", "gd")

				-- Custom keymaps
				set_lsp_keymap("n", "gh", function()
					-- Temporarily suppress "No information available" notifications during hover
					local original_notify = vim.notify
					vim.notify = function(msg, level, opts)
						if type(msg) == "string" and msg:match("No information available") then
							return
						end
						original_notify(msg, level, opts)
					end

					vim.lsp.buf.hover()

					-- Restore original notify after a short delay
					vim.defer_fn(function()
						vim.notify = original_notify
					end, 100)
				end)
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

			-- Load language configurations and setup LSP servers
			local languages = require("ivcota.languages")
			for _, lang_config in ipairs(languages.get_with_lsp()) do
				local server_name = lang_config.lsp.server
				local config = lang_config.lsp.config or {}

				-- Merge with lsp-zero defaults
				config.on_attach = config.on_attach or lsp.on_attach
				config.capabilities = config.capabilities or lsp.capabilities

				lspconfig[server_name].setup(config)
			end

			-- Finalize LSP setup
			lsp.setup()
			vim.diagnostic.config({ virtual_text = true })
		end,
	},

	-- null-ls - formatters and linters
	{
		"nvimtools/none-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local null_ls = require("null-ls")
			local languages = require("ivcota.languages")

			-- Collect formatters from language configs
			local sources = {}
			for _, lang_config in ipairs(languages.get_with_formatting()) do
				if lang_config.formatting then
					for _, formatter in ipairs(lang_config.formatting) do
						local formatter_name = formatter[1] or formatter
						if null_ls.builtins.formatting[formatter_name] then
							table.insert(sources, null_ls.builtins.formatting[formatter_name])
						else
							vim.notify("Unknown formatter: " .. formatter_name, vim.log.levels.WARN)
						end
					end
				end
			end

			-- Add spell completion
			table.insert(sources, null_ls.builtins.completion.spell)

			null_ls.setup({ sources = sources })

			-- Format keymap
			vim.keymap.set(
				"n",
				"<leader>fm",
				"<cmd>lua vim.lsp.buf.format({ timeout_ms = 8000 })<CR>",
				{ noremap = true, silent = true, desc = "Format buffer" }
			)
		end,
	},

	-- TypeScript utilities
	{
		"dmmulroy/tsc.nvim",
		config = function()
			require("tsc").setup()
		end,
	},
}
