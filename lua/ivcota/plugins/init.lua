-- Plugin loader - loads all plugin modules
-- Each module should return a plugin spec (or array of specs) compatible with lazy.nvim

local M = {}

-- Load all plugin modules
function M.load()
	local modules = {
		"ivcota.plugins.core",
		"ivcota.plugins.ui",
		"ivcota.plugins.editor",
		"ivcota.plugins.lsp",
		"ivcota.plugins.git",
		"ivcota.plugins.ai",
		"ivcota.plugins.test",
		"ivcota.plugins.utils",
	}

	local plugins = {}

	for _, module_name in ipairs(modules) do
		local ok, module = pcall(require, module_name)
		if ok then
			-- If module returns a table, it could be a single spec or array of specs
			if type(module) == "table" then
				-- Check if it's a single spec (has a [1] that's a string = plugin name)
				if type(module[1]) == "string" then
					table.insert(plugins, module)
				else
					-- It's an array of specs
					for _, spec in ipairs(module) do
						table.insert(plugins, spec)
					end
				end
			end
		else
			vim.notify("Failed to load plugin module: " .. module_name .. "\n" .. tostring(module), vim.log.levels.ERROR)
		end
	end

	return plugins
end

return M
