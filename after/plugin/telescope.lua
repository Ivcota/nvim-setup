-- local conf = require("telescope.config").values
-- local builtin = require("telescope.builtin")
--
-- -- Clone the vimgrep_arguments to avoid modifying the original table
-- local vimgrep_arguments_with_fixed_strings = vim.deepcopy(conf.vimgrep_arguments)
-- table.insert(vimgrep_arguments_with_fixed_strings, "--fixed-strings")
--
-- -- Telescope Mappings
-- vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
-- vim.keymap.set("n", "<leader>fg", function()
--   builtin.live_grep({ vimgrep_arguments = vimgrep_arguments_with_fixed_strings })
-- end, {})
--
-- vim.keymap.set("v", "<leader>fg", builtin.grep_string, {})
-- vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
-- vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
