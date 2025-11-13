-- Bootstrap lazy.nvim --
-- It downloads repos (plugins) and adds them to the runtimepath 
-- Updates and handles plugins' dependencies
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- Clone the repo if nonexistent
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  -- Runs a system command catching the result
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

-- Put Lazy into the runtimepath for neovim
vim.opt.runtimepath:prepend(lazypath)


-- Setup lazy.nvim --
require("lazy").setup({
  spec = {
    -- import your plugins
    -- { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = {
    enabled = true,
    notify = false,
  },
  -- change_detection = {
  --   notify = false,
  -- },
})


-- It is suggested to version control lazy-lock.json
-- It hosts the versions of every plugin installed
