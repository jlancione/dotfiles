return { 
  {
    "saghen/blink.cmp",
    -- dependencies = { "rafamadriz/friendly-snippets" },
    version = "1.*",  -- to download pre-built binaries
    opts = {
      keymap = { preset = "default" },

      appearance = {
        nerd_font_variant = "mono"
      },

      completion = {
        documentation = { auto_show = true },
        menu = {
          -- manually trigger completion on some filetypes, with C-space
          auto_show = function()
            return not vim.tbl_contains({ "markdown", "tex" }, vim.bo.filetype)
          end
        },
      },

      sources = {
        default = { "path" }, -- "lsp", "snippets", "buffer" },
      },

      fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
  }
}
