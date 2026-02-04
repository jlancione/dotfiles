return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "BurntSushi/ripgrep",
      { "nvim-mini/mini.icons", opts = {} },
      -- { "nvim-tree/nvim-web-devicons" }, 

      -- extensions
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make", },
      "nvim-telescope/telescope-bibtex.nvim",
      -- "debugloop/telescope-undo.nvim",
    },

    config = function()
      local telescope = require("telescope")
      local builtin   = require("telescope.builtin")

      telescope.setup({
        defaults = {
          path_dispaly = { "smart" },
          prompt_prefix = " ",
          selection_caret = " ",
          -- mappings = {
          --   i = { -- insert mode
          --   },
          --   n = { -- normal mode
          --   },
          -- },
        },
        -- Configuration for built-in pickers
        pickers = {
          live_grep = {
           theme = "ivy",
          },
        },

        extensions = {
          bibtex = {
            -- Depth for the *.bib file
            depth = 1,
            -- Path to global bibliographies (placed outside of the project)
            global_files = { "/Users/jacopolancione/Library/texmf/bibtex/bib/Zotero.bib" },
            -- Define the search keys to use in the picker
            search_keys = { "author", "year", "title" },
            -- Template for the formatted citation
            citation_format = "{{author}} ({{year}}), {{title}}.",
            -- Only use initials for the authors first name
            citation_trim_firstname = true,
            -- Max number of authors to write in the formatted citation
            -- following authors will be replaced by "et al."
            citation_max_auth = 2,
            -- Custom format for citation label
            custom_formats = {
              { id = "citet", cite_maker = "\\citet{%s}" }
            },
            -- Format to use for citation label.
            -- Try to match the filetype by default, or use "plain"
            format = "citet",
            -- Context awareness disabled by default
            context = true,
            -- Fallback to global/directory .bib files if context not found
            -- This setting has no effect if context = false
            context_fallback = true,
            -- Wrapping in the preview window is disabled by default
            wrap = false,
          },
        },
      })

      telescope.load_extension( "fzf" )
      telescope.load_extension( "bibtex" )

      -- keymaps
      local keymap = vim.keymap.set
      keymap("n", "<leader>F", builtin.live_grep,   { desc = "[F]ind Text"  })
      keymap("n", "<leader>b", builtin.buffers,     { desc = "[B]uffers"    })
      keymap("n", "<leader>f", builtin.find_files,  { desc = "Find [F]iles" })

      keymap("n", "<leader>th", builtin.help_tags,  { desc = "Find [H]elp"  })
      keymap("n", "<leader>tM", builtin.man_pages,  { desc = "[M]an Pages"  })
      keymap("n", "<leader>tk", builtin.keymaps,    { desc = "[K]eymaps"    })
      keymap("n", "<leader>tC", builtin.commands,   { desc = "[C]ommands"   })

    end
  }
}
