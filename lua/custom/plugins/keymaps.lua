for i = 1, 5 do
  vim.keymap.set('n', '<leader>' .. i, i .. '<C-w>w', { noremap = true, silent = true, desc = 'Move to window ' .. i })
end
