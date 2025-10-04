-- Helper functions for creating language configurations

local M = {}

-- Create a simple LSP configuration
-- @param name string: Language name
-- @param server string: LSP server name
-- @param filetypes table: List of filetypes
-- @param settings table: LSP server settings (optional)
function M.simple_lsp(name, server, filetypes, settings)
	return {
		name = name,
		filetypes = filetypes,
		lsp = {
			server = server,
			config = {
				settings = settings or {},
			},
		},
	}
end

-- Create a language config with LSP and formatter
-- @param name string: Language name
-- @param server string: LSP server name
-- @param filetypes table: List of filetypes
-- @param formatter string or table: Formatter name or list of formatters
function M.with_formatter(name, server, filetypes, formatter)
	local config = M.simple_lsp(name, server, filetypes)

	if type(formatter) == "string" then
		config.formatting = { { formatter, filetypes = filetypes } }
	else
		config.formatting = formatter
	end

	return config
end

-- Create a language config with LSP, formatter, and test adapter
-- @param name string: Language name
-- @param server string: LSP server name
-- @param filetypes table: List of filetypes
-- @param formatter string or table: Formatter name or list of formatters
-- @param test_adapter string: Test adapter name (e.g., "neotest-vitest")
-- @param test_config table: Test adapter configuration (optional)
function M.full_config(name, server, filetypes, formatter, test_adapter, test_config)
	local config = M.with_formatter(name, server, filetypes, formatter)

	if test_adapter then
		config.test = {
			adapter = test_adapter,
			config = test_config or {},
		}
	end

	return config
end

return M
