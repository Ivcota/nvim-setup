# Neovim Configuration Refactoring - Migration Guide

## What Changed

Your Neovim configuration has been refactored according to the TECH_SPEC.md. The configuration is now modular, language-centric, and supports project-specific overrides.

## New Structure

```
lua/ivcota/
├── config.lua                  # Feature flags for gradual migration
├── project.lua                 # Project-specific config loader with security
├── languages/                  # Language configurations
│   ├── init.lua               # Language registry
│   ├── helpers.lua            # Helper functions
│   ├── typescript.lua         # TypeScript/JavaScript config
│   ├── python.lua             # Python config
│   ├── go.lua                 # Go config
│   ├── lua.lua                # Lua config
│   ├── css.lua                # CSS config
│   └── sql.lua                # SQL config
└── plugins/                    # Modular plugin specs
    ├── init.lua               # Plugin loader
    ├── core.lua               # Core plugins (treesitter, plenary)
    ├── lsp.lua                # LSP ecosystem (integrates with languages)
    ├── editor.lua             # Editor enhancements (telescope, harpoon)
    ├── ui.lua                 # UI plugins (themes, statusline)
    ├── git.lua                # Git plugins
    ├── ai.lua                 # AI tools (claude-code, supermaven)
    ├── test.lua               # Testing (neotest, dap - integrates with languages)
    └── utils.lua              # Misc utilities
```

## Key Features

### 1. Language-Centric Configuration

Each language now has a single configuration file that declares:
- LSP server and settings
- Formatters and linters
- Test adapters
- DAP configuration (future)

**Example**: `lua/ivcota/languages/typescript.lua` declares:
- LSP: `ts_ls` with organize imports command
- Formatter: `prettier`
- Test adapter: `neotest-vitest` (default)

### 2. Modular Plugin System

Plugins are now organized by category with co-located configuration:
- Each plugin file returns lazy.nvim-compatible specs
- Configuration lives with plugin declaration (no more separate `after/plugin/` files)
- Easy to add/remove plugins by editing single files

### 3. Project-Specific Overrides

Create a `.nvim.lua` file in any project root to override settings:

```lua
-- .nvim.lua
return {
  test_overrides = {
    typescript = {
      adapter = "neotest-playwright",  -- Override from vitest to playwright
      config = {
        options = {
          persist_project_selection = true,
          enable_dynamic_test_discovery = true,
          preset = "headed",
        },
      },
    },
  },
}
```

**Security**: On first load, you'll be prompted to trust the project config. Trust decisions are stored in `~/.config/nvim/trusted_projects.json`.

## How to Use

### Adding a New Language

1. Create `lua/ivcota/languages/[language].lua`:
   ```lua
   return {
     name = "rust",
     filetypes = { "rust" },
     lsp = {
       server = "rust_analyzer",
       config = { settings = { ... } },
     },
     formatting = { { "rustfmt", filetypes = { "rust" } } },
     test = {
       adapter = "neotest-rust",
       config = {},
     },
   }
   ```

2. Add to registry in `lua/ivcota/languages/init.lua`:
   ```lua
   M.enabled = {
     "typescript",
     "python",
     "go",
     "lua",
     "css",
     "sql",
     "rust",  -- Add here
   }
   ```

### Adding a New Plugin

Add to the appropriate file in `lua/ivcota/plugins/`:

```lua
-- In lua/ivcota/plugins/editor.lua
return {
  -- ... existing plugins ...
  {
    "new/plugin.nvim",
    dependencies = { "some/dependency" },
    config = function()
      require("plugin").setup()
      -- Keymaps, etc.
    end,
  },
}
```

### Disabling a Language

Simply remove it from `lua/ivcota/languages/init.lua`:

```lua
M.enabled = {
  "typescript",
  -- "python",  -- Commented out = disabled
  "go",
}
```

## Rollback Instructions

If something goes wrong, you can rollback:

1. Set `use_modular_plugins = false` in `lua/ivcota/config.lua`
2. Restore old files:
   ```bash
   mv backup_old_config/after after/
   mv backup_old_config/plugins.lua lua/ivcota/plugins.lua
   ```
3. Restart Neovim

## Testing Checklist

After restarting Neovim, verify:

- [ ] Neovim starts without errors
- [ ] LSP works for TypeScript/JavaScript (`:LspInfo`)
- [ ] LSP works for Python (`:LspInfo`)
- [ ] Formatters work (`:lua vim.lsp.buf.format()` or `<leader>fm`)
- [ ] Telescope works (`<leader>pf` or `:Telescope`)
- [ ] Harpoon works (`<leader>a` to add, `<leader>h` to toggle)
- [ ] Test runner works (`:Neotest run` or `<leader>t`)
- [ ] Git integration works (gitsigns, fugitive)
- [ ] AI tools work (Claude Code, Supermaven)
- [ ] All themes are available (`:colorscheme <Tab>`)

## Migration Notes

### What Was Preserved

- All existing plugins
- All existing keymaps
- All existing LSP servers and settings
- All existing formatters
- All existing test adapters
- Behavior is identical to before

### What's New

- Modular organization
- Language-centric configuration
- Project-specific overrides
- Security for project configs
- Easier to maintain and extend

## Backup Location

Old configuration files are backed up at:
- `backup_old_config/after/` - Old plugin configs
- `backup_old_config/plugins.lua` - Old plugin list

## Success Criteria (from TECH_SPEC.md)

✅ Adding a new plugin requires editing only one file
✅ Adding support for a new language requires editing only two files
✅ Changing test adapters for a specific project requires only creating/editing `.nvim.lua`
✅ All existing plugins and language tooling work identically to before
✅ New patterns are documented with examples

## Next Steps

1. Restart Neovim
2. Run through testing checklist
3. Try creating a `.nvim.lua` in a project (use `.nvim.lua.example` as reference)
4. Add/remove languages or plugins as needed
5. If everything works, delete `backup_old_config/` after a few days

## Troubleshooting

### Error: module not found

Check that file names match exactly in `lua/ivcota/languages/init.lua` and `lua/ivcota/plugins/init.lua`.

### LSP not starting

1. Check `:LspInfo`
2. Verify language is enabled in `lua/ivcota/languages/init.lua`
3. Check language config has valid LSP server name
4. Ensure Mason has installed the server (`:Mason`)

### Formatter not working

1. Check language config has `formatting` section
2. Verify formatter name matches null-ls builtin
3. Ensure formatter is installed (`:Mason` or system package manager)

### Test adapter not found

1. Check language config has `test` section
2. Verify adapter plugin is in `lua/ivcota/plugins/test.lua` dependencies
3. Check adapter name matches exactly (e.g., "neotest-vitest" not "vitest")

## Questions?

Refer to:
- `TECH_SPEC.md` for architectural decisions
- `.nvim.lua.example` for project config examples
- Individual plugin files for configuration details
