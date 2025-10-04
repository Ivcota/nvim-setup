# Neovim Configuration

A comprehensive Neovim setup optimized for TypeScript, Python, and general development work. This configuration aims to provide a VS Code-like experience while leveraging Neovim's power and extensibility.

## ✨ Features

- **AI-Powered Development** - Integrated Claude Code for intelligent code assistance
- **Advanced LSP** - Full language server support with auto-completion and diagnostics
- **Testing Integration** - Run and debug tests directly in Neovim with Neotest
- **Database Management** - Built-in database UI and query capabilities
- **Git Integration** - Comprehensive git workflow with fugitive, gitsigns, and lazygit
- **Fuzzy Finding** - Powerful file and content search with Telescope
- **Project Navigation** - Quick file switching with Harpoon
- **Debugging Support** - Full DAP integration for multiple languages
- **Theme Variety** - Multiple beautiful themes including Rose Pine, Tokyo Night, and Catppuccin

## 📋 Requirements

- **Neovim** >= 0.9.0
- **Git**
- **Node.js** >= 16.0.0 (for TypeScript LSP and tools)
- **Python** >= 3.8 (for Python LSP)
- **Ripgrep** (for Telescope search)
- **A Nerd Font** (for icons)

### Optional Dependencies

- **Lazygit** - Enhanced git UI
- **Database tools** - For database plugin functionality
- **Language-specific tools** - Formatters, linters, etc.

## 🚀 Installation

1. **Backup existing config** (if any):

   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Clone this configuration**:

   ```bash
   git clone <your-repo-url> ~/.config/nvim
   ```

3. **Start Neovim**:

   ```bash
   nvim
   ```

4. **Let Lazy.nvim install plugins** - This happens automatically on first run

5. **Install language servers** - Use `:Mason` to install LSPs for your languages

## 🔧 Core Plugins

### Package Management

