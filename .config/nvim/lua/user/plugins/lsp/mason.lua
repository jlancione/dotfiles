return {
    "williamboman/mason.nvim",
  dependencies = {
    { "neovim/nvim-lspconfig" },
    { "williamboman/mason-lspconfig.nvim" },
--    { "antosha417/nvim-lsp-file-operations", config = true }, -- magari è utile
 },
    config = function()
      local servers = {
        "lua_ls",
        -- "cssls",
        -- "html",
        -- "tsserver",
        "pyright",
        -- "bashls",
        "jsonls",
        -- "yamlls",
        "texlab",
      }

      vim.lsp.set_log_level("debug")

      local settings = {
        ui = {
          border = "none",
          icons = {
            package_installed = "◍",
            package_pending = "◍",
            package_uninstalled = "◍",
          },
        },
        log_level = vim.log.levels.INFO,
        max_concurrent_installers = 4,
      }

      require("mason").setup(settings)
      require("mason-lspconfig").setup({
        ensure_installed = servers,
        automatic_installation = true,
      })

      local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
      if not lspconfig_status_ok then print("lspconfig not found")
        return
      end

      local opts = {}

      for _, server in pairs(servers) do
        opts = {
          on_attach = require("user.plugins.lsp.settings.handlers").on_attach,
          capabilities = require("user.plugins.lsp.settings.handlers").capabilities,
        }

        server = vim.split(server, "@")[1]

        -- qsto qua nn stiamo riuscendo a caricarlo…
       local require_ok, conf_opts = pcall(require, "user.plugins.lsp.settings." .. server)
--     if not require_ok then print(server .. " server settings not found")
--     end
       if require_ok then
         opts = vim.tbl_deep_extend("force", conf_opts, opts)
       end

        lspconfig[server].setup(opts)
      end

    require("user.plugins.lsp.settings.handlers").setup() -- this could maybe go into an hypothepical init.lua for lsp
    end,
    }
