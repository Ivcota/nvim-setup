-- Formatting with conform.nvim

return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>fm",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				desc = "Format buffer",
			},
		},
		opts = {
			formatters_by_ft = {
				-- JavaScript/TypeScript
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				typescriptreact = { "prettierd", "prettier", stop_after_first = true },
				javascriptreact = { "prettierd", "prettier", stop_after_first = true },
				json = { "prettierd", "prettier", stop_after_first = true },
				jsonc = { "prettierd", "prettier", stop_after_first = true },

				-- Web
				css = { "prettierd", "prettier", stop_after_first = true },
				scss = { "prettierd", "prettier", stop_after_first = true },
				html = { "prettierd", "prettier", stop_after_first = true },
				markdown = { "prettierd", "prettier", stop_after_first = true },
				yaml = { "prettierd", "prettier", stop_after_first = true },

				-- Other languages
				python = { "ruff_format", "black", stop_after_first = true },
				go = { "gofmt" },
				lua = { "stylua" },
				ruby = { "rubocop" },
				sql = { "sqlfmt" },

				-- Fallback: trim whitespace for any filetype
				["_"] = { "trim_whitespace" },
			},

			-- Don't format on save by default (use <leader>fm instead)
			format_on_save = nil,

			-- Notify on errors
			notify_on_error = true,
		},
	},
}
