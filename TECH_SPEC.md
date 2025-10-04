# Neovim Configuration Architecture Tech Spec

## Overview

This specification defines patterns for modularizing plugin management, language tooling configuration, and test framework setup to improve maintainability and adaptability across different projects.

---

## Goals

1. **Modular Plugin Management**: Establish a clear, consistent pattern for adding plugins with their configurations co-located
2. **Language-Centric Configuration**: Create a unified interface for language tooling (LSP, formatters, linters, DAP, completion sources) that can be enabled/disabled per language
3. **Project-Adaptable Test Configuration**: Enable per-project or per-language test adapter configuration without modifying core config files

---

## Non-Goals

1. **Complete Rewrite**: Existing configurations should be migrated gradually, not all at once
2. **Breaking Changes**: The refactor should maintain backward compatibility with current plugin behavior
3. **Auto-Detection**: Will not implement automatic language detection or tooling installation (manual opt-in preferred)
4. **Plugin Abstraction Layer**: Won't create wrappers around plugin APIs; will use native plugin configurations
5. **Performance Optimization**: Not focused on startup time or lazy loading optimizations (use existing lazy.nvim features)

---

## Design

### 1. Plugin Management Pattern

**Current State**: Single flat array in `lua/ivcota/plugins.lua` (~190 lines) with separate `after/plugin/*.lua` files for configuration.

**Proposed Pattern**: Plugin specs with co-located configuration

```lua
-- lua/ivcota/plugins/telescope.lua
return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.2",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local telescope = require("telescope")
      -- Configuration here (from after/plugin/telescope.lua)
    end,
    keys = {
      { "<leader>pf", function() require("telescope.builtin").find_files() end },
      -- Other keymaps
    },
  }
}
```

**Structure**:
```
lua/ivcota/plugins/
├── init.lua              # Loads all plugin specs
├── core.lua              # Essential plugins (treesitter, plenary, etc)
├── lsp.lua               # LSP ecosystem (lsp-zero, mason, cmp)
├── editor.lua            # Editor enhancements (telescope, harpoon, etc)
├── ui.lua                # UI plugins (themes, airline, etc)
├── git.lua               # Git-related plugins
├── ai.lua                # AI tools (claude-code, supermaven)
├── test.lua              # Testing frameworks (neotest, dap)
└── lang/                 # Language-specific plugins
    ├── typescript.lua
    └── python.lua
```

**Key Principles**:
- Each file returns a list (or single) plugin spec compatible with lazy.nvim
- Configuration stays with plugin declaration (use `config` function)
- `after/plugin/*.lua` files are deprecated in favor of `config` functions
- Plugin categories are logical groupings, not strict boundaries

---

### 2. Language Configuration Pattern

**Current State**: Language servers, formatters, and test adapters scattered across `after/plugin/lsp.lua`, `after/plugin/nullrs.lua`, and `after/plugin/neotest.lua`.

**Proposed Pattern**: Language modules that declare all tooling needs

```lua
-- lua/ivcota/languages/typescript.lua
return {
  -- Language metadata
  name = "typescript",
  filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },

  -- LSP configuration
  lsp = {
    server = "ts_ls",
    config = {
      on_attach = function(client, bufnr)
        -- Custom on_attach
      end,
      settings = {
        -- Server-specific settings
      },
      commands = {
        OrganizeImports = {
          function()
            -- Implementation
          end,
          description = "Organize Imports",
        },
      },
    },
  },

  -- Formatting/linting
  formatting = {
    { "prettier", filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "json" } },
  },

  linting = {
    -- Optional linters
  },

  -- Completion sources
  completion = {
    -- Additional cmp sources if needed
  },

  -- Test adapter
  test = {
    adapter = "neotest-vitest",
    config = {
      -- Adapter-specific config
    },
  },

  -- DAP configuration (optional)
  dap = {
    adapter = "node",
    config = function(dap)
      -- DAP setup
    end,
  },
}
```

