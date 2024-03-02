-- BOOTSTRAP LAZY
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { import = "user.plugins" },    -- main plugins directory
  { import = "user.plugins.lsp" }, -- lsp plugins directory
  -- General purpose plugins
  { "nvim-lua/popup.nvim" }, -- An implementation of the Popup API from vim in Neovim
  { "nvim-lua/plenary.nvim" }, -- Useful lua functions used ny lots of plugins
},
  {
  install = {
    colorscheme = { "onedark" },
  },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})

-- TODOs 
-- sarebbe carino usare 1 pcall 
-- ed era comodo l'autocommand che ricaricava nvim ogni volta che scrivevo su plugins.lua (ma avendo tutto spezzettato nn so se sia possibile…
-- e poi si può chiaramente dare 1 occhiata alla documentazione di lazy.nvim
-- Use a protected call so we don't error out on first use
-- local status_ok, packer = pcall(require, "packer")
-- if not status_ok then
--	return
-- end
