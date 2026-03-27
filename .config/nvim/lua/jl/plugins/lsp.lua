return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "folke/lazydev.nvim", -- to manage vim global
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
    config = function()

      vim.lsp.enable("lua_ls")
      vim.lsp.enable("texlab")
      vim.lsp.enable("clangd")
      vim.lsp.enable("basedpyright")
      -- vim.lsp.set_log_level("debug")
      vim.diagnostic.config({ virtual_text = true })

    end,
  }
}