**Language Registry**:
```lua
-- lua/ivcota/languages/init.lua
local M = {}

-- Registry of enabled languages
M.enabled = {
  "typescript",
  "python",
  "go",
  "lua",
  -- Add/remove languages here
}

-- Load language config
function M.load(lang)
  local ok, config = pcall(require, "ivcota.languages." .. lang)
  if not ok then
    vim.notify("Language config not found: " .. lang, vim.log.levels.WARN)
    return nil
  end
  return config
end

-- Get all enabled language configs
function M.get_enabled()
  local configs = {}
  for _, lang in ipairs(M.enabled) do
    local config = M.load(lang)
    if config then
      table.insert(configs, config)
    end
  end
  return configs
end

return M
```

**Integration Points**:

1. **LSP Setup**: Modified `after/plugin/lsp.lua` (or new `lua/ivcota/plugins/lsp.lua`) consumes language configs:
```lua
local languages = require("ivcota.languages")

for _, lang_config in ipairs(languages.get_enabled()) do
  if lang_config.lsp then
    local lspconfig = require("lspconfig")
    local server_name = lang_config.lsp.server
    lspconfig[server_name].setup(lang_config.lsp.config or {})
  end
end
```

2. **Formatter/Linter Setup**: Modified null-ls setup:
```lua
local languages = require("ivcota.languages")
local null_ls = require("null-ls")

local sources = {}
for _, lang_config in ipairs(languages.get_enabled()) do
  if lang_config.formatting then
    for _, formatter in ipairs(lang_config.formatting) do
      table.insert(sources, null_ls.builtins.formatting[formatter[1]])
    end
  end
end

null_ls.setup({ sources = sources })
```

3. **Neotest Setup**: Modified to consume test adapters:
```lua
local languages = require("ivcota.languages")

local adapters = {}
for _, lang_config in ipairs(languages.get_enabled()) do
  if lang_config.test then
    local adapter = require(lang_config.test.adapter)
    if lang_config.test.config then
      table.insert(adapters, adapter(lang_config.test.config))
    else
      table.insert(adapters, adapter)
    end
  end
end

require("neotest").setup({ adapters = adapters })
```

---

### 3. Project-Specific Test Configuration

**Current State**: Neotest adapters hardcoded in `after/plugin/neotest.lua`. No way to override per project.

**Proposed Pattern**: Project-local overrides via `.nvim.lua` file

**Global Config** (`lua/ivcota/languages/typescript.lua`):
```lua
test = {
  adapter = "neotest-vitest",
  config = {
    -- Sensible defaults
  },
}
```

**Project Override** (`.nvim.lua` in project root):
```lua
-- .nvim.lua
return {
  test_overrides = {
    typescript = {
      adapter = "neotest-playwright",
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

**Override Loader**:
```lua
-- lua/ivcota/project.lua
local M = {}

function M.load_project_config()
  local config_path = vim.fn.getcwd() .. "/.nvim.lua"
  if vim.fn.filereadable(config_path) == 1 then
    return dofile(config_path)
  end
  return {}
end

function M.apply_test_overrides(lang_configs)
  local project_config = M.load_project_config()
  if not project_config.test_overrides then
    return lang_configs
  end

  for _, lang_config in ipairs(lang_configs) do
    local override = project_config.test_overrides[lang_config.name]
    if override then
      lang_config.test = vim.tbl_deep_extend("force", lang_config.test or {}, override)
    end
  end

  return lang_configs
end

return M
```

**Neotest Integration**:
```lua
local languages = require("ivcota.languages")
local project = require("ivcota.project")

local lang_configs = languages.get_enabled()
lang_configs = project.apply_test_overrides(lang_configs)

local adapters = {}
for _, lang_config in ipairs(lang_configs) do
  if lang_config.test then
    -- Adapter setup
  end
