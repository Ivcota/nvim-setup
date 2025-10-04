-- Go language configuration

local helpers = require("ivcota.languages.helpers")

-- Simple LSP setup for Go
return helpers.simple_lsp("go", "gopls", { "go" })
