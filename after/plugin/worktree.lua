require('git-worktree').setup()
require('telescope').load_extension('git_worktree')


vim.keymap.set("n", "<leader>sr", "<CMD>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>",
  { desc = "Git Worktrees" })

vim.keymap.set("n", "<leader>sR", "<CMD>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>",
  { desc = "Create Git Worktree" })
