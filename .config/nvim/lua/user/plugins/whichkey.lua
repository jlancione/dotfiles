return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 200
  end,
  opts = {
    setup = {
      show_help = true,
      plugins = {  -- whichkey has its own plugins eg. marks, registers, spelling
        presets = {
          -- the presets plugin, adds help for a bunch of default keybindings in Neovim
          -- No actual key bindings are created
          operators = false,    -- adds help for operators like d, y, ... and registers them for motion / text object completion
          motions = false,      -- adds help for motions
          text_objects = false, -- help for text objects triggered after entering an operator
          windows = false,      -- default bindings on <c-w>
          nav = false,          -- misc bindings to work with windows
          z = false,            -- bindings for folds, spelling and others prefixed with z
          g = false,            -- bindings for prefixed with g
          marks = false,        -- shows a list of your marks on ' and `
          registers = false,    -- shows your registers on " in NORMAL or <C-r> in INSERT mode
          spelling = {
            enabled = false,    -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 10,   -- how many suggestions should be shown in the list?
          },
        },
      },
      key_labels = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        -- For example:
        -- ["<space>"] = "SPC",
        -- ["<CR>"] = "RET",
        -- ["<tab>"] = "TAB",
      },
      -- show_keys = true, -- show the currently pressed key and its label as a message in the command line
      -- triggers = "auto", -- automatically setup triggers
      triggers = { "<leader>" }, -- or specify a list manually
      -- add operators that will trigger motion and text object completion
      -- to enable native operators, set the preset / operators plugin above
      -- operators = { gc = "Comments" },
      icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+",      -- symbol prepended to a group
      },
      popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>",   -- binding to scroll up inside the popup
      },
      window = {
        border = "rounded",       -- none, single, double, shadow
        position = "bottom",      -- bottom, top
        margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,             -- value between 0-100 0 for fully opaque and 100 for fully transparent
        zindex = 1000,            -- positive value to position WhichKey above other floating windows.
      },
      layout = {
        height = { min = 4, max = 25 },                                             -- min and max height of the columns
        width = { min = 20, max = 50 },                                             -- min and max width of the columns
        spacing = 3,                                                                -- spacing between columns
        align = "left",                                                             -- align columns left, center or right
      },
      ignore_missing = true,                                                        -- enable this to hide mappings for which you didn't specify a label
      hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
      triggers_nowait = {
      },
      triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { "j", "k" },
        v = { "j", "k" },
      },
      -- disable the WhichKey popup for certain buf types and file types.
      -- Disabled by default for Telescope
      disable = {
        buftypes = {},
        filetypes = {},
      },
    },
    defaults = {
      buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true,  -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = true,  -- use `nowait` when creating keymaps
      prefix = "<leader>",
      mode = { "n", "v" },
      b = { "<cmd>VimtexCompile<CR>", "build" },
      e = { "<cmd>NvimTreeToggle<CR>", "explorer" },
      -- j = { "<cmd>vert sb<CR>", "new split" },
      i = { "<cmd>VimtexTocOpen<CR>", "index" },
      -- k = { "<cmd>on<CR>", "max split" },
      -- q = { "<cmd>wa! | qa!<CR>", "quit" },
      u = { "<cmd>Telescope undo<CR>", "undo" },
      v = { "<cmd>VimtexView<CR>", "view" },
      w = { "<cmd>wa!<CR>", "write" },
      -- z = { "<cmd>ZenMode<CR>", "zen" },
      a = {
        name = "ACTIONS",
 --     a = { "<cmd>lua PdfAnnots()<CR>", "annotate" },
        b = { "<cmd>terminal bibexport -o %:p:r.bib %:p:r.aux<CR>", "bib export" },
        c = { "<cmd>:VimtexClearCache All<CR>", "clear vimtex" },
        e = { "<cmd>e ~/.config/nvim/snippets/tex.snippets<CR>", "edit snippets" },
        f = { "<cmd>lua vim.lsp.buf.format()<CR>", "format" },
        g = { "<cmd>e ~/.config/nvim/templates/Glossary.tex<CR>", "edit glossary" },
        -- h = { "<cmd>lua _HTOP_TOGGLE()<CR>", "htop" },
        h = { "<cmd>LocalHighlightToggle<CR>", "highlight" },
        k = { "<cmd>VimtexClean<CR>", "kill aux" },
        -- l = { "<cmd>lua vim.g.cmptoggle = not vim.g.cmptoggle<CR>", "LSP" },
        -- m = { "<cmd>MarkdownPreview<CR>", "markdown preview" },
 --     p = { "<cmd>TermExec cmd='python %:p:r.py'<CR><C-w>j", "python" },
        -- P = { "<cmd>!python %:p:r.py<CR>", "python" },
        r = { "<cmd>VimtexErrors<CR>", "report errors" },
        u = { "<cmd>cd %:p:h<CR>", "update cwd" },
        v = { "<plug>(vimtex-context-menu)", "vimtex menu" },
        w = { "<cmd>VimtexCountWords!<CR>", "word count" },
        -- s = { "<cmd>lua function() require('cmp_vimtex.search').search_menu() end<CR>"           , "search citations" },
      },
      -- c = {
      --   name = "CITATION",
      --   t = { "<cmd>Telescope bibtex format_string=\\citet{%s}<CR>", "\\citet" },
      --   p = { "<cmd>Telescope bibtex format_string=\\citep{%s}<CR>", "\\citep" },
      --   s = { "<cmd>Telescope bibtex format_string=\\citepos{%s}<CR>", "\\citepos" },
      -- },
      f = {
        name = "FIND",
        b = {
          "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<CR>",
          "buffers",
        },
        c = { "<cmd>Telescope bibtex format_string=\\citet{%s}<CR>", "citations" },
        f = { "<cmd>Telescope live_grep theme=ivy<CR>", "project" },
        g = { "<cmd>Telescope git_branches<CR>", "branches" },
        h = { "<cmd>Telescope help_tags<CR>", "help" },
        k = { "<cmd>Telescope keymaps<CR>", "keymaps" },
        -- m = { "<cmd>Telescope man_pages<CR>", "man pages" },
        r = { "<cmd>Telescope registers<CR>", "registers" },
        -- t = { "<cmd>Telescope colorscheme<CR>", "theme" },
     -- y = { "<cmd>YankyRingHistory<CR>", "yanks" },
        -- c = { "<cmd>Telescope commands<CR>", "commands" },
        -- r = { "<cmd>Telescope oldfiles<CR>", "recent" },
      },
 --   g = {
 --     name = "GIT",
 --     -- b = { "<cmd>Telescope git_branches<CR>", "checkout branch" },
 --     -- c = { "<cmd>Telescope git_commits<CR>", "checkout commit" },
 --     d = { "<cmd>Gitsigns diffthis HEAD<CR>", "diff" },
 --     b = { "<cmd>Gitsigns toggle_current_line_blame<CR>", "blame" },
 --     g = { "<cmd>LazyGit<CR>", "lazygit" },
 --     j = { "<cmd>Gitsigns next_hunk<CR>", "next hunk" },
 --     k = { "<cmd>Gitsigns prev_hunk<CR>", "prev hunk" },
 --     -- o = { "<cmd>Telescope git_status<CR>", "open changed file" },
 --     p = { "<cmd>Gitsigns preview_hunk<CR>", "preview hunk" },
 --     -- r = { "<cmd>lua require 'gitsigns'.reset_hunk()<CR>", "reset hunk" },
 --     -- s = { "<cmd>lua require 'gitsigns'.stage_hunk()<CR>", "stage hunk" },
 --     -- u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<CR>", "unstage hunk" },
 --   },
      -- h = {
      --   name = "HARPOON",
      --   m = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "mark" },
      --   n = { "<cmd>lua require('harpoon.ui').nav_next()<cr>", "next" },
      --   p = { "<cmd>lua require('harpoon.ui').nav_prev()<cr>", "previous" },
      -- (?) },
      -- -- NEORG LIST MAPPINGS
      -- l = {
      --   name = "LIST",
      --   a = { "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_ambiguous<CR>", "ambiguous" },
      --   b = { "<cmd>Neorg keybind norg core.promo.demote<CR>", "backwards indent" },
      --   c = { "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_cancelled<CR>", "cancel" },
      --   d = { "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_done<CR>", "done" },
      --   f = { "<cmd>Neorg keybind norg core.promo.promote<CR>", "forward indent" },
      --   i = { "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_important<CR>", "important" },
      --   n = { "<cmd>Neorg keybind norg core.itero.next-iteration<CR>", "new task" },
      --   -- n = { "<cmd>set filetype=norg<CR>", "neorg" },
      --   p = { "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_pending<CR>", "pending" },
      --   r = { "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_recurring<CR>", "recurring" },
      --   t = { "<cmd>Neorg toggle-concealer<CR>", "toggle concealer" },
      --   u = { "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_undone<CR>", "undone" },
      --   v = { "<cmd>Neorg keybind norg core.pivot.invert-list-type<CR>", "invert list" },
      --   -- t = { "<cmd>Neorg keybind norg core.pivot.toggle-list-type<CR>", "toggle list" },
      -- },
      L = {
        name = "LSP",
        b = { "<cmd>Telescope diagnostics bufnr=0<CR>", "buffer diagnostics" },
        c = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "code action" },
        d = { "<cmd>Telescope lsp_definitions<CR>", "definition" },
        D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "declaration" },
        h = { "<cmd>lua vim.lsp.buf.hover()<CR>", "help" },
        i = { "<cmd>Telescope lsp_implementations<CR>", "implementations" },
        k = { "<cmd>LspStop<CR>", "kill lsp" },
        l = { "<cmd>lua vim.diagnostic.open_float()<CR>", "line diagnostics" },
        n = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "next diagnostic" },
        p = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "previous diagnostic" },
        r = { "<cmd>Telescope lsp_references<CR>", "references" },
        s = { "<cmd>LspRestart<CR>", "restart lsp" },
        t = { "<cmd>LspStart<CR>", "start lsp" },
        R = { "<cmd>lua vim.lsp.buf.rename()<CR>", "rename" },
        T = { "<cmd>Telescope lsp_type_definitions<CR>", "type definition" },
      },
      t = {
        name = "TEMPLATES",
        r = {
          "<cmd>read ~/.config/nvim/templates/RelazElettronica.tex<CR>",
          "Relazione",
        },
        x = {
          "<cmd>read ~/.config/nvim/templates/modelloMAXI.tex<CR>",
          "Maxi",
        },
        m = {
          "<cmd>read ~/.config/nvim/templates/makefile<CR>",
          " makefile",
        },
        c = {
          "<cmd>read ~/.config/nvim/templates/main.cpp<CR>",
          " cpp",
        },
        g = {
          "<cmd>read ~/.config/nvim/templates/plot.gp<CR>",
          "gnupolt script",
        },
      },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts.setup)
    wk.register(opts.defaults)
  end,
}
