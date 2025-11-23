# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a personalized Neovim configuration based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). The configuration maintains the clean, readable structure of kickstart while adding custom plugins, keymaps, and language-specific tooling.

**Key Technologies:** Neovim, Lua, LSP (Language Server Protocol)

## Architecture

The configuration follows a modular structure:

- **`init.lua`**: The base kickstart configuration. This file is the core of Neovim's configuration and should be updated periodically from the kickstart repository.
- **`lua/custom/`**: Custom configuration modules that extend kickstart without modifying the base:
  - `init.lua`: Entry point that loads all custom modules
  - `plugins/init.lua`: Custom plugins and plugin overrides (lazy.nvim format)
  - `keymaps.lua`: Custom key bindings
  - `options.lua`: Vim option overrides
  - `layout.lua`: Auto-layout setup (auto-opens file tree on startup)
- **`lua/kickstart/`**: Kickstart's plugin configurations (do not modify these directly)
- **`.stylua.toml`**: Lua formatting configuration

### Plugin Architecture

Plugins are managed through lazy.nvim and configured in `lua/custom/plugins/init.lua`. Key configurations include:

- **File Management**: nvim-tree for file explorer with auto-open on startup
- **Language Support**: TypeScript tools, Templ (Go template language), Gleam, and extended Go tooling
- **LSP & Formatting**: Language servers via lspconfig, formatting via conform.nvim
- **UI Enhancements**: Telescope (fuzzy finder), trouble.nvim (diagnostics), blink.cmp (completion)
- **Editor Plugins**: nvim-autopairs, gitsigns, indent-blankline

### Language-Specific Setup

**Go/Templ Development:**
- LSPs: gopls and templ
- Formatters: gofumpt, goimports (via conform.nvim)
- Treesitter: go and templ parsers
- Special handling: templ LSP is configured both via opts and manual setup in plugins/init.lua to ensure it works properly

**TypeScript/JavaScript:**
- LSP: typescript-tools.nvim (with separate diagnostics server to prevent blocking)
- Formatters: prettier/prettierd

**Lua:**
- LSP: lua_ls
- Formatter: stylua

**Gleam:**
- LSP: gleam (set up in custom/init.lua)

## Development Commands

### Formatting

Format all Lua files according to `.stylua.toml`:
```bash
stylua .
```

Check formatting without modifying:
```bash
stylua --check .
```

The GitHub workflow in `.github/workflows/stylua.yml` runs stylua checks on pull requests.

### Editing the Configuration

Most customizations should go in `lua/custom/`:
- Add new keymaps to `keymaps.lua`
- Add vim options to `options.lua`
- Add or override plugins in `plugins/init.lua`

### Installing/Updating

Lazy.nvim automatically installs plugins on first run. To update plugins within Neovim:
```
:Lazy update
```

To update the base kickstart configuration from upstream:
1. Get the latest init.lua from https://raw.githubusercontent.com/nvim-lua/kickstart.nvim/master/init.lua
2. Ensure the custom plugin import line is present: `{ import = 'custom.plugins' },`
3. Ensure the custom require is at the end: `require 'custom'`

## Key Mappings

Custom keymaps are defined in `lua/custom/keymaps.lua`:

| Binding | Action |
|---------|--------|
| `<leader>1-5` | Move to window 1-5 |
| `<leader>df` | Show full diagnostic message in floating window |
| `<leader>e` | Toggle nvim-tree file explorer |
| `<leader>fe` | Focus nvim-tree window |
| `<leader>dd` | Display documentation or hover info |
| `<Esc>` | Close floating windows and blink.cmp menu |

Kickstart provides many more keymaps (accessible via `:Telescope keymaps` or `<leader>sk`).

## Indentation Settings

- **Default**: 2 spaces (Lua, Go, TypeScript, etc.)
- **Python**: 4 spaces (set via FileType autocmd in options.lua)

All whitespace is spaces, not tabs. See `.stylua.toml` for Lua formatting details.

## Important Notes

### Templ LSP Configuration

The templ LSP is configured in two places in `lua/custom/plugins/init.lua`:
1. Via a manual setup function (lines 49-83) - this is the primary configuration that works reliably
2. Via opts override (lines 158-187) - provided as a fallback but may be overridden by the framework

Both are needed because the opts-based approach doesn't always work due to how lazy.nvim handles framework overrides.

### Telescope Hidden Files

Telescope is configured to search hidden files by default. File ignore patterns exclude `.git/`, `.cache/`, and `node_modules/` while still searching other hidden directories. This is useful for finding configuration files like `.gitignore`, `.env.example`, etc.

### Completion in Comments

Blink.cmp is configured to disable completions inside comments using treesitter node detection (lua/custom/plugins/init.lua, lines 268-287).

### Nerd Font Requirement

The configuration assumes a Nerd Font is installed (set in `options.lua`). This provides better icons throughout the UI.

## Debugging Configuration Issues

Run `:checkhealth` in Neovim to diagnose configuration problems and verify LSP/tool installations.

## External Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [Kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
