-- Custom keymaps

-- Pane navigation
for i = 1, 5 do
  vim.keymap.set('n', '<leader>' .. i, i .. '<C-w>w', { noremap = true, silent = true, desc = 'Move to window ' .. i })
end

-- Show full diagnostic message in floating window
vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float, { desc = 'Show diagnostic error message' })

-- Keymaps for nvim-tree plugin
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { silent = true, noremap = true })
vim.keymap.set('n', '<leader>fe', ':NvimTreeFocus<CR>', { silent = true, noremap = true })
