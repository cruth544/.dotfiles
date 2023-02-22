set nocompatible
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.dotfiles/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
set rtp+=~/.dotfiles/.vim/bundle/vundle.vim
set rtp+=~/.dotfiles/.vim
set encoding=utf-8
let mapleader = ' '


let $VIM_PLUGINS = $HOME . "/.dotfiles/.vim/.vim-plug"
let $MYVIMRC = $HOME . "/.dotfiles/.vim/.vimrc"
source $VIM_PLUGINS
let _curfile = expand("%:t")

call vundle#rc()
let off = 0

" Vundles

" Color Package
Plugin 'chriskempson/base16-vim'

" Sensible Vim
Plugin 'tpope/vim-sensible'

" Obsession
" vim saver
Plugin 'tpope/vim-obsession'

" IDE
" Plugin 'xmementoit/vim-ide'

" File Tree structure
" Plugin 'scrooloose/nerdtree'

" Netrw
Plugin 'vim-scripts/netrw.vim'

" Fuzzy finder for vim
Plugin 'junegunn/fzf.vim'

" Ctrl+P
Plugin 'ctrlpvim/ctrlp.vim'

" Better status line
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Show search results in window
" Plugin 'rking/ag.vim'

" Linter
" Plugin 'w0rp/ale'

" L9 - Library
" Plugin 'vim-scripts/l9'

" Grab line excluding line endings
Plugin 'kana/vim-textobj-user'
Plugin 'kana/vim-textobj-line'

" Snippet dependencies
" Plugin 'MarcWeber/vim-addon-mw-utils'
" Plugin 'tomtom/tlib_vim'

" Snippets
" Plugin 'garbas/vim-snipmate'

" Snippet optional plugins
" Plugin 'honza/vim-snippets'

" Emmet
Plugin 'mattn/emmet-vim'
" runtime macros/matchit.vim

" Match Opening and Closing Symbols
Plugin 'valloric/MatchTagAlways'

" Drop line on enter (inside closing tags)
Plugin 'Raimondi/delimitMate'

" Auto Formating
" Plugin 'Chiel92/vim-autoformat'

" Surround text
Plugin 'tpope/vim-surround'

" UltiSnips
" Plugin 'SirVer/ultisnips'

" Commenting
Plugin 'scrooloose/nerdcommenter'

" Autocomplete
" Plugin 'ycm-core/YouCompleteMe'

" UltiSnips
Plugin 'SirVer/ultisnips'

" Provide many default snippets for a variety of snippets.
Plugin 'honza/vim-snippets'

" For special replace functions
Plugin 'tpope/vim-abolish'

" Git support
" Plugin 'tpope/vim-fugitive'
" Git Gutter
" Plugin 'airblade/vim-gitgutter'
" Git NerdTree plugin
" Plugin 'Xuyuanp/git-nerdtree'

" Multiple Cursors
Plugin 'mg979/vim-visual-multi'

" Use <Tab> for insert completion
" Plugin 'ervandew/supertab'

" Keyword completion (requires lua)
" Plugin 'Shougo/neocomplete.vim'

if _curfile =~ ".*\.csv"
  " CSV Viewer
  Plugin 'chrisbra/csv.vim'
endif

if _curfile =~ ".*\.jsx?"
  " ESLint
  " Plugin 'vim-syntastic/syntastic'

  " Javascript highlighter
  Plugin 'jelera/vim-javascript-syntax'
  " Plugin 'pangloss/vim-javascript'
  Plugin 'othree/javascript-libraries-syntax.vim'
  Plugin 'mxw/vim-jsx' " JSX indentation
endif

if _curfile =~ ".*\.jsx"
  " React Snippets
  " Plugin 'epilande/vim-react-snippets'
endif

if _curfile =~ ".*\.html"
  " HTML Autocomplete/Syntax
  Plugin 'othree/html5.vim'
  Plugin 'othree/html5-syntax.vim'
endif

if _curfile =~ ".*\.s?css"
  " CSS Autocomplete
  Plugin 'groenewege/vim-less'
  Plugin 'Townk/vim-autoclose'
endif

" TypeScript Syntax
" Plugin 'leafgarland/typescript-vim'

" Mustache .hbs files syntax
" Plugin 'mustache/vim-mustache-handlebars'

filetype on
filetype plugin on
filetype indent on

syntax on
set number
set noswapfile " no swp file

" Indentation
set autoindent
set smartindent
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set list listchars=tab:»\ ,trail:°

" Word Wrap
set wrap
set nolist  " list disables linebreak
set textwidth=80
set wrapmargin=80

" Search
set hlsearch
set ignorecase
set smartcase
set incsearch

set ttimeoutlen=0
set backspace=indent,eol,start

" Monokai Color
colorscheme monokai

" Remove trailing whitespace
autocmd BufWritePre * %s/\s\+$//e

" Reload vimrc
" command Reload :so ~/.vimrc

