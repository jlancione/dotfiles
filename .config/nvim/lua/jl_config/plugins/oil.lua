return {
  'stevearc/oil.nvim',
  dependencies = { { "nvim-mini/mini.icons", version = '*', opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  lazy = false, -- Lazy loading is not recommended because
  config = function()
    require("oil").setup({
      -- default_file_explorer = true, -- Oil will take over directory buffers, es. nvim .
      columns = { "icon" }, -- "permissions", "size", "mtime"
      delete_to_trash = true,
      -- set keymaps with:
      -- vim.keymap.set("n", "keymap", require("oil").<action>)
      -- va fatto così perché valgono solo ngli oil buffer
      use_default_keymaps = false,
      view_options = { show_hidden = true }
      -- there exists a floating option
    })
  end
}
