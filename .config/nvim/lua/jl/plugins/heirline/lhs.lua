local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local Space = { flexible = 1, { provider = " " }, { provider = "" } }

-- StatusLine LEFT HAND SIDE --

-- Child objects definitions
local FileIcon = {
  init = function(self)
    local filename = self.filename
    local extension = vim.fn.fnamemodify(filename, ":e")
    -- self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })     
    local icon, mini_icon_color = require("mini.icons").get("extension", extension)
    self.icon = icon
    -- eg. mini_icon_color = "MiniIconYellow", we want "yellow"
    self.icon_color = string.lower(string.sub(mini_icon_color,10)) 

  end,
  provider = function(self)
    return self.icon and (self.icon .. " ")
  end,
  hl = function(self)
    return { fg = self.icon_color }
  end
}

local FileName = {
  init = function(self)
    -- Trim the pattern relative to the current directory.
    -- For other options, see :h filename-modifers
    self.lfilename = vim.fn.fnamemodify(self.filename, ":.")
    if self.lfilename == "" then return "[No Name]" end
  end,
  hl = function()
    if conditions.is_not_active() then
      return { fg = "purple" }
    else
      return { fg = "yellow" }
    end
  end,

  flexible = 5, -- it is the priority, higher: last to contract, first to expand
  {
    provider = function(self)
      return self.lfilename
    end,
  },
  {
    provider = function(self)
      return vim.fn.pathshorten(self.lfilename)
    end,
  },
}

-- Group the filename-related objects in a single component
local FileNameBlock = {
  init = function(self)
      self.filename = vim.api.nvim_buf_get_name(0)
  end,
  FileIcon,
  Space,
  FileName,
  { provider = "%<" }, -- this means that the statusline is cut here when there's not enough space
}


local FileFlags = {
  {
    condition = function()
      return vim.bo.modified
    end,
    provider = "[+]",
    hl = { fg = "orange" },
  },
  {
    condition = function()
      return ( not vim.bo.modifiable or vim.bo.readonly ) and vim.bo.buftype ~= "terminal"
    end,
    provider = "",
    hl = { fg = "orange" },
  },
}

local TerminalSign = {
  {
    condition = function()
      return vim.bo.buftype == "terminal"
    end,
    provider = " ",
    hl = { fg = "orange" },
  },
  { 
    condition = function()
      return vim.bo.buftype == "terminal"
    end,
    provider = " "
  },
}

local HelpFileName = {
  condition = function()
    return vim.bo.filetype == "help"
  end,
  provider = function()
    local filename = vim.api.nvim_buf_get_name(0)
    return vim.fn.fnamemodify(filename, ":t")
  end,
  hl = { fg = "yellow" },
}

local FileType = {
  provider = function()
    if vim.bo.filetype ~= "" then
      return string.upper(vim.bo.filetype)
    else 
      return string.upper(vim.bo.buftype)
    end
  end,
  hl = { fg = "blue", bold = true },
}

local OilCurrentDir = {
  condition = function()
    return vim.bo.filetype == "oil"
  end,
  provider = function()
    return require("oil").get_current_dir()
  end,
  hl = { fg = "yellow" },
}

-- The following relies on gitsigns
-- local Git = {
--   condition = conditions.is_git_repo,
--
--   init = function(self)
--     self.status_dict = vim.b.gitsigns_status_dict
--     self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
--   end,
--   hl = { fg = "blue" },
--
--   {   -- git branch name
--     provider = function(self)
--       return " " .. self.status_dict.head
--     end,
--     hl = { bold = true }
--   },
-- }

local lhs = {
  file_name = FileNameBlock,
  file_flags = FileFlags,
  file_type = FileType,
  help_file_name = HelpFileName,
  oil_current_dir = OilCurrentDir,
  terminal_sign = TerminalSign,
}


return { lhs = lhs }
