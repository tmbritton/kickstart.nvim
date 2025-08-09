-- Custom plugins and plugin overrides
return {
  -- File tree plugin
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('nvim-tree').setup {
        sort_by = 'case_sensitive',
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = false,
        },
      }
    end,
  },

  -- TypeScript tools
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {
      settings = {
        -- Separate the diagnostics server to prevent blocking
        separate_diagnostic_server = true,
        -- Only publish diagnostics when you save or leave insert mode
        publish_diagnostic_on = 'insert_leave',
        -- Increase memory limit if needed
        tsserver_max_memory = '4096',
      },
    },
  },

  -- Override which-key configuration
  {
    'folke/which-key.nvim',
    opts = {
      spec = {
        { '<leader>c', group = '[C]ode' },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },

  -- Override telescope configuration
  {
    'nvim-telescope/telescope.nvim',
    opts = {
      defaults = {
        hidden = true,
        file_ignore_patterns = {
          '^.git/',
          '^.cache/',
          '^node_modules/',
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
        live_grep = {
          additional_args = function()
            return { '--hidden' }
          end,
        },
      },
    },
  },

  -- Add mason-tool-installer override to ensure Go tools are installed
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        'gopls',
        'gofumpt',
        'goimports',
      })
      return opts
    end,
  },

  -- Add LSP servers
  {
    'neovim/nvim-lspconfig',
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers.gopls = {}
      return opts
    end,
  },

  -- Override conform configuration for Go formatting
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
        typescript = { 'prettier', 'prettierd', stop_after_first = true },
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        go = { 'gofumpt', 'goimports' },
      },
    },
  },

  -- Override treesitter to include gleam
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'gleam' },
    },
  },

  -- Autocomplete braces
  { 'windwp/nvim-autopairs', event = 'InsertEnter', opts = {} },

  -- Git blame
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      current_line_blame = true,
      current_line_blame_opts = { delay = 300 },
    },
  },
  -- Indent Guides
  { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = {} },
  -- Better Diagnostics
  {
    'folke/trouble.nvim',
    opts = {},
    cmd = 'Trouble',
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (Trouble)' },
      { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer Diagnostics (Trouble)' },
    },
  },
  {
    'saghen/blink.cmp',
    opts = function(_, opts)
      opts.keymap.preset = 'super-tab'
      -- Optional: Show documentation automatically after a short delay
      opts.completion.documentation.auto_show = true
      opts.completion.documentation.auto_show_delay_ms = 300

      -- Optional: Enable ghost text (shows completion inline as you type)
      opts.completion.ghost_text = { enabled = true }

      -- Disable completion in comments
      opts.completion.trigger = {
        blocked_trigger_characters = {},
        show_in_snippet = true,
        show_on_keyword = true,
        show_on_trigger_character = true,
        show_on_accept_on_trigger_character = true,
        show_on_insert_on_trigger_character = true,
        -- This is the key setting - disable in comments
        show_in_context = function(ctx)
          -- Get the current treesitter node
          local node = vim.treesitter.get_node()
          if not node then
            return true
          end

          -- Check if we're in a comment
          local node_type = node:type()
          return not (node_type:match 'comment' or node_type:match 'Comment')
        end,
      }
      return opts
    end,
  },
}
