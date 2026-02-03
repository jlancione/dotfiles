return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.enable("texlab")
      vim.lsp.enable("clangd")
      -- vim.lsp.set_log_level("debug")
      vim.diagnostic.config({ virtual_text = true })
    end,
  }
}
