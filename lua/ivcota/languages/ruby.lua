-- Ruby language configuration

return {
  -- Language metadata
  name = "ruby",
  filetypes = { "ruby", "eruby" },

  -- LSP configuration
  lsp = {
    server = "ruby_lsp", -- Official Ruby LSP by Shopify (modern, fast)
    -- Alternative: "solargraph" (older, more mature)
    config = {
      settings = {
        ruby = {
          lint = {
            rubocop = {
              enabled = true,
            },
          },
          format = {
            enabled = true,
          },
        },
      },
      init_options = {
        formatter = "rubocop",
        enabledFeatures = {
          "documentSymbols",
          "documentHighlights",
          "foldingRanges",
          "selectionRanges",
          "semanticHighlighting",
          "formatting",
          "codeActions",
          "diagnostics",
          "completion",
          "hover",
          "signatureHelp",
        },
      },
    },
  },

  -- Formatting
  formatting = {
    { "rubocop", filetypes = { "ruby", "eruby" } },
    -- Alternative formatters:
    -- { "standardrb", filetypes = { "ruby", "eruby" } }, -- opinionated style guide
    -- { "rufo", filetypes = { "ruby", "eruby" } }, -- simpler formatter
  },

  -- Test adapter
  test = {
    adapter = "neotest-rspec",
    -- Alternative: "neotest-minitest" for minitest
    config = {
      rspec_cmd = function()
        return vim.tbl_flatten({
          "bundle",
          "exec",
          "rspec",
        })
      end,
    },
  },
}
