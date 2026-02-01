return {
  {
    "rebelot/heirline.nvim",
    dependencies = {
      { "nvim-mini/mini.icons", opts = {} },
      -- { "nvim-tree/nvim-web-devicons", opts = {} },
    },
    config = function()

      local conditions = require("heirline.conditions")
      local utils = require("heirline.utils")

      local function setup_colors()
        return {
          bright_bg = utils.get_highlight("Folded").bg,
          bright_fg = utils.get_highlight("Folded").fg,
          red = utils.get_highlight("DiagnosticError").fg,
          dark_red = utils.get_highlight("DiffDelete").bg,
          azure = utils.get_highlight("Special").fg,
          cyan = utils.get_highlight("Special").fg,
          blue = utils.get_highlight("Function").fg,
          grey = utils.get_highlight("NonText").fg,
          green = utils.get_highlight("String").fg,
          orange = utils.get_highlight("Constant").fg,
          purple = utils.get_highlight("Statement").fg,
          yellow = utils.get_highlight("Identifier").fg,
          diag_warn = utils.get_highlight("DiagnosticWarn").fg,
          diag_error = utils.get_highlight("DiagnosticError").fg,
          diag_hint = utils.get_highlight("DiagnosticHint").fg,
          diag_info = utils.get_highlight("DiagnosticInfo").fg,
          -- git_del = utils.get_highlight("diffDeleted").fg,
          -- git_add = utils.get_highlight("diffAdded").fg,
          -- git_change = utils.get_highlight("diffChanged").fg,
        }
      end

      -- To evaluate setup_colors at each change of colorscheme
      vim.api.nvim_create_augroup("Heirline", { clear = true })
      vim.cmd([[au Heirline FileType * if index(["wipe", "delete"], &bufhidden) >= 0 | set nobuflisted | endif]])
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          utils.on_colorscheme(setup_colors)
        end,
        group = "Heirline",
      })

      require("heirline").setup({
        statusline = require("jl.plugins.heirline.statusline").statusline,
        opts = {
          colors = setup_colors,
        },
      })
    end
  }
}
