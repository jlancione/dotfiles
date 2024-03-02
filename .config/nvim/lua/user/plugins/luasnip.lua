return {
  "L3MON4D3/LuaSnip",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- my snippets
    require("luasnip.loaders.from_snipmate").lazy_load({ paths = "~/.config/nvim/snippets/" })
  end
}
