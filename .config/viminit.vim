let mapleader = " "

" Better movement between windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Clean search 
map <leader>h :noh<CR>
"
" Center screen on next and previous search result
map n nzz
map N Nzz

" Save all buffers
map <leader>w :wa<CR>
map <leader>e :Explore<CR>

call plug#begin('~/.vim/plugged')
Plug 'evanleck/vim-svelte', {'branch': 'main'}
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'Raimondi/delimitMate'
call plug#end()

" Indentation
set expandtab
set tabstop=2
set shiftwidth=2
set smartindent
set nohlsearch
set hidden
set noerrorbells
set smartcase
set scrolloff=8

colorscheme gruvbox

" Use system clipboard
set clipboard=unnamed

" Prevent cursor from moving after exiting insert mode
let CursorColumnI = 0 "the cursor column position in INSERT
autocmd InsertEnter * let CursorColumnI = col('.')
autocmd CursorMovedI * let CursorColumnI = col('.')
autocmd InsertLeave * if col('.') != CursorColumnI | call cursor(0, col('.')+1) | endif"

" Telescope remaps
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Emmet setup
let g:user_emmet_expandabbr_key='<Tab>'
imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
