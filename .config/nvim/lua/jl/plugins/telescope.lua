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
    -- "nvim-telescope/telescope-bibtex.nvim",
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

        -- extension = {
        --   extension options go here
        -- },

      })

      telescope.load_extension( "fzf" )

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
