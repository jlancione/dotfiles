return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",  -- to automatically update the parsers to the version of TS
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "cpp", "lua", "python", "markdown" },
        -- bash, cmake, csv, fish, gitignore, gnuplot, markdown-inline, json, latex, make, tcl, typst, vim
        -- ignore_installed = {}, -- DEBUG

        -- Modules --
        highlight = {
          enabled = true,
          -- disable = {} -- DEBUG
        },
        indent = {        -- for = operator
          enable = true,
          -- disable = {}, -- DEBUG
        },
      })
    end
  }
}
