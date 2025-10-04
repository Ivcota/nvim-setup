-- Configuration flags for gradual migration
-- Toggle these to switch between old and new systems

local M = {}

-- Set to true to use the new modular plugin system
M.use_modular_plugins = true

-- Set to true to use the new language module system
M.use_language_modules = true

-- Set to true to enable project-specific config loading
M.enable_project_config = true

return M
