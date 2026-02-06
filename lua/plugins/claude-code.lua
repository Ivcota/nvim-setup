return {
  {
    "greggh/claude-code.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>mc", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude Code" },
      { "<leader>mf", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude Code" },
      { "<leader>mr", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude Session" },
      { "<leader>mC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude Session" },
      { "<leader>mm", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude Model" },
      { "<leader>mb", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add Buffer to Context" },
      { "<leader>ms", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send Selection to Claude" },
      { "<leader>ma", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept Diff" },
      { "<leader>md", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny Diff" },
    },
    opts = {},
  },
}
