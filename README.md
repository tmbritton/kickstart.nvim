# Personal Neovim Configuration

This is a personalized Neovim configuration based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). It maintains the clean, readable structure of kickstart while adding custom plugins, keymaps, and language-specific tooling.

## Structure

The configuration follows kickstart's modular approach with custom modifications organized in the `lua/custom/` directory:

```
~/.config/nvim/
├── init.lua              # Base kickstart configuration
└── lua/custom/
    ├── init.lua         # Loads all custom configurations
    ├── keymaps.lua      # Custom keymaps
    ├── options.lua      # Custom vim options
    ├── layout.lua       # Auto-open file tree setup
    └── plugins/
        └── init.lua     # Custom plugins and overrides
```

## Key Customizations

### Language Support
- **Go**: Full LSP support with `gopls`, formatting with `gofumpt` and `goimports`
- **TypeScript/JavaScript**: Enhanced tooling with `typescript-tools.nvim`
- **Gleam**: LSP support for the Gleam programming language

### Added Plugins
- **nvim-tree**: File explorer with auto-open on startup
- **typescript-tools**: Enhanced TypeScript development experience

### Enhanced Features
- **Hidden files**: Telescope searches include hidden files and directories
- **Diagnostic floating window**: `<leader>df` to show full error messages
- **File tree shortcuts**: `<leader>e` to toggle, `<leader>fe` to focus
- **Custom layout**: Auto-opens file tree on startup for regular files

### Development Settings
- **Indentation**: 2 spaces for most files, 4 spaces for Python
- **Nerd Font**: Enabled for better icons and UI
- **Clipboard**: Synced with system clipboard
- **Smart case search**: Case-insensitive unless capitals are used

## Installation

1. **Backup your existing configuration:**
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Clone this repository:**
   ```bash
   git clone <your-repo-url> ~/.config/nvim
   ```

3. **Start Neovim:**
   ```bash
   nvim
   ```
   
   Lazy.nvim will automatically install all plugins on first run.

## Updating

This configuration is designed to be easily updated:

1. **Update kickstart base:**
   ```bash
   # Replace init.lua with latest kickstart version
   curl -o ~/.config/nvim/init.lua https://raw.githubusercontent.com/nvim-lua/kickstart.nvim/master/init.lua
   
   # Ensure custom import is uncommented
   # { import = 'custom.plugins' },
   
   # Ensure custom require is at the end
   # require 'custom'
   ```

2. **All customizations in `lua/custom/` remain untouched**

## Key Mappings

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>df` | Diagnostic Float | Show full diagnostic message |
| `<leader>e` | Toggle File Tree | Open/close nvim-tree |
| `<leader>fe` | Focus File Tree | Focus on nvim-tree window |
| `"+y` | System Copy | Copy to system clipboard |
| `"+p` | System Paste | Paste from system clipboard |

## Language Servers

The following language servers are automatically installed and configured:

- **lua_ls**: Lua language server
- **gopls**: Go language server
- **gleam**: Gleam language server
- **typescript-tools**: Enhanced TypeScript/JavaScript support

## Formatters

Auto-formatting on save is configured for:

- **Lua**: stylua
- **Go**: gofumpt + goimports
- **TypeScript/JavaScript**: prettier/prettierd

