local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.keymap.set
-- local keymap = function(mode, keys, func, description)
--     vim.keymap.set(mode, keys, func, { noremap = true, silent = true, desc = description })
-- end

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal --
-- Better moving through file
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<S-Up>", ":resize -2<CR>", opts)
keymap("n", "<S-Down>", ":resize +2<CR>", opts)
keymap("n", "<S-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<S-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
-- keymap("n", "<A-j>", ":m .+1<CR>==", "Move line up")
-- keymap("n", "<A-k>", ":m .-2<CR>==", "Move line down")

-- Kill search highlights
keymap("n", "<leader>/", ":nohlsearch<CR>", opts)

-- Indentation
keymap("n", "<", "<S-v><<esc>", opts)
keymap("n", ">", "<S-v>><esc>", opts)


-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv^", opts)
keymap("v", ">", ">gv^", opts)
keymap("v", "p", '"_dP', opts)

-- Move text up and down
-- keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", "Move line up")
-- keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", "Move line down")
-- keymap("v", "p", '"_dP', "Delete selected region and paste")

-- Nvimtree
-- keymap("n", "<leader>e", "<cmd>Ntree<cr>", opts)
