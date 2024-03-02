return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "L3MON4D3/LuaSnip", -- snippet engine
    "saadparwaiz1/cmp_luasnip", -- for autocompletion
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path", -- source for file system paths
    -- "hrsh7th/cmp-cmdline",
    -- "micangl/cmp-vimtex", -- source for vimtex completion
    "rafamadriz/friendly-snippets", -- useful snippets
    -- "hrsh7th/cmp-nvim-lua", -- useful for working on the config (provides completion for the vim. object for example)
    -- "petertriho/cmp-git",
    -- "f3fora/cmp-spell",
    -- "aspeddro/cmp-pandoc.nvim",
  },
  config = function()
    local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

--   פּ ﯟ   some other good icons
local kind_icons = {
  Text = "󰊄",
  Method = "m",
  Function = "󰊕",
  Constructor = "",
  Field = "",
  Variable = "󰫧",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "󰌆",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "󰉺",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

cmp.setup { -- here we are selecting the snippet engine
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = {
    ["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ["<C-e>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm { select = true },

    -- setting superTab (ie overloading the Tab key)
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  },
  -- qsto che segue e' l'aspetto del menu che spunta mentre scrivi (e' qua che scegli chi compare e messo come)
  formatting = {
    fields = { "kind", "abbr", "menu" }, -- qsto è l'ordine con cui vengono fornite le info in ciasc1 riga del menu
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      vim_item.menu = ({
        -- omni = (vim.inspect(vim_item.menu):gsub('%"', "")),
        vimtex = (vim_item.menu ~= nil and vim_item.menu or "[VimTex]"),
        -- vimtex = vim_item.menu,
        -- vimtex = (vim_item.menu ~= nil and vim_item.menu or ""),
        luasnip = "[Snippet]",
        nvim_lsp = "[LSP]",
        buffer = "[Buffer]",
        -- nvim_lua = "[Nvim_Lua]
        -- spell = "[Spell]",
        -- orgmode = "[Org]",
        -- latex_symbols = "[Symbols]",
        -- cmdline = "[CMD]",
        path = "[Path]",
      })[entry.source.name]
      return vim_item
    end,
  },
  sources = { -- qsto e' l'ordine in cui compaiono le scelte nel menu
  -- se prima abbiamo settato lo snippet engine h gli stiamo dicendo da dove pescare i suggerimenti (chiaramente sono tutti plugin e se ne vuoi altri nn devi solo metterli nel plugin.lua ma anche aggiungerli qua)
    { name = "luasnip" },
    { name = "nvim_lsp" },
--    { name = 'nvim_lua' },
    { name = 'vimtex', },
    { name = "buffer" },
    { name = "path" },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    -- documentation = cmp.config.window.bordered(),
    completion = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },
  },
  experimental = {
    ghost_text = false,
    native_menu = false,
  },
}
  end,
}
