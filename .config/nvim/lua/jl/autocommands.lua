-- See :help lua-guide-autocommands

-- Start treesitter highlight, e.g. to render markdown link appropriately
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "latex", },
  callback = function() vim.treesitter.start() end,
})

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "python" },
--   callback = function ()
--     vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
--   end,
-- })

-- One autocommand is defined in heirline, look in heirline/rhs.lua
