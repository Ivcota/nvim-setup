-- Tag related settings
vim.g.closetag_filenames = "*.html,*.xhtml,*.phtml"
vim.g.closetag_xhtml_filenames = "*.xhtml,*.jsx, *.tsx"
vim.g.closetag_filetypes = "html,xhtml,phtml"
vim.g.closetag_xhtml_filetypes = "xhtml,jsx"
vim.g.closetag_emptyTags_caseSensitive = 1
vim.g.closetag_regions = {
	["typescript.tsx"] = "jsxRegion,tsxRegion",
	["javascript.jsx"] = "jsxRegion",
	["typescriptreact"] = "jsxRegion,tsxRegion",
	["javascriptreact"] = "jsxRegion",
}
vim.g.closetag_shortcut = ">"
vim.g.closetag_close_shortcut = "<leader>>"
