set nocompatible
set rtp+=~/.dotfiles/.vim/bundle/vundle.vim
set rtp+=~/.dotfiles/.vim
let mapleader = ' '
call vundle#rc()

" If fzf installed using Homebrew
set rtp+=/usr/local/opt/fzf

" Vundles

" IDE
" Plugin 'xmementoit/vim-ide'

" File Structure
" File Tree structure
Plugin 'scrooloose/nerdtree'

" Fuzzy finder for vim
Plugin 'junegunn/fzf.vim'

" Ctrl+P
" Plugin 'ctrlpvim/ctrlp.vim'

" Better status line
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Show search results in window
Plugin 'rking/ag.vim'

" ESLint
" Plugin 'vim-syntastic/syntastic'

" Linter
Plugin 'w0rp/ale'

" L9 - Library
Plugin 'vim-scripts/l9'

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
runtime macros/matchit.vim

" Match Opening and Closing Symbols
Plugin 'valloric/MatchTagAlways'

" Drop line on enter (inside closing tags)
Plugin 'delimitMate.vim'

" Auto Formating
Plugin 'Chiel92/vim-autoformat'

" Surround text
Plugin 'tpope/vim-surround'

" For special replace functions
Plugin 'tpope/vim-abolish'

" Git support
Plugin 'tpope/vim-fugitive'
" Git Gutter
Plugin 'airblade/vim-gitgutter'
" Git NerdTree plugin
Plugin 'Xuyuanp/git-nerdtree'

" Multiple Cursors
Plugin 'terryma/vim-multiple-cursors'

" Use <Tab> for insert completion
Plugin 'ervandew/supertab'

" Keyword completion (requires lua)
Plugin 'Shougo/neocomplete.vim'

" CSV Viewer
Plugin 'chrisbra/csv.vim'

" Javascript highlighter
Plugin 'jelera/vim-javascript-syntax'
" Plugin 'pangloss/vim-javascript'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'mxw/vim-jsx' " JSX indentation

" React Snippets
Plugin 'epilande/vim-react-snippets'

" UltiSnips
Plugin 'SirVer/ultisnips'

" Commenting
Plugin 'scrooloose/nerdcommenter'

" HTML Autocomplete/Syntax
Plugin 'othree/html5.vim'
Plugin 'othree/html5-syntax.vim'

" CSS Autocomplete
Plugin 'groenewege/vim-less'
Plugin 'Townk/vim-autoclose'

" TypeScript Syntax
" Plugin 'leafgarland/typescript-vim'

" Mustache .hbs files syntax
Plugin 'mustache/vim-mustache-handlebars'

" Go Plugin
Plugin 'fatih/vim-go'

" Color Package
Plugin 'chriskempson/base16-vim'

filetype on
filetype plugin on
filetype indent on

syntax on
set number
set noswapfile " no swp file
" Indentation
set autoindent
set smartindent
" set noexpandtab
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

set wrap
set nolist  " list disables linebreak
set textwidth=80
set wrapmargin=80
set nohlsearch
set ignorecase
set smartcase
set incsearch

set ttimeoutlen=0

set backspace=indent,eol,start

" Monokai Color
colorscheme monokai

" Remove trailing whitespace
autocmd BufWritePre * %s/\s\+$//e

" Run GoFmt on save for go files
" au BufWritePost *.go !gofmt -w %

" Reload vimrc
" command Reload :so ~/.vimrc

" Hot Key remaps
" Normal mode specific remaps
" Repeat last used macro
nnoremap , @@
" Make paste pull from last yank
nnoremap p "0p
nnoremap P "0P
nnoremap <Leader>p p
nnoremap <Leader>P P
" Move normally between wrapped lines
nmap j gj
nmap k gk

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

" Buffers
nnoremap <Leader>b :ls<CR>:b
nnoremap <Leader>l :ls<CR>:b<Space>

