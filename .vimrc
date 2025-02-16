"       _   _     
"      | | | |      .VIMRC    
"      | | | |    
"      | | | |      https://www.github.com/jlancione
"  /\__/ / | |____
"  \____/  \_____/
"
"
" `zo`(`zc`) to open/close SINGLE fold, `zR`(`zM`) to open(close) ALL folds

" GENERAL SETTINGS -------------------------------------------------------- {{{
" `:help <command>` for more information on specific commands

set nocompatible    " Disable compatibility with vi which can cause unexpected issues.
filetype on         " Enable type file detection

"filetype plugin on  " Enable plugins and load plugin for the detected file type.
"filetype indent on  " Load an indent file for the detected file type.
"set nobackup        " Do not save backup files.

syntax on           " Turn syntax highlighting on.
set clipboard=unnamedplus  
                    " Copy/Paste between vim and other applications
set mouse=a         " Enable mouse when in terminal emulator
set history=1000    " Set the commands to save in history default number is 20.
set scrolloff=10    " Do not let cursor scroll below or above N number of lines when scrolling.

set wildmenu        " Enable AUTO COMPLETION menu after pressing TAB. (in command mode)
set wildmode=list:longest
                    " Make wildmenu behave like Bash completion.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx 
                    " There are certain files that we would never want to edit with Vim.
set rtp+=/opt/homebrew/opt/fzf
                    " https://thevaluable.dev/fzf-vim-integration/ for full info

"}}}

" APPEARANCE ------------------------------------------------------------- {{{

colorscheme retrobox
set background=dark

set number          " Add numbers on the left
set cursorline      " Highlight cursor line
set showcmd         " Show partial command you type in the last line of the screen.
set showmode        " Show the mode you are on the last line.
set nowrap          " Allow long lines to extend as far as the line goes.

"}}}

" TAB RELATED ------------------------------------------------------------ {{{

set expandtab       " Use space characters instead of tabs.
set tabstop=4       " TAB   = 4 spaces.
"set shiftwidth=4   " SHIFT = 4 spaces.
set smarttab        " Complites the previous TAB

"}}}

" SEARCH SETTINGS -------------------------------------------------------- {{{

set incsearch       " Incrementally highlight matching characters as you type.
set ignorecase      " Ignore capital letters during search.
set smartcase       " Override previous to consider capital only if used
set showmatch       " Show matching words during a search.
set hlsearch        " Use highlighting when doing a search.

"}}}

" MAPPINGS --------------------------------------------------------------- {{{

let mapleader = "<space>"

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
nnoremap <d-j> :m .+1<cr>==
nnoremap <d-k> :m .-2<cr>==
vnoremap <d-j> :m '>+1<cr>gv=gv
vnoremap <d-k> :m '<-2<cr>gv=gv

" Kill search highlights
nnoremap <cr> :noh<cr>

" Indentation
nnoremap < <s-v><<esc>
nnoremap > <s-v>><esc>


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
    set undodir=~/.vim/backup
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

" Clear statusline when config is loaded
set statusline=

" Statusline left side
set statusline+=\ %F\ %m

" Use a divider to separate the right side
set statusline+=%=

" Statusline right side
set statusline+=\ %Y\ /\ row:\ %l\ col:\ %c\ /\ %p%%

" Show the status on the second to last line
set laststatus=2

" }}}
