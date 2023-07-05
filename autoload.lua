vim.cmd([[
augroup InitNetrw
  autocmd!
  autocmd VimEnter * if expand("%") == "" | edit . | endif
augroup END
]])
