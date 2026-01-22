-- Autocommands --
-- They run each time a condition is met. See :help lua-guide-autocommands

vim.api.nvim_create_autocmd("User", {
  pattern = "WikiBufferInitialized",  -- wiki.vim User event
  callback = function()
    vim.api.nvim_set_current_dir(vim.fn.expand("%:p:h"))    
    -- % Current file name, :p expand to full path, :h last path component removed (head)
  end,
})

-- Start treesitter highlight, to render markdown link appropriately
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  callback = function() vim.treesitter.start() end,
})
