local surround_status_ok, _ = pcall(require, "nvim-surround")
if not surround_status_ok then print("cannot find nvim-surround (plugin)...")
  return
end 

require("nvim-surround").buffer_setup({
  surrounds = {
    -- ["e"] = {
    --   add = function()
    --     local env = require("nvim-surround.config").get_input ("Environment: ")
    --     return { { "\\begin{" .. env .. "}" }, { "\\end{" .. env .. "}" } }
    --   end,
    -- },
    ["b"] = {
      add = { "**", "**" },
      find = "**.-**",
      delete = "^(**)().-(**)()$",
    },
    ["i"] = {
      add = { "_", "_" },
      find = "_.-_",
      delete = "^(_)().-(_)()$",
    },
  },
})

-- prevents markdown from changing tabs to 4 spaces
-- vim.g.markdown_recommended_style = 0
