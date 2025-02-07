return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()

    local branch = {'branch', icon = {''}}
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count

    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = ' ', right = ''}, --   
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = false,
        refresh = {
          statusline = 100,
          tabline = 100,
          winbar = 100,
        }
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = { branch, 'diff'},
        lualine_c = {'filename', 'diagnostics'},
        lualine_x = {'filetype'}, -- 'encoding', 'fileformat', 
        lualine_y = {'location', 'progress'},
        lualine_z = {
          {'datetime', style = '%H:%M'}
        }
      },
      inactive_sections = {
        lualine_a = {'filename'},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {
        lualine_a = {}, -- to remove filename from top of the screen
        lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
--				color = { fg = "#ff9e64" },
					},
        }
      },
      winbar = {},
      inactive_winbar = {},
      extensions = {}
  }
  end
}
