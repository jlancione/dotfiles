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
keymap("n", "<", "<S-v><<esc>", "Decrease indentation level" )
keymap("n", ">", "<S-v>><esc>", "Increase indentation level" )

-- Utilities
keymap( "n", "<leader>/", ":nohlsearch<CR>", "Kill search highlights" )
keymap( "n", "<leader>qq", ":qa<CR>", "[QQ]uit all" )

-- Visual --
-- Indent staying in visual mode
keymap("v", "<", "<gv^", "Decrease indentation level, stay in V-mode" )
keymap("v", ">", ">gv^", "Increase indentation level, stay in V-mode" )
keymap("v", "p", '"_dP', "Delet selected region and paste" )

-- Move text up and down
keymap("v", "<M-j>", ":m '>+1<CR>gv=gv", "Drag down line" )
keymap("v", "<M-k>", ":m '<-2<CR>gv=gv", "Drag up line"   )
