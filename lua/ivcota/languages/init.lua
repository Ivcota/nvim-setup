-- Language configuration registry
-- Manages enabled languages and provides access to their configs

local M = {}

-- Registry of enabled languages
-- Add or remove languages here to control what's loaded
M.enabled = {
  "typescript",
  "python",
  "go",
  "lua",
  "css",
  "sql",
  "ruby",
}

-- Cache for loaded language configs
local _loaded_configs = {}

-- Load a single language configuration
-- @param lang string: Language name
-- @return table|nil: Language config or nil if not found
function M.load(lang)
  -- Return cached config if available
  if _loaded_configs[lang] then
    return _loaded_configs[lang]
  end

  -- Try to load the language config
  local ok, config = pcall(require, "ivcota.languages." .. lang)
  if not ok then
    vim.notify("Language config not found: " .. lang .. "\nError: " .. tostring(config), vim.log.levels.WARN)
    return nil
  end

  -- Cache and return
  _loaded_configs[lang] = config
  return config
end

-- Get all enabled language configs
-- @return table: List of language configs
function M.get_enabled()
  local configs = {}
  for _, lang in ipairs(M.enabled) do
    local config = M.load(lang)
    if config then
      table.insert(configs, config)
    end
  end
  return configs
end

-- Get language configs that have LSP configuration
-- @return table: List of language configs with LSP
function M.get_with_lsp()
  local configs = {}
  for _, lang_config in ipairs(M.get_enabled()) do
    if lang_config.lsp then
      table.insert(configs, lang_config)
    end
  end
  return configs
end

-- Get language configs that have formatting configuration
-- @return table: List of language configs with formatters
function M.get_with_formatting()
  local configs = {}
  for _, lang_config in ipairs(M.get_enabled()) do
    if lang_config.formatting then
      table.insert(configs, lang_config)
    end
  end
  return configs
end

-- Get language configs that have test adapter configuration
-- @return table: List of language configs with test adapters
function M.get_with_tests()
  local configs = {}
  for _, lang_config in ipairs(M.get_enabled()) do
    if lang_config.test then
      table.insert(configs, lang_config)
    end
  end
  return configs
end

-- Get language configs that have DAP configuration
-- @return table: List of language configs with DAP
function M.get_with_dap()
  local configs = {}
  for _, lang_config in ipairs(M.get_enabled()) do
    if lang_config.dap then
      table.insert(configs, lang_config)
    end
  end
  return configs
end

-- Clear the config cache (useful for development/reloading)
function M.clear_cache()
  _loaded_configs = {}
end

return M
