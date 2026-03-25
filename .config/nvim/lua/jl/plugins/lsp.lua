return {
  {
    "neovim/nvim-lspconfig",
    config = function()

      vim.lsp.enable("lua_ls")
      vim.lsp.enable("texlab")
      vim.lsp.enable("clangd")
      vim.lsp.enable("basedpyright")
      -- vim.lsp.set_log_level("debug")
      vim.diagnostic.config({ virtual_text = true })

      -- Custom configurations
      vim.lsp.config("lua_ls", {  -- prevent warning Undefined global `vim`
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } }
          }}
      })
    end,
  }
}
