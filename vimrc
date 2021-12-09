set shell=/bin/zsh

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-sensible'
Plug 'preservim/nerdcommenter'
Plug 'vim-syntastic/syntastic'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

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

highlight SpecialKey ctermfg=grey
highlight LineNr ctermfg=grey
