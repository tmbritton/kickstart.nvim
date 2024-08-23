local M = {}

function M.setup_custom_layout()
  -- Open file explorer (assuming you're using nvim-tree)
  vim.cmd 'NvimTreeOpen'
  vim.cmd 'wincmd l' -- Move focus to the main window

  -- Open two terminal windows at the bottom
  vim.cmd 'botright split | terminal'
  vim.cmd 'resize 15' -- Adjust the size as needed
  vim.cmd 'vsplit | terminal'

  -- Move focus back to the main window
  vim.cmd 'wincmd k'
  -- Split into 2nd editing tab
  vim.cmd 'vsplit'

  -- Move focus back to main window
  vim.cmd 'wincmd h'
end

-- Create a command to manually trigger the layout
vim.api.nvim_create_user_command('SetupCustomLayout', M.setup_custom_layout, {})

-- Autocommand to set up the layout on startup
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    if vim.bo.buftype == '' then
      M.setup_custom_layout()
    end
  end,
})

return
