set nocompatible
filetype off
set rtp+=~/.dotfiles/.vim/bundle/vundle
call vundle#rc()

" Vundles

Plugin 'mattn/emmet-vim'
Plugin 'valloric/MatchTagAlways'
Plugin 'valloric/YouCompleteMe'
Plugin 'mustache/vim-mustache-handlebars'

filetype on


syntax on 
set number
set autoindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set nohlsearch
set ignorecase
set smartcase

" Split navigation for Chromebook
" Ctrl-w defaults to close tab
nmap Kh :wincmd h<Enter>
nmap Kl :wincmd l<Enter>
nmap Kj :wincmd j<Enter>
nmap Kk :wincmd k<Enter>

" disable expandtab for makefiles
let _curfile = expand("%:t")
if _curfile =~ "Makefile" || _curfile =~ "makefile" || _curfile =~ ".*\.mk"
    set noexpandtab
endif

" Other settings

" Handlebar Mustache_Abbreviations
let g:mustache_abbreviations = 1