- **[lazy.nvim](https://github.com/folke/lazy.nvim)** - Modern plugin manager

### LSP & Completion

- **[lsp-zero.nvim](https://github.com/VonHeikemen/lsp-zero.nvim)** - Zero-config LSP setup
- **[mason.nvim](https://github.com/williamboman/mason.nvim)** - LSP installer
- **[nvim-cmp](https://github.com/hrsh7th/nvim-cmp)** - Autocompletion engine
- **[copilot.lua](https://github.com/zbirenbaum/copilot.lua)** - GitHub Copilot integration

### AI Integration

- **[claudecode.nvim](https://github.com/coder/claudecode.nvim)** - Claude AI assistant integration

### Navigation & Search

- **[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)** - Fuzzy finder
- **[harpoon](https://github.com/ThePrimeagen/harpoon)** - Quick file navigation
- **[telescope-lsp-handlers](https://github.com/Slotos/telescope-lsp-handlers.nvim)** - Enhanced LSP integration

### Testing & Debugging

- **[neotest](https://github.com/nvim-neotest/neotest)** - Test runner
  - Python, Vitest, and Playwright adapters included
- **[nvim-dap](https://github.com/mfussenegger/nvim-dap)** - Debug adapter protocol

### Git Integration

- **[vim-fugitive](https://github.com/tpope/vim-fugitive)** - Git wrapper
- **[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)** - Git decorations
- **[git-blame.nvim](https://github.com/f-person/git-blame.nvim)** - Inline git blame

### Database

- **[vim-dadbod](https://github.com/tpope/vim-dadbod)** - Database interface
- **[vim-dadbod-ui](https://github.com/kristijanhusak/vim-dadbod-ui)** - Database UI
- **[vim-dadbod-completion](https://github.com/kristijanhusak/vim-dadbod-completion)** - SQL completion

### Code Quality

- **[none-ls.nvim](https://github.com/nvimtools/none-ls.nvim)** - Formatting and linting
- **[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)** - Syntax highlighting
- **[Comment.nvim](https://github.com/numToStr/Comment.nvim)** - Smart commenting
- **[refactoring.nvim](https://github.com/ThePrimeagen/refactoring.nvim)** - Refactoring tools

### UI & Themes

- **[rose-pine](https://github.com/rose-pine/neovim)** - Elegant theme
- **[tokyonight.nvim](https://github.com/folke/tokyonight.nvim)** - Tokyo Night theme
- **[catppuccin](https://github.com/catppuccin/nvim)** - Catppuccin theme
- **[kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim)** - Japanese-inspired theme
- **[snacks.nvim](https://github.com/folke/snacks.nvim)** - Enhanced UI components
- **[which-key.nvim](https://github.com/folke/which-key.nvim)** - Keybinding helper

### Utilities

- **[undotree](https://github.com/mbbill/undotree)** - Undo history visualizer
- **[toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)** - Terminal management
- **[vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator)** - Tmux integration
- **[zen-mode.nvim](https://github.com/folke/zen-mode.nvim)** - Distraction-free writing
- **[tsc.nvim](https://github.com/dmmulroy/tsc.nvim)** - TypeScript compiler integration

## ⌨️ Key Bindings

### Navigation

- `<C-p>` - Telescope file finder
- `<leader>fg` - Live grep search
- `<leader>fb` - Buffer search
- `<leader>fh` - Help tags search

### Harpoon (Quick Navigation)

- Check `after/plugin/harpoon.lua` for specific bindings

### Flash (Enhanced Navigation)

- `s` - Flash jump (normal, visual, operator modes)
- `S` - Flash treesitter jump (normal, visual, operator modes)
- `r` - Remote flash (operator mode)
- `R` - Treesitter search flash (operator, visual modes)
- `<C-s>` - Toggle flash search (command mode)

### Git

- `<leader>gs` - Git status (fugitive)
- `<leader>gc` - Git commit
- `<leader>gp` - Git push
- `<leader>gl` - Git log

### Testing

- Test-related keybindings configured in `after/plugin/neotest.lua`

### LSP

- `gd` - Go to definition
- `K` - Hover documentation
- `<leader>ca` - Code actions
- `<leader>rn` - Rename symbol

## 🎨 Themes

This configuration includes several themes:

- Rose Pine (elegant and minimal)
- Tokyo Night (dark with vibrant colors)
- Catppuccin (pastel colors)
- Kanagawa (Japanese-inspired)
- Material Theme
- OneDark
- Doom One

Switch themes using `:colorscheme <theme-name>`

## 📁 File Structure

```
~/.config/nvim/
├── init.lua                 # Main entry point
├── lua/ivcota/
│   ├── init.lua            # Core configuration loader
│   ├── config.lua          # Main configuration
│   ├── project.lua         # Project-specific settings
│   ├── settings.lua        # Neovim settings
│   ├── custom_mappings.lua # Custom key mappings
│   ├── auto_load.lua       # Auto-loading utilities
│   ├── plugins/            # Plugin specifications by category
│   │   ├── init.lua        # Plugin loader
│   │   ├── core.lua        # Core plugins (lazy.nvim)
│   │   ├── lsp.lua         # LSP plugins
│   │   ├── editor.lua      # Editor enhancements
│   │   ├── ui.lua          # UI and themes
│   │   ├── git.lua         # Git integration
│   │   ├── ai.lua          # AI tools
│   │   ├── test.lua        # Testing plugins
│   │   └── utils.lua       # Utility plugins
│   ├── languages/          # Language-specific configurations
│   │   ├── init.lua        # Language config loader
│   │   ├── typescript.lua  # TypeScript/JavaScript
│   │   ├── python.lua      # Python
│   │   ├── go.lua          # Go
│   │   ├── lua.lua         # Lua
│   │   ├── css.lua         # CSS/SCSS/Less
│   │   ├── sql.lua         # SQL
│   │   └── helpers.lua     # Language config helpers
│   └── lsp/                # LSP configuration helpers
```

## 🔧 Customization

### Adding New Language Servers (LSPs)

This configuration uses **lsp-zero** with **Mason** for LSP management. To add a new language server:

1. **Install via Mason** (recommended):

   ```vim
   :Mason
   ```

   Search and install your desired LSP server (e.g., `rust_analyzer`, `clangd`, `gopls`)

2. **Add to auto-install list** in `lua/ivcota/plugins/lsp.lua`:

   ```lua
   lsp.ensure_installed({ "ts_ls", "rust_analyzer", "your_new_lsp" })
   ```

3. **Configure specific LSP settings** (optional) in `lua/ivcota/languages/`:
   ```lua
   -- Create or edit a language config file (e.g., lua/ivcota/languages/rust.lua)
   return {
     lsp = {
       server = "rust_analyzer",
       settings = {
         -- LSP-specific settings here
       },
     },
   }
   ```

#### Current LSP Configurations:

- **TypeScript/JavaScript**: `ts_ls` with organize imports support
- **Python**: `pyright` with workspace analysis
- **Go**: `gopls` with default settings
- **CSS**: `cssls` for CSS, SCSS, Less, Vue, Svelte
- **Rust**: `rust_analyzer` (auto-installed)

### Adding Formatters and Linters

This configuration uses **none-ls** (formerly null-ls) for formatting and linting:

1. **Add formatter/linter** to `lua/ivcota/plugins/lsp.lua` or the relevant language config:

   ```lua
   null_ls.setup({
     sources = {
       null_ls.builtins.formatting.stylua,     -- Lua formatter
       null_ls.builtins.formatting.prettier,   -- JS/TS/JSON/etc formatter
       null_ls.builtins.formatting.black,      -- Python formatter
       null_ls.builtins.formatting.sqlfmt,     -- SQL formatter
       -- Add your new formatter here:
       null_ls.builtins.formatting.your_formatter,
       null_ls.builtins.diagnostics.your_linter,
     },
   })
   ```

2. **Install the underlying tool** via Mason or your system package manager:

   ```bash
   # Examples:
   npm install -g prettier
   pip install black
   cargo install stylua
   ```

3. **Format using** `<leader>fm` or `:lua vim.lsp.buf.format()`

#### Current Formatters:

- **Lua**: `stylua`
- **JavaScript/TypeScript**: `prettier`
- **Python**: `black`
- **SQL**: `sqlfmt`

### Adding New Plugins

Add plugins to the appropriate file in `lua/ivcota/plugins/`:

```lua
-- Add to the relevant category file (e.g., editor.lua, ui.lua, utils.lua)
"author/plugin-name",
-- or with configuration
{
    "author/plugin-name",
    config = function()
        -- Plugin setup
    end,
}
```

### Modifying Settings

- **Neovim settings**: Edit `lua/ivcota/settings.lua`
- **Project settings**: Edit `lua/ivcota/project.lua`
- **Plugin configs**: Edit the relevant file in `lua/ivcota/plugins/`
- **Language configs**: Edit the relevant file in `lua/ivcota/languages/`

### Custom Key Mappings

Add custom mappings to `lua/ivcota/custom_mappings.lua`

## 🐛 Troubleshooting

### Plugin Issues

- Run `:Lazy sync` to update plugins
- Use `:Lazy clean` to remove unused plugins
- Check `:Lazy health` for plugin status

### LSP Issues

- Use `:Mason` to manage language servers
- Run `:LspInfo` to check LSP status
- Use `:LspRestart` to restart language servers

### Performance Issues

- Check startup time with `nvim --startuptime startup.log`
- Consider lazy-loading plugins in `plugins.lua`

## 📝 Notes

- This configuration prioritizes TypeScript and Python development but is flexible for other languages
- The setup aims to replicate VS Code functionality while maintaining Neovim's efficiency
- Claude Code integration provides AI-powered assistance directly in your editor
- All major development workflows (coding, testing, debugging, git) are integrated

## 🤝 Contributing

Feel free to suggest improvements or report issues. This configuration is continuously evolving based on development needs.
