return {
  {
    "lervag/wiki.vim",
    init = function()  -- not `config` because it needs to run before loading the plugin

      vim.g.wiki_root = "~/wiki"

    end
  }
}
