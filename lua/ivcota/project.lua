-- Project-specific configuration loader
-- Loads .nvim.lua files from project root with security checks

local M = {}

-- Path to store trusted projects
local trust_file = vim.fn.stdpath("config") .. "/trusted_projects.json"

-- Load trusted projects list
local function load_trusted_projects()
	if vim.fn.filereadable(trust_file) == 0 then
		return {}
	end

	local content = vim.fn.readfile(trust_file)
	local ok, trusted = pcall(vim.json.decode, table.concat(content, "\n"))
	if not ok then
		return {}
	end

	return trusted or {}
end

-- Save trusted projects list
local function save_trusted_projects(trusted)
	local json = vim.json.encode(trusted)
	vim.fn.writefile({ json }, trust_file)
end

-- Check if a project is trusted
local function is_project_trusted(project_path)
	local trusted = load_trusted_projects()
	return trusted[project_path] == true
end

-- Mark a project as trusted
local function trust_project(project_path)
	local trusted = load_trusted_projects()
	trusted[project_path] = true
	save_trusted_projects(trusted)
end

-- Prompt user to trust a project
local function prompt_trust(project_path, config_path)
	local choice = vim.fn.confirm(
		string.format(
			"Found project config at:\n%s\n\nDo you trust this project configuration?",
			config_path
		),
		"&Yes\n&No\n&View File",
		2
	)

	if choice == 1 then
		trust_project(project_path)
		return true
	elseif choice == 3 then
		vim.cmd("edit " .. config_path)
		return prompt_trust(project_path, config_path)
	end

	return false
end

-- Load project configuration
function M.load_project_config()
	local cwd = vim.fn.getcwd()
	local config_path = cwd .. "/.nvim.lua"

	if vim.fn.filereadable(config_path) == 0 then
		return {}
	end

	-- Check if project is trusted
	if not is_project_trusted(cwd) then
		if not prompt_trust(cwd, config_path) then
			vim.notify(
				"Project config not loaded (untrusted): " .. config_path,
				vim.log.levels.WARN
			)
			return {}
		end
	end

	-- Load the config
	local ok, config = pcall(dofile, config_path)
	if not ok then
		vim.notify(
			"Error loading project config: " .. tostring(config),
			vim.log.levels.ERROR
		)
		return {}
	end

	return config or {}
end

-- Apply test overrides from project config to language configs
function M.apply_test_overrides(lang_configs)
	local project_config = M.load_project_config()
	if not project_config.test_overrides then
		return lang_configs
	end

	for _, lang_config in ipairs(lang_configs) do
		local override = project_config.test_overrides[lang_config.name]
		if override then
			lang_config.test = vim.tbl_deep_extend("force", lang_config.test or {}, override)
		end
	end

	return lang_configs
end

-- Apply formatter overrides from project config
function M.apply_formatter_overrides(lang_configs)
	local project_config = M.load_project_config()
	if not project_config.formatter_overrides then
		return lang_configs
	end

	for _, lang_config in ipairs(lang_configs) do
		local override = project_config.formatter_overrides[lang_config.name]
		if override then
			lang_config.formatting = override
		end
	end

	return lang_configs
end

return M
