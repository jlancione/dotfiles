return {
  {
    "lervag/wiki.vim",
    init = function()  -- not `config` because it needs to run before loading the plugin
      vim.g.wiki_root = "~/wiki"

      -- Encode/Decode URLs, then use the default resolver
      URLResolver = function(x)
        local url = vim.deepcopy(x)

        -- Decode first, then assign the anchor
        local url_decoded = vim.fn["wiki#url#utils#url_decode"](url.stripped)
        url.anchor = vim.fn["wiki#url#utils#extract_anchor"](url_decoded)

        local path = vim.split(url_decoded, "#", { plain = true })[1]

        url.path = vim.fn["wiki#url#utils#resolve_path"](path, url.origin) -- default resolver

        return url
      end

      vim.g.wiki_link_schemes = {
        md = { resolver = URLResolver },
      }

      vim.g.wiki_link_creation = {
        -- to get the default: comment this table and :echo vim.g.wiki_link_creation
        md = {
          -- Controls url produced by `gl` and `WikiLinkFollow`
          url_transform = vim.fn["wiki#url#utils#url_encode"],
          -- Controls url produced by WikiLinkAdd
          path_transform = function(x)
            local pagename = vim.fn.fnamemodify(x, ":t")  -- extracts filename from path
            return vim.fn["wiki#url#utils#url_encode"](pagename)
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

-- ** Bug Fix, in wiki.vim/autoload/wiki/link.vim
-- Otherwise a dominates and defaults gets overwritten, resulting in g:wiki_link_creation.md.link_text being executed but overwritten
-- it is an ordering issue of extend()
-- " Original
-- "let l:options = extend(l:defaults, a:0 > 0 ? a:1 : {})
-- " Solution
-- let l:options = extend(a:0 > 0 ? a:1 : {}, l:defaults)


-- ** Tweak to the plugin, in wiki.vim/autotload/wiki/pages.vim
-- WikiPageRename reads and writes encoded URLs
-- Otherwise it cannot change incoming links to the renamed page
-- because it is a string substitution, but it does not apply g:wiki_link_creation.md.url_transform
-- function! s:get_replacement_patterns(path_old, path_new) abort " {{{1
--   " Update "absolute" links (i.e. assume link is rooted)
--   let l:root = wiki#get_root()
--   let l:url_old = wiki#paths#to_wiki_url(a:path_old, l:root)
--   let l:url_new = wiki#paths#to_wiki_url(a:path_new, l:root)
--   " MY ADDITION
--   " Apply g:wiki_link_creation.md.url_transform
--   " Then produce a new string with problematic characters escaped
--   let l:url_old = substitute(
--         \ wiki#url#utils#url_encode(l:url_old),
--         \ '%', '\\\%', 'g')
--   let l:url_new = substitute(
--         \ wiki#url#utils#url_encode(l:url_new),
--         \ '%', '\\\%', 'g')
--   " END ADDITION
--   let l:url_pairs = [[l:url_old, l:url_new]]
--
--   " Update "relative" links (look within the specific common subdir)
--   let l:subdirs = []
--   let l:old_subdirs = split(l:url_old, '\/')[:-2]
--   let l:new_subdirs = split(l:url_new, '\/')[:-2]
--   while !empty(l:old_subdirs)
--         \ && !empty(l:new_subdirs)
--         \ && l:old_subdirs[0] ==# l:new_subdirs[0]
--     call add(l:subdirs, remove(l:old_subdirs, 0))
--     call remove(l:new_subdirs, 0)
--   endwhile
--   if !empty(l:subdirs)
--     let l:root .= '/' .. join(l:subdirs, '/')
--     let l:url_pairs += [[
--           \ wiki#paths#to_wiki_url(a:path_old, l:root),
--           \ wiki#paths#to_wiki_url(a:path_new, l:root)
--           \]]
--   endif
