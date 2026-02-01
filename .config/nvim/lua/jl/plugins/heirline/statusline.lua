local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local Space = { flexible = 1, { provider = " " }, { provider = "" } }
local Align = { flexible = 10, { provider = "%=" }, { provider = "" } }

local LeftHandSide = require("jl.plugins.heirline.lhs").lhs
local RightHandSide = require("jl.plugins.heirline.rhs").rhs

local DefaultStatusLine = {
  {
    hl = {
      bg = "orange", -- I don't see its effect
    },
  },

  LeftHandSide.file_name,
  Space,
  LeftHandSide.file_flags,
  Align,
  RightHandSide.lazy,
  Space,
  RightHandSide.ruler,
}

local InactiveStatusLine = {
  condition = conditions.is_not_active,
  hl = { fg = "gray" },
  LeftHandSide.file_name,
  { provider = "%<" },
  Align,
}

local SpecialStatusLine = {
  condition = function()
    return conditions.buffer_matches({
      -- inspect with :set filetype?
      buftype = { "nofile", "prompt", "help", "quickfix", "terminal" },
      filetype = { "oil", },
    })
  end,

  LeftHandSide.terminal_sign,
  LeftHandSide.file_type,
  Space,
  -- help and oil are mutually exclusive (filetypes)
  LeftHandSide.help_file_name,
  LeftHandSide.oil_current_dir,
  Space,
  LeftHandSide.file_flags,
  Align,
}

local StatusLines = {
   hl = function()
    if conditions.is_active() then
      return "StatusLine"
    else
      return "StatusLineNC"
    end
  end,
  fallthrough = false,
  SpecialStatusLine,
  InactiveStatusLine,
  DefaultStatusLine,
}


return { statusline = StatusLines }
