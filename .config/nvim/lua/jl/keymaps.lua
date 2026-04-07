-- Shorten function name
local keymap = function(mode, keys, func, description)
    vim.keymap.set(mode, keys, func, { noremap = true, silent = true, desc = description })
end

--Remap space as leader key
keymap("", "<Space>", "<Nop>", "Make space dummy before setting it as <leader>" )
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal --
-- File navigation
keymap( "n", "<C-d>", "<C-d>zz", "Scroll [D]own" )
keymap( "n", "<C-u>", "<C-u>zz", "Scroll [U]p"   )

-- Window navigation
keymap( "n", "<C-h>", "<C-w>h", "Go to Right window" )
keymap( "n", "<C-j>", "<C-w>j", "Go to Down window"  )
keymap( "n", "<C-k>", "<C-w>k", "Go to Up window"    )
keymap( "n", "<C-l>", "<C-w>l", "Go to Left window"  )

-- Buffer navigation
keymap( "n", "<S-l>", ":bnext<CR>",     "Go to next buffer"     )
keymap( "n", "<S-h>", ":bprevious<CR>", "Go to previous buffer" )

-- Resize windows
keymap( "n", "<S-Up>", ":resize -2<CR>",   "Squeeze (h) Top/Right window" )
keymap( "n", "<S-Down>", ":resize +2<CR>", "Expand (h) Top/Right window"  )
keymap( "n", "<S-Left>", ":vertical resize -2<CR>",  "Expand (v) Top/Right window"  )
keymap( "n", "<S-Right>", ":vertical resize +2<CR>", "Squeeze (v) Top/Right window" )

-- Move text up and down
keymap( "n", "<M-j>", ":m .+1<CR>==", "Drag down line" )
keymap( "n", "<M-k>", ":m .-2<CR>==", "Drag up line"   )

-- Indentation
keymap( "n", "<", "<S-v><<esc>", "Decrease indentation level" )
keymap( "n", ">", "<S-v>><esc>", "Increase indentation level" )

-- Utilities
keymap( "n", "<leader>/", ":nohlsearch<CR>", "Kill search highlights" )

-- Diagnostics
keymap("n", "<leader>dp", function() vim.diagnostic.jump({count=-1, float=true}) end, "Go to [P]revious diagnostic message")
keymap("n", "<leader>dn", function() vim.diagnostic.jump({count=1, float=true}) end, "Go to [N]ext diagnostic message")
keymap("n", "<leader>de", vim.diagnostic.open_float, "Show diagnostic [E]rror message")
keymap("n", "<leader>dq", vim.diagnostic.setloclist, "Open diagnostic [Q]uickfix list")


-- Visual --
-- Indent staying in visual mode
keymap( "v", "<", "<gv^", "Decrease indentation level, stay in V-mode" )
keymap( "v", ">", ">gv^", "Increase indentation level, stay in V-mode" )
keymap( "v", "p", '"_dP', "Delet selected region and paste" )

-- Move text up and down
keymap( "v", "<M-j>", ":m '>+1<CR>gv=gv", "Drag down line" )
keymap( "v", "<M-k>", ":m '<-2<CR>gv=gv", "Drag up line"   )


-- Terminal --
local job_id = nil -- can be used for further keymaps, to control the terminal
local terminal_state = { buf = -1, win = -1 } -- invalid buf and win, 0 stands for current buf/win

local function create_split(opts)
  opts = opts or {}

  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf( false, true ) -- Not listed(?), scratch buffer (ie a NOFILE)
  end

  local win = vim.api.nvim_open_win( buf, false, { split = "below", height = 8, win = 0 })
  return { buf = buf, win = win }
end

local function launch_terminal()
  vim.cmd.terminal()
  job_id = vim.bo.channel
  vim.fn.chansend(job_id, { "fish_default_key_bindings && clear\r" }) -- \r stands for <CR>
end

keymap( {"n", "t"}, "<leader>tt", function()
    if not vim.api.nvim_win_is_valid(terminal_state.win) then
      terminal_state = create_split(terminal_state)
      vim.fn.win_gotoid(terminal_state.win)
      if vim.bo[terminal_state.buf].buftype ~= "terminal" then
        launch_terminal()
      end
      vim.cmd.startinsert()
    else
      vim.api.nvim_win_hide(terminal_state.win)
    end
  end,
  "[T]oggle [T]erminal" )

keymap( "n", "<leader>x", function()
    vim.cmd.write()
    local bufname = vim.api.nvim_buf_get_name(0) -- works only if you trigger it from the project file, not from the terminal
    local filename = vim.fn.fnamemodify(bufname, ":r")
    local current_win = vim.fn.win_getid()

    if not vim.api.nvim_win_is_valid(terminal_state.win) then
      terminal_state = create_split(terminal_state)
      if vim.bo[terminal_state.buf].buftype ~= "terminal" then
        vim.fn.win_gotoid(terminal_state.win)
        launch_terminal()
     -- launch the virtual environment only if the terminal has never been opened, otherwise launch it manually
        vim.fn.chansend(job_id, { "pyenv\r" })
        vim.fn.win_gotoid(current_win)
      end
    end

    vim.fn.chansend(job_id, { "python " .. filename .. ".py\r" })

end,
  "E[X]ecute python script" )


keymap( "t", "<Esc>", "<C-Bslash><C-N>", "[Esc]ape insert mode in terminal" )

-- Miscellanea --
-- Spell
keymap( "n", "<leader>sp", ":setlocal spell spelllang=en_gb<CR>:echo 'Spell ON'<CR>", "Launch [SP]ell" )
-- Zotero
keymap( "n", "<leader>fc", ":Telescope bibtex format_string=\\cite{%s}<CR>", "[F]ind [C]itation" )


-- Remove clutter from insert mode
keymap( "i", "<M-C-S-D-Space>", "<Nop>", "Unmap key" )
keymap( "i", "<M-C-S-D-B>", "<Nop>", "Unmap key" )
keymap( "i", "<M-C-S-D-'>", "<Nop>", "Unmap key" )
keymap( "i", "<M-C-S-D-,>", "<Nop>", "Unmap key" )
keymap( "i", "<M-C-S-D-.>", "<Nop>", "Unmap key" )
keymap( "i", "<M-C-S-D-/>", "<Nop>", "Unmap key" )
keymap( "i", "<M-C-S-D-=>", "<Nop>", "Unmap key" )
keymap( "i", "<M-C-S-D-Bslash>", "<Nop>", "Unmap key" )
keymap( "i", "<M-C-S-D-->", "<Nop>", "Unmap key" )
keymap( "i", "<M-C-S-D-;>", "<Nop>", "Unmap key" )