end
```

---

## Complexity Considerations

### 1. Migration Path

**Complexity**: Migrating 30+ plugins and 20+ after/plugin files is error-prone.

**Mitigation**:
- Keep existing structure working during migration
- Migrate in phases: core plugins → LSP → formatters → neotest → language-specific
- Use feature flags to toggle between old/new systems:
  ```lua
  -- lua/ivcota/config.lua
  return {
    use_modular_plugins = false,  -- Toggle to true when ready
    use_language_modules = false,
  }
  ```

### 2. Plugin Loading Order

**Complexity**: Some plugins depend on others being loaded first (e.g., lsp-zero before lspconfig).

**Mitigation**:
- Leverage lazy.nvim's `dependencies` and `priority` fields
- LSP ecosystem stays in one file (`lua/ivcota/plugins/lsp.lua`) to control load order
- Document load order requirements in plugin spec comments

### 3. Configuration Duplication

**Complexity**: Language config schema might lead to repetitive code.

**Mitigation**:
- Create helper functions for common patterns:
  ```lua
  -- lua/ivcota/languages/helpers.lua
  local M = {}

  function M.simple_lsp(server_name, filetypes, settings)
    return {
      lsp = {
        server = server_name,
        config = { settings = settings },
      },
      filetypes = filetypes,
    }
  end

  return M
  ```
- Simple languages can be very concise:
  ```lua
  -- lua/ivcota/languages/go.lua
  local helpers = require("ivcota.languages.helpers")
  return helpers.simple_lsp("gopls", { "go" }, {})
  ```

### 4. Project Config Security

**Complexity**: Loading arbitrary Lua from `.nvim.lua` is a security risk.

**Mitigation**:
- Prompt user on first load if they trust the project config
- Store trust decisions in `~/.config/nvim/trusted_projects.json`
- Sandboxing (advanced): Use `loadstring` with restricted environment
- Document that `.nvim.lua` should be in `.gitignore` or project-specific

### 5. LSP-Zero Dependency

**Complexity**: Current config heavily uses lsp-zero abstractions. Language modules assume direct lspconfig usage.

**Mitigation**:
- Keep lsp-zero for initial setup and on_attach defaults
- Language configs extend/override lsp-zero defaults:
  ```lua
  local base_on_attach = lsp.on_attach  -- From lsp-zero

  lspconfig.ts_ls.setup({
    on_attach = function(client, bufnr)
      base_on_attach(client, bufnr)  -- Apply lsp-zero defaults
      -- Then custom overrides
    end,
  })
  ```
- Alternative: Phase out lsp-zero in favor of explicit configuration

### 6. Neotest Adapter Variability

**Complexity**: Each neotest adapter has different config APIs. Hard to provide uniform interface.

**Mitigation**:
- Language config `test.config` is passed directly to adapter
- No abstraction layer; documentation references adapter's upstream docs
- Provide examples for common adapters (vitest, playwright, pytest) in language configs

---

## Key Decisions & Tradeoffs

### Decision 1: Co-located Plugin Config vs Separate after/plugin

**Choice**: Co-locate configuration in plugin spec using `config` function

**Tradeoffs**:
- ✅ **Pro**: Single source of truth; easier to see plugin + config together
- ✅ **Pro**: Aligns with lazy.nvim best practices
- ❌ **Con**: Longer files; less separation of concerns
- ❌ **Con**: Existing after/plugin files need migration

**Rationale**: Modern plugin managers encourage this pattern. Separation via multiple files in `lua/ivcota/plugins/` provides sufficient modularity.

---

### Decision 2: Language Registry vs Auto-Discovery

**Choice**: Explicit language registry (`languages.enabled` list)

**Tradeoffs**:
- ✅ **Pro**: Clear control over what's enabled; no surprises
- ✅ **Pro**: Faster startup (no filesystem scanning)
- ❌ **Con**: Manual step to enable a language
- ❌ **Con**: Could forget to add language to registry

**Rationale**: Neovim configs should be predictable. Auto-discovery adds complexity for minimal benefit. Enabling a language is a deliberate choice.

---

### Decision 3: Language Schema Flexibility vs Structure

**Choice**: Schema is documented but not enforced; language modules return plain tables

**Tradeoffs**:
- ✅ **Pro**: Flexible; can add new fields without breaking existing configs
- ✅ **Pro**: Simple to understand (no metatable magic)
- ❌ **Con**: Typos in field names won't be caught
- ❌ **Con**: No built-in validation

**Rationale**: Lua's dynamic nature works well here. Static typing would add complexity. Documentation + examples > validation for personal configs.

---

### Decision 4: Project Config via .nvim.lua vs project-specific branches

**Choice**: `.nvim.lua` file in project root

**Tradeoffs**:
- ✅ **Pro**: Per-project customization without branching config repo
- ✅ **Pro**: Easy to share team-specific settings (if committed)
- ❌ **Con**: Security concern (mitigated with trust prompts)
- ❌ **Con**: Another config file to manage

**Rationale**: Local overrides are common need (different test runners, formatters per project). Alternative of maintaining config branches doesn't scale.

---

### Decision 5: Formatter/Linter Integration Point

**Choice**: Language configs declare formatters; null-ls setup consumes them

**Tradeoffs**:
- ✅ **Pro**: Single place to manage all TypeScript tooling
- ✅ **Pro**: Easy to disable all TypeScript tooling by removing from `languages.enabled`
- ❌ **Con**: Tight coupling to null-ls (if we switch formatters, need to update integration)
- ❌ **Con**: Can't easily have project-specific formatter overrides (yet)

**Rationale**: Language-centric view is more intuitive than tool-centric. Changing formatter libraries is rare. Can extend project overrides to formatters later if needed.

---

### Decision 6: Gradual Migration vs Big Bang

**Choice**: Gradual migration with feature flags

**Tradeoffs**:
- ✅ **Pro**: Less risky; can roll back if issues arise
- ✅ **Pro**: Learn from migrating one category before doing next
- ❌ **Con**: Transitional state; two systems coexist temporarily
- ❌ **Con**: Feature flags add complexity

**Rationale**: Config is critical for productivity. Disrupting entire workflow in one go is high risk. Gradual approach allows validation at each step.

---

### Decision 7: Keep lsp-zero vs Raw lspconfig

**Choice**: Keep lsp-zero for now; extend with language configs

**Tradeoffs**:
- ✅ **Pro**: Less churn; existing keymaps and defaults work
- ✅ **Pro**: lsp-zero provides useful abstractions (on_attach, capabilities setup)
- ❌ **Con**: Extra layer of indirection
- ❌ **Con**: lsp-zero might not support all lspconfig features

**Rationale**: lsp-zero isn't the bottleneck for current goals. Can revisit later if it becomes limiting. Focus on language modularity first.

---

## Implementation Notes for AI Agent

When implementing this spec:

1. **Start Small**: Begin with 1-2 plugins (e.g., telescope, theme) to validate the pattern before mass migration
2. **Test Thoroughly**: After each migration step, verify the plugin works identically to before
3. **Preserve Behavior**: Keymaps, settings, and behavior should remain unchanged unless explicitly requested
4. **Document Helpers**: If creating helper functions, add usage examples in comments
5. **Language Priority**: When creating language modules, start with TypeScript (most complex) and Python (common) as reference implementations
6. **Trust Prompt**: Implement project config trust prompt early to avoid security concerns
7. **Diff Carefully**: Use git diff frequently to ensure changes align with spec

---

## Success Criteria

This refactor is successful when:

1. ✅ Adding a new plugin requires editing only one file (new file in `lua/ivcota/plugins/`)
2. ✅ Adding support for a new language requires editing only two files (new language file + add to registry)
3. ✅ Changing test adapters for a specific project requires only creating/editing `.nvim.lua` (no core config changes)
4. ✅ All existing plugins and language tooling work identically to before
5. ✅ New patterns are documented with examples that an AI agent can follow

---

## Future Enhancements (Out of Scope)

- Language-aware keybindings (e.g., different test keymaps per language)
- Automatic formatter/linter installation via Mason
- Project templates that pre-populate `.nvim.lua`
- Language config sharing via dotfiles registry
- UI for managing enabled languages (fuzzy search)

---

*This spec should be treated as a living document. Update it as implementation reveals new insights or challenges.*
