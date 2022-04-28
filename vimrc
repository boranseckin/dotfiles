set shell=/bin/zsh

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/syntastic'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" Plugin Options
let g:lightline = {
\  'colorscheme': 'wombat',
\  'active': {
\    'left': [['mode', 'paste'], ['gitbranch', 'readonly', 'filename', 'modified']],
\  },
\  'component_function': {
\    'gitbranch': 'FugitiveHead',
\  },
\}

let g:syntastic_javascript_checkers=['eslint']
let g:syntastic_typescript_checkers=['eslint']
let g:syntastic_html_checkers=['eslint']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Options
set noshowmode
set shiftwidth=2
set tabstop=2
set mouse=a
set number
set list
set listchars=trail:·
set scrolloff=4
set sidescrolloff=4
set clipboard=unnamed
set showcmd

" Highlights (xterm colors)
highlight SpecialKey ctermfg=grey
highlight LineNr ctermfg=grey
highlight Pmenu ctermfg=0 ctermbg=8
highlight CocErrorSign ctermfg=196

" Key Maps
let mapleader=' '
nnoremap <silent> <C-f> :GFiles<CR>
nnoremap <silent> <C-b> :Buffers<CR>
nnoremap <silent> <Leader>g :Commits<CR>

