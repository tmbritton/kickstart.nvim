local M = {}

function M.setup_custom_layout()
  -- Delay the execution of NvimTreeOpen
  vim.defer_fn(function()
    vim.cmd('NvimTreeOpen')
  end, 100)  -- 100ms delay, adjust if needed
end

-- Create a command to manually trigger the layout
vim.api.nvim_create_user_command('SetupCustomLayout', M.setup_custom_layout, {})

-- Autocommand to set up the layout on startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.bo.buftype == '' then
      M.setup_custom_layout()
    end
  end,
  nested = true,  -- Allow nested autocommands
})

return M
