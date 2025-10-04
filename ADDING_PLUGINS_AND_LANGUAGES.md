# Adding Plugins and Languages

This guide explains how to add new plugins and language support to your Neovim configuration.

## Adding New Plugins

### 1. Choose the Right Category File

Plugins are organized by category in `lua/ivcota/plugins/`:

- `core.lua` - Essential plugins (treesitter, plenary)
- `ui.lua` - UI enhancements (colorschemes, statusline, icons)
- `editor.lua` - Editor enhancements (telescope, harpoon, commenting)
- `lsp.lua` - LSP and completion plugins
- `git.lua` - Git integration plugins
- `ai.lua` - AI coding assistants
- `test.lua` - Testing frameworks
- `utils.lua` - Utility plugins

### 2. Add Plugin Spec to Category File

Open the appropriate category file and add your plugin spec following the [lazy.nvim](https://github.com/folke/lazy.nvim) format:

```lua
-- lua/ivcota/plugins/editor.lua
return {
  -- ... existing plugins ...

  -- Your new plugin
  {
    "username/plugin-name",
    -- Optional: specify version, branch, or tag
    version = "*",  -- or branch = "main", or tag = "v1.0.0"

    -- Optional: dependencies
    dependencies = {
      "nvim-lua/plenary.nvim",
    },

    -- Optional: lazy loading
    lazy = false,  -- load on startup
    event = "VeryLazy",  -- or load on specific events
    ft = { "python", "lua" },  -- or load for specific filetypes
    cmd = "PluginCommand",  -- or load when command is used
    keys = {  -- or load when key is pressed
      { "<leader>p", "<cmd>PluginCommand<cr>", desc = "Plugin command" }
    },

    -- Optional: configuration function
    config = function()
      require("plugin-name").setup({
        -- plugin options here
      })

      -- Add keymaps
      vim.keymap.set("n", "<leader>p", ":PluginCommand<CR>", { desc = "Plugin command" })
    end,
  },
}
```

### 3. Create New Category (Optional)

If your plugin doesn't fit existing categories:

1. Create a new file: `lua/ivcota/plugins/mycategory.lua`
2. Add your plugin specs following the format above
3. Register it in `lua/ivcota/plugins/init.lua`:

```lua
-- lua/ivcota/plugins/init.lua
function M.load()
  local modules = {
    -- ... existing modules ...
    "ivcota.plugins.mycategory",  -- Add your new category
  }
  -- ...
end
```

### 4. Restart Neovim

Restart Neovim and lazy.nvim will automatically install the new plugin.

## Adding New Languages

### 1. Create Language Configuration File

Create a new file in `lua/ivcota/languages/` named after your language (e.g., `rust.lua`):

```lua
-- lua/ivcota/languages/rust.lua
return {
  -- Language metadata
  name = "rust",
  filetypes = { "rust" },

  -- LSP configuration (required)
  lsp = {
    server = "rust_analyzer",  -- LSP server name
    config = {
      -- Optional: LSP-specific settings
      settings = {
        ["rust-analyzer"] = {
          cargo = {
            allFeatures = true,
          },
        },
      },
    },
  },

  -- Formatting configuration (optional)
  formatting = {
    { "rustfmt", filetypes = { "rust" } },
  },

  -- Test adapter configuration (optional)
  test = {
    adapter = "neotest-rust",
    config = {},
  },

  -- Debug adapter configuration (optional)
  dap = {
    adapter = "codelldb",
    config = {
      -- DAP configuration here
    },
  },
}
```

### 2. Enable the Language

Add your language to the enabled list in `lua/ivcota/languages/init.lua`:

```lua
-- lua/ivcota/languages/init.lua
M.enabled = {
  "typescript",
  "python",
  "go",
  "lua",
  "css",
  "sql",
  "rust",  -- Add your language here
}
```

### 3. Install Language Tools

Install the required tools for your language:

```bash
# Install LSP server
# For rust: rustup component add rust-analyzer

# Install formatter (if needed)
# For rust: rustup component add rustfmt

# Install test adapter (if needed)
# Install neotest adapter via plugin manager if not already included
```

### 4. Add Test Adapter Plugin (if needed)

If using a test adapter, add the neotest adapter plugin to `lua/ivcota/plugins/test.lua`:

```lua
-- lua/ivcota/plugins/test.lua
{
  "nvim-neotest/neotest",
  dependencies = {
    -- ... existing adapters ...
    "rouge8/neotest-rust",  -- Add test adapter dependency
  },
  -- ...
}
```

### 5. Restart Neovim

Restart Neovim and your language support will be active.

## Language Configuration Reference

### Available Fields

- **`name`** (string, required): Language identifier
- **`filetypes`** (table, required): List of associated filetypes
- **`lsp`** (table, optional): LSP configuration
  - `server` (string): LSP server name (see [mason-lspconfig](https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md))
  - `config` (table): LSP server configuration passed to `lspconfig[server].setup()`
- **`formatting`** (table, optional): List of formatters with filetypes
- **`test`** (table, optional): Test adapter configuration
  - `adapter` (string): Neotest adapter name
  - `config` (table): Adapter configuration
- **`dap`** (table, optional): Debug adapter configuration
  - `adapter` (string): DAP adapter name
  - `config` (table): DAP configuration

### Example: Full Language Config

See `lua/ivcota/languages/typescript.lua` for a complete example with all features.

## Per-Project Overrides

You can override language settings per project using `.nvim.lua` files. See the example in `lua/ivcota/languages/typescript.lua` for test adapter overrides.

## Finding LSP Server Names

LSP server names can be found in the [mason-lspconfig server mapping](https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md).

## Troubleshooting

### Plugin Not Loading

- Check for errors: `:Lazy log`
- Ensure the plugin spec is correctly formatted
- Verify dependencies are installed

### Language Not Working

- Check if language is in enabled list: `:lua print(vim.inspect(require('ivcota.languages').enabled))`
- Verify LSP server is installed: `:Mason`
- Check LSP status: `:LspInfo`
- View language config: `:lua print(vim.inspect(require('ivcota.languages').load('rust')))`

### Clearing Language Cache

If making changes to language configs during development:

```lua
:lua require('ivcota.languages').clear_cache()
```
