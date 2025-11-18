local group_cdpwd = vim.api.nvim_create_augroup("group_cdpwd", { clear = true })

-- Autocommands --
-- They run each time a condition is met. See :help lua-guide-autocommands
vim.api.nvim_create_autocmd("VimEnter", {
  group = group_cdpwd,
  pattern = "*",
  callback = function()
    vim.api.nvim_set_current_dir(vim.fn.expand("%:p:h"))    
    -- % Current file name, :p expand to full path, :h last path component removed (head)
  end,
})
