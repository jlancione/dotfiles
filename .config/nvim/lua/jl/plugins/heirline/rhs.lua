local conditions = require("heirline.conditions")
-- local utils = require("heirline.utils")
-- local Space = { flexible = 1, { provider = " " }, { provider = "" } }

-- StatusLine RIGHT HAND SIDE --

-- Cursor position
local Ruler = {
  -- %l = current line number
  -- %L = number of lines in the buffer
  -- %c = column number
  -- %P = percentage through file of displayed window
  -- %p = percentage through file of line cursor is on
  flexible = 3,
  {
    provider = "%3l:%2c %3p%%",
  },
  {
    provider = "%3p%%",
  }
}

-- Lazy Pending Updates
local lazy_status = require("lazy.status")
local LazyStatus = {
  condition = lazy_status.has_updates,
  provider = lazy_status.updates,
  hl = { fg = "blue" },
}

-- Git repo
local Git = {
  condition = function()
    vim.fn.system("git rev-parse --is-inside-work-tree")
    -- catch the exit code of previous command
    if vim.v.shell_error == 0 then
      return true
    else
      return false
    end
  end,

  provider = function()
    local branch_name = vim.fn.system("git branch --show-current")
    branch_name = string.gsub(branch_name, "\n$", "") -- discard trailing \n

    return branch_name .. " "
  end,
  hl = { fg = "purple" },
}

-- LSP
-- local LSPActive = {
--     condition = conditions.lsp_attached,
--     update = {"LspAttach", "LspDetach"},
--
--     -- You can keep it simple,
--     provider = " [LSP]",
--     hl = { fg = "green", bold = true },
-- }

-- Set custom icons
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = " ",
    },
  },
 })

local LSPDiagnostics = {
  condition = conditions.has_diagnostics,

  init = function(self)
    --  Fetch custom signs
    self.error_icon = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.ERROR]
    self.warn_icon = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.WARN]
    self.info_icon = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.INFO]
    self.hint_icon = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.HINT]
    -- Get diagnostics
    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  end,

  update = { "DiagnosticChanged", "BufEnter" },

    -- {
    --     provider = "![",
    -- },
    {
        provider = function(self)
            -- 0 is just another output, we can decide to print it or not!
            return self.errors > 0 and (" " .. self.errors .. " " .. self.error_icon)
        end,
        hl = { fg = "diag_error" },
    },
    {
        provider = function(self)
            return self.warnings > 0 and (" " .. self.warnings .. " " .. self.warn_icon)
        end,
        hl = { fg = "diag_warn" },
    },
    {
        provider = function(self)
            return self.info > 0 and (" " .. self.info .. " " .. self.info_icon)
        end,
        hl = { fg = "diag_info" },
    },
    {
        provider = function(self)
            return self.hints > 0 and (" " .. self.hints .. " " .. self.hint_icon)
        end,
        hl = { fg = "diag_hint" },
    },
    -- {
    --     provider = "]",
    -- },
}


local RhsBlock = {
  lsp_diagnostics = LSPDiagnostics,
  -- LSPActive,
  lazy = LazyStatus,
  ruler = Ruler,
  git = Git,
}

return { rhs = RhsBlock }
