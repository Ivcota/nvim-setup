-- Lua language configuration

local helpers = require("ivcota.languages.helpers")

-- Lua with stylua formatter
return helpers.with_formatter("lua", "lua_ls", { "lua" }, "stylua")
