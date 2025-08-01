-- Load custom configurations
require 'custom.layout'
require 'custom.keymaps'
require 'custom.options'

-- Setup additional LSP servers
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function()
    require('lspconfig').gleam.setup {}
  end,
  once = true,
})