" Tabs
nnoremap } gt
nnoremap { gT
nnoremap <Leader>n :tabnew<CR>
nnoremap <Leader>] gt
nnoremap <Leader>[ gT

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
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

nnoremap <C-w>n :vs<CR>
nnoremap <C-w>s :split<CR>
nnoremap <C-w><C-s> :split<CR>

" Faster window resizing
nnoremap <Leader>0 <C-w>=
nnoremap <Leader>= :vertical resize +4<CR>
nnoremap <Leader>- :vertical resize -4<CR>
nnoremap <Leader>+ :resize +4<CR>
nnoremap <Leader>_ :resize -4<CR>

" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <Leader>z :ZoomToggle<CR>

" Add to end of line
function! s:AddToEndOfLine(char)
  execute 's/'.a:char.'\?$/'.a:char.'/'
endfunction

command! -range -nargs=1 AddToEndOfLine <line1>,<line2>call s:AddToEndOfLine(<f-args>)
nnoremap <silent> <Leader>, :AddToEndOfLine<space>
vnoremap <silent> <Leader>, :AddToEndOfLine<space>



"""""""""""""""""""
" Plugin Settings "
"""""""""""""""""""

" Line insert without insert mode
nnoremap <Leader>O O<Esc>
nnoremap <Leader>o o<Esc>

" Linter settings
let g:ale_fixers = {
\   'javascript': ['eslint'],
\}
" command Fix :ALEFix<CR>
" cnoreabbrev ALEFix Fix
command LintFix ALEFix
cnoreabbrev <expr> ALEFix ((getcmdtype() is# ':' && getcmdline() is# 'ALEFix')?('LintFix'):('ALEFix'))

" Emmet Settings
let g:user_emmet_settings = {
\  'javascript' : {
\      'extends' : 'jsx',
\  },
\}

" JSX Highlighting
let g:xml_syntax_folding = 0
" Trigger configuration (Optional)
let g:UltiSnipsExpandTrigger="<C-l>"

" NERDCommenter remap
map <C-\> <Leader>c<space>
map <Leader>/ <Leader>c<space>

" NERDTree remap
nnoremap <Leader>k :NERDTreeToggle<CR>
nnoremap <Leader>r :NERDTreeFind<CR>

" NERDTree Settings "
" show hidden files
let NERDTreeShowHidden=1
" character shown before list items
let g:NERDTreeNodeDelimiter = "\u00a0"
" get rid of 'Press ? for help'
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
" close vim if NERDTree is last remaining window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" NERDCommenter Settings "
" add space after comment character
let NERDSpaceDelims=1

" Vim-Airline display buffers
let g:airline#extensions#tabline#enabled=1

let $FZF_DEFAULT_COMMAND = 'rg
	\ --files --hidden
  \ -g "!*.{min.js,swp,o,zip}"
	\ -g "!{.git,dist}/*" '

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

nnoremap <C-p> :Files<CR>

" if executable('ag')
	" " Use ag over grep
	" set grepprg=ag\ --nogroup\ --nocolor

  " " " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
	" let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " " " ag is fast enough that CtrlP doesn't need to cache
	" let g:ctrlp_use_caching = 0

	" command! -bang -nargs=* Ag
		" \ call ag#vim#files(<q-args>,
		" \                 <bang>0 ? fzf#vim#with_preview('up:60%')
		" \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
		" \                 <bang>0)

	" " set #FZF_DEFAULT_COMMAND = 'ag --nogroup --nocolor --column'

	" nnoremap <C-p> :Ag<CR>

	" nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
" endif

let g:rg_command_find_all = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  \ -g "*.{js,json,php,md,styl,jade,html,css,config,py,cpp,c,go,hs,rb,conf}"
  \ -g "!*.{min.js,swp,o,zip}"
  \ -g "!{.git,node_modules,vendor,dist}/*" '

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(g:rg_command_find_all .shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --files --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

command! -bang -nargs=* FA call fzf#vim#grep(g:rg_command_find_all .shellescape(<q-args>), 1, <bang>0)
nnoremap <Leader>f :Rg!<CR>

let g:fuf_keyOpen = "<C-l>"
let g:fuf_keyOpenTabpage = "<CR>"

" disable expandtab for makefiles
let _curfile = expand("%:t")
if _curfile =~ "Makefile" || _curfile =~ "makefile" || _curfile =~ ".*\.mk"
    set noexpandtab
endif

" syntastic settings
let g:used_javascript_libs = 'underscore,requirejs,react,ramda'
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
let g:used_javascript_libs = 'jquery,underscore,angularjs,angularui,angularuirouter,react,flux,backbone,jasmine'

" TypeScript Indenting Disable
" let g:typescript_indent_disable = 1

" Handlebar Mustache_Abbreviations
let g:mustache_abbreviations = 1

" Supertab
let g:SuperTabDefaultCompletionType= "<c-n>"

" Base-16 (Color)
"let base16colorspace=256