"""""""""""""""""""""""""""""""
" Normal mode specific remaps "
"""""""""""""""""""""""""""""""
" Hot Key remaps
" Non-Mode specific rempas
nnoremap <C-q> <Nop>

" Normal mode specific remaps
" Repeat last used macro
nnoremap , @@

" Make paste pull from last yank
nnoremap p "0p
nnoremap P "0P
nnoremap <Leader>p p
nnoremap <Leader>P P

" Leader + k moves to folder of current file
nnoremap <Leader>k :Ex<CR>

" Tabs
" nnoremap } gt
" nnoremap { gT
nnoremap <Leader>n :tabnew<CR>
nnoremap <Leader>] gt
nnoremap <Leader>[ gT

nmap <Leader>cf :let @" = expand('%:t')<CR>


" Move normally between wrapped lines
nmap j gj
nmap k gk

" For Multiple Cursors
let g:VM_no_meta_mappings = 1
let g:VM_maps = {}
let g:VM_maps["Clear"]             = '<C-c>'
let g:VM_maps["Select All"]        = '<Leader>a'
let g:VM_maps["Visual All"]        = '<Leader>a'
let g:VM_maps["Align"]             = '<Leader>A'
let g:VM_maps["Add Cursor Down"]   = '<C-j>'
let g:VM_maps["Add Cursor Up"]     = '<C-k>'

"""""""""""""""""""""""""""""""
" Insert mode specific remaps "
"""""""""""""""""""""""""""""""
inoremap <C-4> <Esc>A
inoremap <C-6> <Esc>I
inoremap <C-s> <Esc>:w

"""""""""""""""""""""""""""""""
" Visual mode specific remaps "
"""""""""""""""""""""""""""""""
" Remap copy to <Leader-c>
vnoremap <Leader>c :w !pbcopy<CR><CR>
" indent lines and reselect visual group
vnoremap < <gv
vnoremap > >gv
" move lines up and down
" vnoremap <C-k> :m-2<CR>gv
vnoremap <C-j> :m '>+<CR>gv
vnoremap <C-k> :m '<-2<CR>gv

" cut into last yank
vnoremap x "0d

" Make paste pull from last yank
vnoremap p "0p
vnoremap P "0P
vnoremap <Leader>p p
vnoremap <Leader>P P

" Buffers
nnoremap <Leader>b :ls<CR>:b
nnoremap <Leader>l :ls<CR>:b<Space>
nnoremap <Leader>q :bd<CR>

" Remap Ctrl+c to ESC
nnoremap <C-c> <Esc>
inoremap <C-c> <Esc>
vnoremap <C-c> <Esc>

"""""""""""""""""""
" Window Commands "
"""""""""""""""""""

" Split navigation for Chromebook
" Ctrl-w defaults to close tab
nmap Kh :wincmd h<Enter>
nmap Kl :wincmd l<Enter>
nmap Kj :wincmd j<Enter>
nmap Kk :wincmd k<Enter>

" Remap C-s to split window vertically
" nnoremap <C-s> :vsplit<CR>
" nmap <C-s> :vsplit <Enter>

" Open new split panes to right and bottom, which feels more natural
set splitright
set splitbelow

" Quicker window movement
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-h> <C-w>h
" nnoremap <C-l> <C-w>l

nnoremap <C-w>n :vs<CR>
nnoremap <C-w>s :split<CR>
nnoremap <C-w><C-s> :split<CR>

" Faster window resizing
nnoremap \0 <C-w>=
nnoremap \= :vertical resize +4<CR>
nnoremap \- :vertical resize -4<CR>
nnoremap <Bar>+ :resize +4<CR>
nnoremap <Bar>_ :resize -4<CR>

" Line insert without insert mode
nnoremap <Leader>O O<Esc>
nnoremap <Leader>o o<Esc>

" Zoom / Restore window.
function! s:ZoomToggle() abort
" if exists('t:zoomed') && t:zoomed
    " execute t:zoom_winrestcmd
    " let t:zoomed = 0
" else
    " let t:zoom_winrestcmd = winrestcmd()
    " resize
    " vertical resize
    " let t:zoomed = 1
" endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <Leader>z :ZoomToggle<CR>

" Add to end of line
function! s:AddToEndOfLine(char)
" execute 's/'.a:char.'\?$/'.a:char.'/'
endfunction

command! -range -nargs=1 AddToEndOfLine <line1>,<line2>call s:AddToEndOfLine(<f-args>)
nnoremap <silent> <Leader>, :AddToEndOfLine<space>
vnoremap <silent> <Leader>, :AddToEndOfLine<space>

"""""""""""""""""""
" Plugin Settings "
"""""""""""""""""""

" Use rg for ctrl-p plugin
" if executable('rg')
  set grepprg=rg\ --hidden\ --color=never
  let g:ctrlp_use_caching = 0
  let g:ctrlp_user_command = 'rg --files --hidden --color=never * %s'
" endif

" Linter settings
" let g:ale_fixers = {
" \   'javascript': ['eslint'],
" \}
" command Fix :ALEFix<CR>
" cnoreabbrev ALEFix Fix
" command LintFix ALEFix
" cnoreabbrev <expr> ALEFix ((getcmdtype() is# ':' && getcmdline() is# 'ALEFix')?('LintFix'):('ALEFix'))

" Emmet Settings
let g:user_emmet_leader_key='<C-Z>'
let g:user_emmet_settings = {
\  'javascript' : {
\      'extends' : 'jsx',
\  },
\}

" JSX Highlighting
let g:xml_syntax_folding = 0
" Trigger configuration (Optional)
" let g:UltiSnipsExpandTrigger="<C-l>"

" Google csearch
" source /google/src/head/depot/google3/tools/gsearch/contrib/csearch.vim
" nnoremap <Leader>f :Csearch<space>
" nnoremap <Leader>s :Csearch <C-R><C-W><CR><CR>
" vnoremap <leader>s "ny:<c-u>Csearch "<c-r>=substitute(@n, '\n', '', '')<cr>"<cr>

" NERDCommenter remap
map <C-\> <Leader>c<space>
map <Leader>/ <Leader>c<space>

" NERDTree remap
if exists("b:NERDTree")
  nnoremap <Leader>k :NERDTreeToggle<CR>
  nnoremap <Leader>r :NERDTreeFind<CR>

  " NERDTree Settings "
  " show hidden files
  let NERDTreeShowHidden = 1
  " character shown before list items
  let g:NERDTreeNodeDelimiter = "\u00a0"
  " get rid of 'Press ? for help'
  let NERDTreeMinimalUI = 1
  let NERDTreeDirArrows = 1
  " close vim if NERDTree is last remaining window
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
endif

" NERDCommenter Settings "
" add space after comment character
let NERDSpaceDelims = 1

" YouCompleteMe
" if exists("b:YcmCompleter")
  let g:ycm_key_list_stop_completion = ['<C-y>', '<ENTER>', '<CR>']
  nnoremap <leader>jd :YcmCompleter GoTo<CR>
  nnoremap <leader>jr :YcmCompleter GoToReferences<CR>
  inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<CR>"
" endif

" Vim-Airline display buffers
let g:airline#extensions#tabline#enabled = 1

""" Customize Pmenu colors

hi Pmenu ctermbg=239 guibg=#4e4e4e
hi PmenuSel ctermbg=19 guibg=#0000af
" hi PmenuSbar ctermbg=#bcbcbc
" hi PmenuThumb ctermbg=15 guibg=White

" let $FZF_DEFAULT_COMMAND = 'rg
    " " " \ --files --hidden
" " \ -g "!*.{min.js,swp,o,zip}"
    " " " \ -g "!{.git,dist}/*" '

" command! -bang -nargs=? -complete=dir Files
" " \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" " nnoremap <C-p> :Files<CR>

" let g:rg_command_find_all = '
" " \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
" " \ -g "*.{js,json,php,md,styl,jade,html,css,config,py,cpp,c,go,hs,rb,conf}"
" " \ -g "!*.{min.js,swp,o,zip}"
" " \ -g "!{.git,node_modules,vendor,dist}/*" '

" command! -bang -nargs=* Rg
" " \ call fzf#vim#grep(g:rg_command_find_all .shellescape(<q-args>), 1,
" " \   <bang>0 ? fzf#vim#with_preview('up:60%')
" " \           : fzf#vim#with_preview('right:50%:hidden', '?'),
" " \   <bang>0)

" function! RipgrepFzf(query, fullscreen)
" " let command_fmt = 'rg --files --color=always --smart-case -- %s || true'
" " let initial_command = printf(command_fmt, shellescape(a:query))
" " let reload_command = printf(command_fmt, '{q}')
" " let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
" " call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
" endfunction

" command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" command! -bang -nargs=* FA call fzf#vim#grep(g:rg_command_find_all .shellescape(<q-args>), 1, <bang>0)
" nnoremap <Leader>f :Rg!<CR>

let g:fuf_keyOpen = "<C-l>"
let g:fuf_keyOpenTabpage = "<CR>"

" disable expandtab for makefiles
let _curfile = expand("%:t")
if _curfile =~ "Makefile" || _curfile =~ "makefile" || _curfile =~ ".*\.mk"
" " set noexpandtab
endif

" syntastic settings
" let g:used_javascript_libs = 'underscore,requirejs,react,ramda'
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" let g:syntastic_javascript_checkers = ['eslint']
" let g:syntastic_javascript_eslint_exe = 'npm run lint --'


" sublime like new lines
let delimitMate_expand_cr=1

" Other settings

" JavaScript Libraries
" let g:used_javascript_libs = 'jquery,underscore,angularjs,angularui,angularuirouter,react,flux,backbone,jasmine'

" TypeScript Indenting Disable
" let g:typescript_indent_disable = 1

" Handlebar Mustache_Abbreviations
" let g:mustache_abbreviations = 1

" Supertab
let g:SuperTabDefaultCompletionType= "<c-n>"

" Base-16 (Color)
"let base16colorspace=256

