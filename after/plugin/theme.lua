function SetColorScheme(name)
	vim.cmd("colorscheme " .. name)
	vim.opt.termguicolors = true
end

SetColorScheme("rose-pine")
