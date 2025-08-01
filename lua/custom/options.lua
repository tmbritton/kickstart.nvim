-- Custom vim options

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

-- Tabstop configs
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Override for Python files, just in case
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function()
    vim.opt.tabstop = 4
    vim.opt.shiftwidth = 4
  end,
})
