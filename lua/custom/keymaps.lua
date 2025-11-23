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

-- Show documentation in floating window
vim.keymap.set('n', '<leader>dd', vim.lsp.buf.hover, { desc = '[D]isplay [D]ocumentation' })

-- Close floating windows with esc key
vim.keymap.set('n', '<Esc>', function()
  -- First try to close blink.cmp documentation
  if require('blink.cmp').is_visible() then
    require('blink.cmp').hide()
    return
  end

  -- Then try to close any floating windows
  for _, win in pairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative ~= '' then
      vim.api.nvim_win_close(win, false)
      return
    end
  end

  -- Default escape behavior
  vim.cmd 'nohlsearch'
end, { desc = 'Close floats or clear search' })
