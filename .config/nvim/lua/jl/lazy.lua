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

local my_colorscheme = "kanagawa-wave"

-- Setup lazy.nvim --
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "jl.plugins" },
  },
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { my_colorscheme } },
  -- automatically check for plugin updates
  checker = {
    enabled = true,
    notify = false,
  },
  -- change_detection = {
  --   notify = false,
  -- },
})

vim.cmd.colorscheme(my_colorscheme)

-- It is suggested to version control lazy-lock.json
-- because hosts the versions of every plugin installed
