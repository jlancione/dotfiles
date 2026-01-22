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
      vim.g.wiki_viewer = {
        md = ":edit", wiki = ":edit",  -- defaults
        tex = ":edit",
        _ = "open"  -- fallback
      }

      local keymap = vim.keymap.set
      -- keymaps
      keymap("n", "<c-CR>", ":vertical WikiLinkFollowSplit<CR>",  { desc = "Open link in split" })
      keymap("n", "<leader>la", ":WikiLinkAdd<CR>", { desc = "[L]ink [A]dd" }) 
      keymap("n", "<leader>ow", ":WikiPages<CR>", { desc = "[O]pen [W]iki Page" }) 

    end
  }
}
