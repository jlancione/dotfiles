return {
  {
    "lervag/wiki.vim",
    init = function()  -- not `config` because it needs to run before loading the plugin

      vim.g.wiki_root = "~/wiki"
      -- alla fine si tratta di configurare dle vim.g.wiki_something
      -- g.wiki_global_load    vogliamo tenere solo root?
      -- g.wiki_select_method  puoi usare Telescope
      -- g.wiki_index_name
      -- g.wiki_journal
      -- c'è un sistema di tags che sicuramente è utile
      -- si possono specificare dei templates

    end
  }
}
