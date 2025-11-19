return {
  {
    "lervag/wiki.vim",
    init = function()  -- not `config` because it needs to run before loading the plugin

      vim.g.wiki_root = "~/wiki"

      local telescope = require("wiki.telescope")
      -- Set search UI
      vim.g.wiki_select_method = {
        pages = telescope.pages,  -- for WikiPages
        -- tags  = telescope.tags,
        toc   = telescope.toc,    -- for WikiToc
        links = telescope.links,  -- for WikiLinkAdd
      }

      local keymap = vim.keymap.set
      -- keymaps
      keymap("n", "<leader>la", ":WikiLinkAdd<CR>", { desc = "[L]ink [A]dd" }) 
      -- keymap("n", "<leader>wp", ":WikiPages<CR>", { desc = "Search [W]iki [P]ages" }) 

    end
  }
}
