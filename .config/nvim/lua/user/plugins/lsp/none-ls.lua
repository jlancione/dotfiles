return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  config = function ()
    local null_ls = require("null-ls")
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics

    null_ls.setup({
        debug = false,
        sources = {
          formatting.black,
          formatting.stylua,
          formatting.prettier,
          formatting.clang_format,
          diagnostics.pylint,
--          null_ls.builtins.completion.spell,
--          require("none-ls.diagnostics.eslint"), -- requires none-ls-extras.nvim
        },
    })
  end
}
