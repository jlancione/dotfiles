return {
  {
    "lervag/wiki.vim",
    init = function()  -- not `config` because it needs to run before loading the plugin

      vim.g.wiki_root = "~/wiki"

      vim.g.wiki_link_creation = {  -- to get the default: comment this table and :echo vim.g.wiki_link_creation
        md = {
          url_transform = function(x)
            return x.gsub( x, " ", "%%20" ) -- replaces spaces with %20
          end,
          path_transform = function(x)
            local filename = vim.fn.fnamemodify(x, ":t")  -- extracts filename from path
            return filename.gsub( filename, " ", "%%20" ) -- replaces spaces with %20
          end,
          url_extension = ".md",
          link_text = function(x)
            return vim.fn.fnamemodify(x, ":t:r") -- extracts filename from path and trims extension
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
      -- this needs to be done after the plugin has been loaded, not checked, chat
      -- local link_add = vim.fn["wiki#link#add"]
      -- telescope.links = function(opts)
        -- local original_on_select = opts.on_select
        -- opts.on_select = function(item)
        --
        --   print(vim.inspect(item))
        --
        --   local target = item.path or itme.filename or item.value
        --
        --   link_add(target)
        --   if original_on_select then
        --     original_on_select(item)
        --   end
        -- end
        -- return telescope.links(opts)
      -- end

      -- Set search UI
      vim.g.wiki_select_method = {
        pages = telescope.pages,  -- for WikiPages
        -- tags  = telescope.tags,
        toc   = telescope.toc,    -- for WikiToc
        -- links = telescope.links,  -- for WikiLinkAdd, this does not follow the rules in wiki_link_creation.md.link_text
        links = require("wiki.ui_select").links,
      }

      vim.g.wiki_viewer = {
        md = ":edit", wiki = ":edit",  -- defaults
        tex = ":edit",
        _ = "open"  -- fallback
      }


      local keymap = vim.keymap.set
        -- keymaps
        keymap("n", "<c-CR>", ":vertical WikiLinkFollowSplit<CR>",  { desc = "Open link in split" })
        keymap("n", "<leader>lk", ":WikiLinkAdd<CR>", { desc = "[L]in[K] add" })
        keymap("i", "lk", "<plug>(wiki-link-add)", { desc = "[L]in[K] add" })
        keymap("n", "<leader>ow", ":WikiPages<CR>", { desc = "[O]pen [W]iki Page" })
    end
  }
}
