-- Load configuration
local config = require("ivcota.config")

require("ivcota.auto_load")
require("ivcota.custom_mappings")
require("ivcota.settings")

-- Load plugins based on configuration
if config.use_modular_plugins then
	-- New modular plugin system
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not vim.loop.fs_stat(lazypath) then
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable",
			lazypath,
		})
	end
	vim.opt.rtp:prepend(lazypath)

	-- Load all plugin modules
	local plugin_loader = require("ivcota.plugins")
	local plugins = plugin_loader.load()

	require("lazy").setup(plugins, {})
else
	-- Old plugin system (for backward compatibility)
	require("ivcota.plugins")
end

print("🚀 Welcome back, Iverson! Your Neovim setup is ready to roll! Let's build something amazing! 🔥")
