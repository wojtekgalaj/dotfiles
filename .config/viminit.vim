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
Plug 'junegunn/fzf', {'do': {->fzf#install()}}
Plug 'junegunn/fzf.vim', {'do': {->fzf#install()}}
Plug 'evanleck/vim-svelte', {'branch': 'main'}
call plug#end()

" Indentation
set expandtab
set tabstop=2
set shiftwidth=2

colorscheme gruvbox

" Use system clipboard
set clipboard=unnamed

" Prevent cursor from moving after exiting insert mode
let CursorColumnI = 0 "the cursor column position in INSERT
autocmd InsertEnter * let CursorColumnI = col('.')
autocmd CursorMovedI * let CursorColumnI = col('.')
autocmd InsertLeave * if col('.') != CursorColumnI | call cursor(0, col('.')+1) | endif"
