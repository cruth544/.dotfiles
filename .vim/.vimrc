set nocompatible
filetype off
set rtp+=~/.dotfiles/.vim/bundle/vundle.vim
set rtp+=~/.dotfiles/.vim
call vundle#rc()

" Vundles

" File Structure

" File Tree structure
"Plugin 'scrooloose/nerdtree'

" Ctrl + P (fuzzy file search) should be exclusive with NerdTree
Plugin 'ctrlpvim/ctrlp.vim'

" L9 - Library
Plugin 'vim-scripts/l9'

" Fuzzy File Finder
Plugin 'vim-scripts/FuzzyFinder'

" Snippet dependencies
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
" Snippets
Plugin 'garbas/vim-snipmate'

" Snippet optional plugins
Plugin 'honza/vim-snippets'


"Plugin
" Emmet
Plugin 'mattn/emmet-vim'

" Match Opening and Closing Symbols
Plugin 'valloric/MatchTagAlways'
" Drop line on enter (inside closing tags)
Plugin 'delimitMate.vim'

" Auto Formating
Plugin 'Chiel92/vim-autoformat'

" Multiple Cursors
Plugin 'terryma/vim-multiple-cursors'

" Use <Tab> for insert completion
Plugin 'ervandew/supertab'

" Keyword completion (requires lua)
Plugin 'Shougo/neocomplete.vim'

 "YouCompleteMe
"Plugin 'valloric/YouCompleteMe'


" CSV Viewer
Plugin 'chrisbra/csv.vim'
" Extra Javascript Highlighting
"Plugin 'pangloss/vim-javascript' (issues opening files)
Plugin 'othree/javascript-libraries-syntax.vim'
" NodeJS Highlighting
Plugin 'moll/vim-node'

" Commenting
Plugin 'scrooloose/nerdcommenter'

" HTML Autocomplete/Syntax
Plugin 'othree/html5.vim'
Plugin 'othree/html5-syntax.vim'

" CSS Autocomplete
Plugin 'groenewege/vim-less'
Plugin 'Townk/vim-autoclose'

" TypeScript Syntax
Plugin 'leafgarland/typescript-vim'


" Mustache .hbs files syntax
Plugin 'mustache/vim-mustache-handlebars'

" Color Package
Plugin 'chriskempson/base16-vim'

filetype on
filetype plugin on
filetype indent on

syntax on 
set number
set noswapfile " no swp file
" Indentation
"set autoindent
set smartindent
set noexpandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

set textwidth=80
set nohlsearch
set ignorecase
set smartcase
set incsearch

set backspace=indent,eol,start

" Split navigation for Chromebook
" Ctrl-w defaults to close tab
nmap Kh :wincmd h<Enter>
nmap Kl :wincmd l<Enter>
nmap Kj :wincmd j<Enter>
nmap Kk :wincmd k<Enter>

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" NERDTree remap
"map <C-p> :NERDTreeToggle<CR>

" CtrlP Settings
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
"let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_max_files = 0

" FuzzyFinder remap
map <C-p>p :FufFile<CR>

let g:fuf_keyOpen = "<C-l>"
let g:fuf_keyOpenTabpage = "<CR>"

" disable expandtab for makefiles
let _curfile = expand("%:t")
if _curfile =~ "Makefile" || _curfile =~ "makefile" || _curfile =~ ".*\.mk"
    set noexpandtab
endif

" sublime like new lines
let delimitMate_expand_cr=1

" Other settings

" JavaScript Libraries
let g:used_javascript_libs = 'jquery,underscore,angularjs,angularui,angularuirouter,react,flux,backbone,jasmine'

" Syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_on_wq = 0

" TypeScript Indenting Disable
" let g:typescript_indent_disable = 1

" Handlebar Mustache_Abbreviations
let g:mustache_abbreviations = 1

" Supertab
let g:SuperTabDefaultCompletionType= "<c-n>"

" Base-16 (Color)
"let base16colorspace=256

" Monokai Color
colorscheme monokai

