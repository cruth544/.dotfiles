set nocompatible
filetype off
set rtp+=~/.dotfiles/.vim/bundle/vundle
call vundle#rc()

" Vundles

" File Structure
"Plugin
" Emmet
Plugin 'mattn/emmet-vim'

" Match Opening and Closing Symbols
Plugin 'valloric/MatchTagAlways'

" Use <Tab> for insert completion
Plugin 'ervandew/supertab'

" AutoComplete (Don't use, weird behavior with ESC)
"Plugin 'vim-scripts/AutoComplPop'

" Keyword completion (requires lua)
Plugin 'Shougo/neocomplete.vim'

" Extra Javascript Highlighting
"Plugin 'pangloss/vim-javascript' (issues opening files)
Plugin 'othree/javascript-libraries-syntax.vim'
" NodeJS Highlighting
Plugin 'moll/vim-node'

" Syntax Checker
Plugin 'scrooloose/syntastic'

" Commenting
Plugin 'scrooloose/nerdcommenter'

" HTML Autocomplete/Syntax
Plugin 'othree/html5.vim'
Plugin 'othree/html5-syntax.vim'

" CSS Autocomplete
Plugin 'groenewege/vim-less'
Plugin 'Townk/vim-autoclose'

" Mustache .hbs files syntax
Plugin 'mustache/vim-mustache-handlebars'


filetype on
filetype plugin on

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
set incsearch

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

" JavaScript Libraries
let g:used_javascript_libs = 'jquery,underscore,angularjs,angularui,angularuirouter,react,flux,backbone,jasmine'

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_on_wq = 0

" Handlebar Mustache_Abbreviations
let g:mustache_abbreviations = 1

" Supertab
let g:SuperTabDefaultCompletionType= "<c-n>"

