local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local Space = { provider = " " }
local Align = { provider = "%=" }

local LeftHandSide = require("jl.plugins.heirline.lhs").lhs
local RightHandSide = require("jl.plugins.heirline.rhs").rhs

local DefaultStatusLine = {
  {
    hl = {
      bg = "orange",
    },
  },
  LeftHandSide,
  Align,
  RightHandSide,
}

-- local InactiveStatusline = {
--     condition = conditions.is_not_active,
--     { hl = { fg = "gray", force = true } },
--     FileNameBlock,
--     { provider = "%<" },
--     Align,
-- }


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
  DefaultStatusLine
}


return { statusline = DefaultStatusLine }
