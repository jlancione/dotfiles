local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local Space = { flexible = 1, { provider = " " }, { provider = "" } }

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

local lazy_status = require("lazy.status")
local LazyStatus = {
  condition = lazy_status.has_updates,
  provider = lazy_status.updates,
  hl = { fg = "blue" },
}


-- local LSPActive = {
--     condition = conditions.lsp_attached,
--     update = {"LspAttach", "LspDetach"},
--
--     -- You can keep it simple,
--     provider = " [LSP]",
--     hl = { fg = "green", bold = true },
-- }



-- local Diagnostics = {
--
--     error_icon = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.ERROR],
--     warn_icon = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.WARN],
--     info_icon = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.INFO],
--     hint_icon = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.HINT],
--
--     init = function(self)
--         self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
--         self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
--         self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
--         self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
--     end,
--
--     update = { "DiagnosticChanged", "BufEnter" },
--
--     {
--         provider = "![",
--     },
--     {
--         provider = function(self)
--             -- 0 is just another output, we can decide to print it or not!
--             return self.errors > 0 and (self.error_icon .. self.errors .. " ")
--         end,
--         hl = { fg = "diag_error" },
--     },
--     {
--         provider = function(self)
--             return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
--         end,
--         hl = { fg = "diag_warn" },
--     },
--     {
--         provider = function(self)
--             return self.info > 0 and (self.info_icon .. self.info .. " ")
--         end,
--         hl = { fg = "diag_info" },
--     },
--     {
--         provider = function(self)
--             return self.hints > 0 and (self.hint_icon .. self.hints)
--         end,
--         hl = { fg = "diag_hint" },
--     },
--     {
--         provider = "]",
--     },
-- }


local RhsBlock = {
  -- Diagnostics,
  -- LSPActive,
  lazy = LazyStatus,
  ruler = Ruler,
}

return { rhs = RhsBlock }
