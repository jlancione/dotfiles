local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local Space = { flexible = 1, { provider = " " }, { provider = "" } }
local Align = { flexible = 10, { provider = "%=" }, { provider = "" } }

local LeftHandSide = require("jl.plugins.heirline.lhs").lhs
local RightHandSide = require("jl.plugins.heirline.rhs").rhs

local DefaultStatusLine = {
  {
    hl = {
      bg = "orange",
    },
  },
  LeftHandSide.filename,
  Space,
  LeftHandSide.fileflags,
  Align,
  RightHandSide.lazy,
  Space,
  RightHandSide.ruler,
}

local InactiveStatusLine = {
  condition = conditions.is_not_active,
  hl = { fg = "gray" },
  LeftHandSide.filename,
  { provider = "%<" },
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
  InactiveStatusLine,
  DefaultStatusLine,
}


return { statusline = StatusLines }
