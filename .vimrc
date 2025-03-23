"       _   _     
"      | | | |      .VIMRC    
"      | | | |    
"      | | | |      https://www.github.com/jlancione
"  /\__/ / | |____
"  \____/  \_____/
"
"
" `zo`(`zc`) to open(close) SINGLE fold, `zR`(`zM`) to open(close) ALL folds
" Quickfix: 
" Copy/Pasting problems? Try changing to clipboard=unnamedplus
" Does .vim/backup exist? (for persistent undos)
" Do you have fzf? Maybe it's at a different path...
" Check :version for available features

" GENERAL SETTINGS -------------------------------------------------------- {{{
" `:help <command>` for more information on specific commands

set nocompatible    " Disable compatibility with vi which can cause unexpected issues.
filetype on         " Enable type file detection

"filetype plugin on  " Enable plugins and load plugin for the detected file type.
"filetype indent on  " Load an indent file for the detected file type.
"set nobackup        " Do not save backup files.
set noswapfile      " Swap files are like temporary files with buffer changes

syntax on           " Turn syntax highlighting on.
set clipboard=unnamed  
                    " Copy/Paste between vim and other applications
"set mouse=a         " Enable mouse when in terminal emulator
set history=1000    " Set the commands to save in history default number is 20.
set scrolloff=10    " Minimal number of screen lines to keep above and below cursor

set wildmenu        " Enable AUTO COMPLETION menu after pressing TAB. (in command mode)
set wildmode=list:longest
                    " Make wildmenu behave like Bash completion.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx 
                    " There are certain files that we would never want to edit with Vim.

set whichwrap=b,s,h,l
                    " Which horizontal keys are allowed to travel to the next/prev line

set rtp+=/opt/homebrew/opt/fzf
                    " https://thevaluable.dev/fzf-vim-integration/ for full info

"}}}

" APPEARANCE ------------------------------------------------------------- {{{

colorscheme retrobox
set background=dark

set number          " Add numbers on the left
set relativenumber  " Make the numbers relative to the current line
set cursorline      " Highlight cursor line
set showcmd         " Show partial command you type in the last line of the screen.
set showmode        " Show the mode you are on the last line.
set nowrap          " Allow long lines to extend as far as the line goes.

set splitbelow      " When split open new below
set splitright      " When vsplit open new right

"}}}

" TAB, INDENT RELATED ---------------------------------------------------- {{{

set expandtab       " Use space characters instead of TABs.
autocmd BufRead,BufNewFile   Makefile setlocal noexpandtab
                    " To keep TABs in Makefile
set tabstop=2       " TAB   = 2 spaces.
set shiftwidth=2    " SHIFT = 2 spaces. (for indentation)
set smarttab        " Completes the previous TAB

"}}}

" SEARCH SETTINGS -------------------------------------------------------- {{{

set incsearch       " Incrementally highlight matching characters as you type.
set ignorecase      " Ignore capital letters during search.
set smartcase       " Override previous to consider capital only if used
set showmatch       " Show matching words during a search.
set hlsearch        " Use highlighting when doing a search.

"}}}

" MAPPINGS --------------------------------------------------------------- {{{

" Use space as Leader (need to unmap it before, by default it is mapped to right arrow)
nnoremap <SPACE> <Nop> 
let mapleader = " "

" Better scrolling through file
nnoremap <c-d> <c-d>zz
nnoremap <c-u> <c-u>zz

" Better window navigation
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" Buffers navigation
nnoremap <s-l> :bnext<cr>
nnoremap <s-h> :bprevious<cr>

" Move text up and down
nnoremap <a-j> :m .+1<cr>==
nnoremap <a-k> :m .-2<cr>==
vnoremap <a-j> :m '>+1<cr>gv=gv
vnoremap <a-k> :m '<-2<cr>gv=gv

" Kill search highlights
nnoremap <cr> :noh<cr>

" Indentation
nnoremap < <s-v><<esc>
nnoremap > <s-v>><esc>

" To avoid reaching Esc
inoremap jk <Esc>
inoremap kj <Esc>

" }}}

" VIMSCRIPT -------------------------------------------------------------- {{{
" `:help autocmd` for more information

" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" If Vim version is equal or greater than 7.3 enable undofile 
" (undo changes even after saving)
if version >= 703
    set undodir=~/.vim/backup  " This dir needs to be created if absent
    set undofile
    set undoreload=10000
endif

" This script makes that cursor line is displayed only in active split window
" (uncomment cursorcolumn and nocursorcolumn if it is activated)
augroup cursor_off
    autocmd!
    autocmd WinLeave * set nocursorline "nocursorcolumn
    autocmd WinEnter * set cursorline "cursorcolumn
augroup END

" }}}

" STATUS LINE ------------------------------------------------------------ {{{
" `:help statusline` for more information

set statusline=               " Clear statusline when config is loaded

set statusline+=\ %F\ %m      " Statusline left side
set statusline+=%=            " Use a divider to separate the right side
set statusline+=\ %Y\ \|\ row:\ %l\ col:\ %c\ \|\ %p%% 
                              " Statusline right side
set laststatus=2              " Show the status on the second to last line

" }}}

" NETRW ----------------------------------------------------------------- {{{

let g:netrw_keepdir = 0     " Have the current and working dir synced

let g:netrw_preview = 1
let g:netrw_alto = 1
let g:nerw_liststyle = 3
"let g:netrw_banner  = 0     " To hide the banner

nnoremap <leader>e :20Lexplore<cr>
                            " 20 is the size of the split

function! NetrwMapping()    " To define keymaps in Netrw
  nmap <buffer> H u         " Go back in history (like an undo?)
  nmap <buffer> h -^        " Go up a directory
  nmap <buffer> l <CR>      " Open dir/file

" nmap <buffer> . gh        " Toggle dotfiles
  nmap <buffer> P <C-w>z    " Close preview window

  nmap <buffer> L <CR>:Lexplore<CR> 
                            " Open file and close Netrw
  nmap <buffer> <Leader>e :Lexplore<CR>
                            " Close Netrw
endfunction

augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END

"}}}
