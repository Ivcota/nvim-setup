-- AI-powered coding assistance plugins

return {
	-- Claude Code - Claude AI integration
	{
		"coder/claudecode.nvim",
		dependencies = { "folke/snacks.nvim" },
		config = true,
		keys = {
			{ "<leader>m", nil, desc = "AI/Claude Code" },
			{ "<leader>mc", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
			{ "<leader>mf", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
			{ "<leader>mr", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
			{ "<leader>mC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
			{ "<leader>mm", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
			{ "<leader>mb", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
			{ "<leader>ms", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
			{
				"<leader>ms",
				"<cmd>ClaudeCodeTreeAdd<cr>",
				desc = "Add file",
				ft = { "NvimTree", "neo-tree", "oil" },
			},
			-- Diff management
			{ "<leader>ma", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
			{ "<leader>md", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
		},
	},

	-- Supermaven - AI code completion
	{
		"supermaven-inc/supermaven-nvim",
		config = function()
			require("supermaven-nvim").setup({})
		end,
	},
}
