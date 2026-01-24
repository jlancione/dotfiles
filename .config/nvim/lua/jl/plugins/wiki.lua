return {
  {
    "lervag/wiki.vim",
    init = function()  -- not `config` because it needs to run before loading the plugin
      vim.g.wiki_root = "~/wiki"

      vim.g.wiki_link_creation = {
        -- to get the default: comment this table and :echo vim.g.wiki_link_creation
        md = {
          -- Controls url produced by `gl` and `WikiLinkFollow`
          url_transform = function(x)
            return x.gsub( x, " ", "%%20" ) -- replaces spaces with %20
          end,
          -- Controls url produced by WikiLinkAdd
          path_transform = function(x)
            local filename = vim.fn.fnamemodify(x, ":t")  -- extracts filename from path
            return filename.gsub( filename, " ", "%%20" ) -- replaces spaces with %20
          end,
          url_extension = ".md",
          -- Controls the link text produced by WikiLinkAdd
          link_text = function(x)
            return vim.fn.fnamemodify( x, ":t:r" ) -- extracts filename from path and trims extension
          end,
          link_type = "md"
        },
        _ = {
          url_extension = "",
          link_type = "wiki",
        },
        -- adoc = {
        --     url_extension = "",
        --     link_type = "adoc_xref_bracket"
        -- },
      }

      local telescope = require("wiki.telescope")
      -- Set search UI
      vim.g.wiki_select_method = {
        pages = telescope.pages,  -- for WikiPages
        -- tags  = telescope.tags, -- for WikiTags
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
        keymap("n", "<c-CR>", ":vertical WikiLinkFollowSplit<CR>",  { desc = "Open wiki link in split" })
        keymap("n", "<leader>lk", "<plug>(wiki-link-add)", { desc = "[L]in[K] add" })
        keymap("i", "lk", "<plug>(wiki-link-add)", { desc = "[L]in[K] add" })
        keymap("n", "<leader>ow", "<plug>(wiki-pages)", { desc = "[O]pen [W]iki Page" })
    end
  }
}
