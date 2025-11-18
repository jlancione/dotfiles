return {
  {
    'stevearc/oil.nvim',
    dependencies = { { "nvim-mini/mini.icons", version = '*', opts = {}, } },
    lazy = false, -- Lazy loading is not recommended
    config = function()
      require("oil").setup({
        -- default_file_explorer = false,
        columns = { "icon" }, -- "permissions", "size", "mtime"
        delete_to_trash = true,
        view_options = { show_hidden = true },

        -- keymaps
        use_default_keymaps = false,
        keymaps = {
          ["<CR>"] = { "actions.select", desc = "Open the entry under the cursor" },
          ["<BS>"] = { "actions.parent", desc = "Go up a directory" },
          ["<esc>"] = { "actions.close", mode = "n" },
        },
      })

      vim.keymap.set("n", "<leader>e", "<cmd>Oil<CR>" )

    end,
  },
}
