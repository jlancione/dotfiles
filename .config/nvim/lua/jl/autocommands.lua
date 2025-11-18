local group_wiki = vim.api.nvim_create_augroup("group_wiki", { clear = true })

-- Autocommands --
-- They run each time a condition is met. See :help lua-guide-autocommands
vim.api.nvim_create_autocmd("User", {
  pattern = "WikiBufferInitialized",
  callback = function()
    vim.api.nvim_set_current_dir(vim.fn.expand("%:p:h"))    
    -- % Current file name, :p expand to full path, :h last path component removed (head)
  end,
})
