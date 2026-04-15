return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter').install {
        "lua", "cpp", "python", "latex", "markdown", "markdown_inline", "bash", "fish", "gitignore",
      }
    end
  }
}
