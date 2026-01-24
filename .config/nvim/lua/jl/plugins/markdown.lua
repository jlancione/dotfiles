-- https://github.com/MeanderingProgrammer/render-markdown.nvim/wiki
return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" },
    ft = "markdown",
    opts = {
      enabled = true,
      render_modes = true,
      -- render_modes = { "i", "n", "c", "v", "V", "\22", "no", "R", }, -- \22 stands for Ctrl-v, see help mode()
      file_types = { "markdown" },
      -- latex = {
      --      enabled = true,
      --      converter = "latex2text",
      --  },
      heading = { position = "inline", backgrounds = {},
        icons = { "󰫈 ", "󰫇 ", "󰫆 ", "󰫅 ", "󰫄 ", "󰫃 " },
      },
      bullet = { enabled = false },
      checkbox = {
          checked = { icon = " " },
          custom = { todo = { raw = "[-]", rendered = " " } }, -- , highlight = "RenderMarkdownTodo", scope_highlight = nil }
      },
      link = {
        hyperlink = "󰌷 ",
        footnote = { icon = "", }, },
    }
  }
}
