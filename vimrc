"   /|||        /||||                                                              
"   ||||        |/|||                                                              
"   |/|||       /|||   /|||                                                       
"    |/|||     /|||   |///     /|||||  /|||||    /||/|||||||    /|||||||     
"     |/|||   /|||     /|||  /|||///|||||///||| |/|||/////|||  /|||//// 
"      |/||| /|||     |/||| |/||| |//|||  |/||| |/|||   |///  |/|||        
"       |/||||||      |/||| |/|||  |/|||  |/||| |/|||         |/|||        
"        |/||||       |/||| |/|||  |/|||  |/||| |/|||          |/|||||||
"         |///        |///  |///   |///   |///  |///            |////// 
"
" Somewhat inspired by the bling.vim distribution at https://github.com/bling/dotvim
"
""""""""""""""""""""""""""""""""""""""""

" OS detection {{{
  let s:is_windows = has('win32') || has('win64')
  let s:is_cygwin = has('win32unix')
  let s:is_macvim = has('gui_macvim')
"let g:vimHome = strpart(&rtp, 0, stridx(&rtp, '/bundle'))
  let g:vimHome = "~/.vim/"
"}}}

" Setup {{{
set nocompatible
set all& "reset everything to their defaults
if s:is_windows
	set rtp+=~/.vim
endif
set rtp+=~/.vim/bundle/neobundle.vim
call neobundle#rc(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
filetype plugin indent on
" }}}

" Functions {{{
"""""""""""""""

function! EnsureExists(path) "{{{
	if !isdirectory(expand(a:path))
		call mkdir(expand(a:path))
	endif
endfunction "}}}

function! Cwd() "{{{
  let cwd = getcwd()
  return "e " . cwd 
endfunction "}}}

function! CurrentFileDir(cmd) "{{{
  return a:cmd . " " . expand("%:p:h") . "/"
endfunction "}}}

function! CmdLine(str) "{{{
	exe "menu Foo.Bar :" . a:str
	emenu Foo.Bar
	unmenu Foo
endfunction "}}}

function! VisualSearch(direction) range "{{{		
	let l:saved_reg = @"
	execute "normal! vgvy"

	let l:pattern = escape(@", '\\/.*$^~[]')
	let l:pattern = substitute(l:pattern, "\n$", "", "")

	if a:direction == 'b'
		execute "normal ?" . l:pattern . "^M"
	elseif a:direction == 'gv'
		call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
	elseif a:direction == 'f'
		execute "normal /" . l:pattern . "^M"
	endif

	let @/ = l:pattern
	let @" = l:saved_reg
endfunction "}}}

" Buffer closing
command! BClose call <SID>BufCloseCloseIt()
function! <SID>BufCloseCloseIt() "{{{
	let l:currentBufNum = bufnr("%")
	let l:alternateBufNum = bufnr("#")

	if buflisted(l:alternateBufNum)
		buffer #
	else
		bnext
	endif

	if bufnr("%") == l:currentBufNum
		new
	endif

	if buflisted(l:currentBufNum)
		execute("bdelete! ".l:currentBufNum)
	endif
endfunction "}}}

function! CloseWindowOrKillBuffer() "{{{
	let number_of_windows_to_this_buffer = len(filter(range(1, winnr('$')), "winbufnr(v:val) == bufnr('%')"))

	" never bdelete a nerd tree
	if matchstr(expand("%"), 'NERD') == 'NERD'
		wincmd c
		return
	endif

	if number_of_windows_to_this_buffer > 1
		wincmd c
	else
		bdelete
	endif
endfunction "}}}

function! ScratchEdit(cmd, options) "{{{
	exe a:cmd tempname()
	setl buftype=nofile bufhidden=wipe nobuflisted
	if !empty(a:options) | exe 'setl' a:options | endif
endfunction "}}}
" }}}

" Basic Configuration {{{
set timeoutlen=1500                                              " mapping timeout
set ttimeoutlen=-1                                               " keycode timeout

set mouse=a                                                      " enable mouse
set mousehide                                                    " hide when characters are typed
set history=1000                                                 " number of command lines to remember
set ttyfast                                                      " assume fast terminal connection
set viewoptions=folds,options,cursor,unix,slash                  " unix/windows compatibility
set encoding=utf-8                                               " set encoding for text
set hidden                                                       " allow buffer switching without saving
set autoread                                                     " auto reload if file saved externally
set fileformats+=unix,dos,mac                                    " add mac to auto-detection of file format line endings
set nrformats=octal,hex,alpha
set showcmd
set tags=.git/tags,tags
set showfulltag
set modeline
set modelines=5
set magic
set switchbuf=usetab

" whitespace
set shiftround
set backspace=indent,eol,start                                   " allow backspacing everything in insert mode
set autoindent                                                   " automatically indent to match adjacent lines
set smartindent
set noexpandtab                                                  " spaces instead of tabs
set smarttab                                                     " use shiftwidth to enter tabs
set tabstop=4                                                    " number of spaces per tab for display
set softtabstop=4                                                " number of spaces per tab in insert mode
set shiftwidth=4                                                 " number of spaces when indenting
set nolist                                                         " highlight whitespace
set listchars=tab:>-,trail:·,eol:$
set shiftround
set linebreak
let &showbreak='↪ '
set nowrap
set textwidth=0

set scrolloff=5                                                  " always show content after scroll
set scrolljump=5                                                 " minimum number of lines to scroll
set sidescrolloff=10                                             " minimum number of characters to show left-right
set display+=lastline
set wildmenu                                                     " show list for autocomplete
set wildmode=list:longest,full
set wildignorecase
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.idea/*,*/.DS_Store

set splitbelow
set splitright

" disable sounds
set noerrorbells
set novisualbell
set t_vb=

" searching
set hlsearch                                                     " highlight searches
set incsearch                                                    " incremental searching
set ignorecase                                                   " ignore case for searching
set smartcase                                                    " do case-sensitive if there's a capital letter

" Remember things between sessions
" '20  - remember marks for 20 previous files
" \"50 - save 50 lines for each register
" :50  - remember 50 items in command-line history 
set viminfo='20,\"50,:50,/50

"if executable('ack')
"	set grepprg=ack\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow\ $*
"	set grepformat=%f:%l:%c:%m
"endif
if executable('ag')
	set grepprg=ag\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow
	set grepformat=%f:%l:%c:%m
endif
let mapleader = ","
let g:mapleader = ","
let maplocalleader = ","
let g:maplocalleader = ","
" }}}

" Files, Backups and Undo {{{
"""""""""""""""""""""""""""""
" persistent undo
if exists('+undofile')
	exec "set undodir=".g:vimHome."/.cache/undo/"
	set noundofile
	set undolevels=1000
	set undoreload=10000
	au BufWritePre /tmp/* setlocal noundofile
endif

" Turn Backup off: reduces clutter
set nobackup
set nowritebackup
exec "set backupdir=".g:vimHome."/.cache/backup/"
au BufWritePre * let &bex = '-' . strftime("%Y%m%d-%H%M%S") . '.vimbackup'

" Swap file
set swapfile
exec "set dir=".g:vimHome."/.cache/swap/"

" Write swap file to disk after every 50 characters
set updatecount=200

call EnsureExists('~/.vim/.cache')
call EnsureExists(&undodir)
call EnsureExists(&backupdir)
call EnsureExists(&directory)
"}}}

" User Interface configuration {{{
set showmatch                                       "automatically highlight matching braces/brackets/etc.
set matchtime=2                                     "tens of a second to show matching parentheses
set number
set lazyredraw
set laststatus=2
set showmode
set foldenable                                      "enable folds by default
set foldmethod=syntax                               "fold via syntax of files
set foldlevelstart=99                               "open all folds by default
let g:xml_syntax_folding=1                          "enable xml folding

" My own preferred colour scheme; I'm looking for a better one
let g:solarized_contrast="high"    "default value is normal

" Change background
"call togglebg#map("<F12>")
set background=dark
colorscheme zarniwoop

if has('gui_running') 
	source ~/.gvimrc
endif

if has('cmdline_info')
	" Show the ruler
	set ruler
	" a ruler on steroids
	set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
	" Show partial commands in status line and selected characters/lines in visual mode
	set showcmd
endif

" Status Line {{{
"""""""""""""""""
" always show a status line
set laststatus=2

" A SUPER STATUS LINE!!
set statusline=                             " Clears status line
set statusline+=\ %<                        " Separator, truncate
set statusline+=\ (%n)                      " Buffer
set statusline+=\ %f                        " File (relative path)
set statusline+=\ %M                        " Modified + -
set statusline+=\ %R%H%W                    " RO/HLP/PRV
set statusline+=\ %{fugitive#statusline()}  " Fugitive status line
set statusline+=\ %=                        " Separator left/right
set statusline+=\ [                         " Start group
set statusline+=%{strlen(&ft)?&ft:'none'}/  " File type
set statusline+=%{&fileformat}/             " File format
set statusline+=%{(&fenc==\"\"?&enc:&fenc)} " File encoding
set statusline+=]                           " End group
set statusline+=\ %l:%c%V                   " Line, column, virtual column
set statusline+=\ %P                        " Percentage
"}}}

set showtabline=2 " Always show tab line
set nocursorline " STOP UNDERLINING THE CURRENT LINE!!!

" Allow lots of tab pages -- 100 should be plenty
set tabpagemax=100
" Disable menu activation behaviour
set winaltkeys=no

" }}}

" Plugins {{{
" Core Plugins {{{
NeoBundle 'matchit.zip'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'tpope/vim-eunuch'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'Shougo/vimproc'
NeoBundle 'xolox/vim-misc'
"}}}

" Web Plugins {{{
" -nil-
" }}}

" Python Plugins {{{
NeoBundleLazy 'klen/python-mode', {'autoload':{'filetypes':['python']}}
let g:pymode_rope=0
"}}}

" Haskell Plugins {{{
NeoBundleLazy 'eagletmt/ghcmod-vim', {'autoload':{'filetypes':['haskell']}}
"}}}

" LaTeX plugins {{{
NeoBundle 'LaTeX-Box-Team/LaTeX-Box', {'autoload':{'filetypes':['tex']}}
let g:tex_flavor='latex'
let g:tex_gotoerror=0
"NeoBundle 'git://vim-latex.git.sourceforge.net/gitroot/vim-latex/vim-latex'
"}}}

" SCM (git, hg, etc) plugins {{{
NeoBundle 'tpope/vim-fugitive'
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
"nnoremap <silent> <leader>gc :Gcommit<CR>
"nnoremap <silent> <leader>gb :Gblame<CR>
"nnoremap <silent> <leader>gl :Glog<CR>
"nnoremap <silent> <leader>gp :Git push<CR>
"nnoremap <silent> <leader>gw :Gwrite<CR>
"nnoremap <silent> <leader>gr :Gremove<CR>
autocmd FileType gitcommit nmap <buffer> U :Git checkout -- <C-r><C-g><CR>
autocmd BufReadPost fugitive://* set bufhidden=delete
"NeoBundleLazy 'gregsexton/gitv', {'depends':['tpope/vim-fugitive'], 'autoload':{'commands':'Gitv'}}
"nnoremap <silent> <leader>gv :Gitv<CR>
"nnoremap <silent> <leader>gV :Gitv!<CR>
"}}}

" Completion plugins {{{
NeoBundle 'Shougo/neocomplete.vim'
let g:neocomplete#enable_at_startup = 0
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#max_list = 15

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "<C-n>" : "<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" Enable Omni Completion
augroup neocomplete_omni_complete
  autocmd!
  autocmd FileType css        setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html       setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType markdown   setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType xml        setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType python     setlocal omnifunc=pythoncomplete#Complete
augroup END

"" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
	let g:neocomplete#sources#omni#input_patterns = {}
endif

let g:neocomplete#sources#omni#input_patterns.tex = '\\\a\+'
let g:neocomplete#sources#buffer#max_keyword_width = 0
"}}}

" Editing plugins {{{
"NeoBundle 'terryma/vim-expand-region'
"NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'scrooloose/nerdcommenter'
"NeoBundle 'chrisbra/NrrwRgn'
NeoBundle 'godlygeek/tabular', {'autoload':{'commands':'Tabularize'}}
"NeoBundle 'junegunn/vim-easy-align'
"vmap <CR> <Plug>(EasyAlign)
NeoBundle 'xolox/vim-session'
set sessionoptions=blank,buffers,curdir,folds,resize,tabpages,winpos,winsize
let g:session_autosave = 'no'
let g:session_autoload = 'no'
let g:session_command_aliases = 1
NeoBundle 'vim-scripts/YankRing.vim'
let g:yankring_max_history = 100
let g:yankring_max_display = 200
let g:yankring_min_element_length = 1
let g:yankring_ignore_operator = 'g~ gu gU ! = gq g? > < zf g@'
let g:yankring_history_dir = g:vimHome
let g:yankring_history_file = 'yankring_history'
let g:yankring_replace_n_pkey = '<M-p>'
let g:yankring_replace_n_nkey = '<M-n>'
"noremap Y y$
nnoremap Y :<C-U>YRYankCount 'y$'<CR>
noremap <Leader>y :YRShow<CR>
"}}}

" Navigation plugins {{{
NeoBundleLazy 'scrooloose/nerdtree', {'autoload':{'commands':['NERDTreeToggle','NERDTreeFind']}}
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=0
let NERDTreeShowLineNumbers=1
let NERDTreeChDirMode=0
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.git','\.hg']
let NERDTreeBookmarksFile='~/.vim/.cache/NERDTreeBookmarks'
nnoremap <Leader>n :NERDTreeToggle<CR>
nnoremap <Leader>N :NERDTreeFind<CR>
NeoBundleLazy 'mileszs/ack.vim', {'autoload':{'commands':['Ack']}}
let g:ackprg = 'ag --nogroup --nocolor --column'
"}}}

" Unite plugins and settings {{{
NeoBundle 'Shougo/unite.vim'
let bundle = neobundle#get('unite.vim')
function! bundle.hooks.on_source(bundle)
	call unite#filters#matcher_default#use(['matcher_fuzzy'])
	call unite#filters#sorter_default#use(['sorter_rank'])
	call unite#set_profile('files', 'smartcase', 1)
	call unite#custom#source('line,outline','matchers','matcher_fuzzy')
endfunction

let g:unite_data_directory='~/.vim/.cache/unite'
let g:unite_enable_start_insert=0
let g:unite_source_history_yank_enable=1
let g:unite_source_rec_max_cache_files=5000
let g:unite_prompt='» '

if executable('ag')
	let g:unite_source_grep_command='ag'
	let g:unite_source_grep_default_opts='--nocolor --nogroup -S -C4'
	let g:unite_source_grep_recursive_opt=''
elseif executable('ack')
	let g:unite_source_grep_command='ack'
	let g:unite_source_grep_default_opts='--no-heading --no-color -a -C4'
	let g:unite_source_grep_recursive_opt=''
endif

function! s:unite_settings()
	nmap <buffer> Q <plug>(unite_exit)
	nmap <buffer> <esc> <plug>(unite_exit)
endfunction
autocmd FileType unite call s:unite_settings()

nmap <space> [unite]
nnoremap [unite] <nop>

nnoremap <silent> [unite]<space> :<C-u>Unite -no-split -start-insert -buffer-name=mixed file_rec/async:! buffer tab file_mru file bookmark<CR>
nnoremap <silent> [unite]f :<C-u>Unite -no-split -start-insert file file_rec/async:!<CR>
nnoremap <silent> [unite]b :<C-u>Unite -no-split -buffer-name=buffers buffer<CR>
nnoremap <silent> [unite]t :<C-u>Unite -no-split -buffer-name=tabs tab<CR>
nnoremap <silent> [unite]y :<C-u>Unite -buffer-name=yanks history/yank<CR>
nnoremap <silent> [unite]l :<C-u>Unite -buffer-name=line line<CR>
nnoremap <silent> [unite]/ :<C-u>Unite -no-split -start-insert -buffer-name=search grep:.<CR>
nnoremap <silent> [unite]m :<C-u>Unite -auto-resize -buffer-name=mappings mapping<CR>
"nnoremap <silent> [unite]s :<C-u>Unite -quick-match buffer<CR>
NeoBundleLazy 'Shougo/unite-outline', {'autoload':{'unite_sources':'outline'}}
nnoremap <silent> [unite]o :<C-u>Unite -auto-resize -buffer-name=outline outline<CR>
NeoBundleLazy 'Shougo/neomru.vim', {'autoload':{'unite_sources':'file_mru'}}
"}}}

" Other plugins {{{
NeoBundleLazy 'tpope/vim-markdown', {'autoload':{'filetypes':['markdown']}}
"NeoBundle 'scrooloose/syntastic' 
"let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': [], 'passive_filetypes': [] }
"let g:syntastic_quiet_warnings=1
NeoBundle 'xolox/vim-notes'
let g:notes_directories = ['~/documents/notes', '~/documents/work']
let g:notes_suffix = '.txt'
"NeoBundle 'altercation/vim-colors-solarized'
"}}}

"" tpope {{{
"NeoBundle 'tpope/vim-abolish'
"NeoBundle 'tpope/vim-haml'
"NeoBundle 'tpope/vim-ragtag'
""}}}

"}}}

" Key mappings {{{
" Unset last search pattern
nnoremap <CR> :noh<CR><CR>
" change cursor position in insert mode
inoremap <C-h> <left>
inoremap <C-l> <right>
" Tab stuff
imap <S-Tab> <C-o><<

" sane regex {{{
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v
nnoremap :s/ :s/\v
" }}}

" Command-line mappings {{{
nnoremap :: q:
nnoremap // q/
nnoremap ?? q?
" Emacs keys in command window
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-K> <C-U>
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>
" Shortcuts
cnoremap $h e ~/
cnoremap $c e <C-\>eCurrentFileDir("e")<CR>
nnoremap <Leader>cd :cd %:p:h<CR>
" }}}

" folds {{{
nnoremap zr zr:echo &foldlevel<CR>
nnoremap zm zm:echo &foldlevel<CR>
nnoremap zR zR:echo &foldlevel<CR>
nnoremap zM zM:echo &foldlevel<CR>
" }}}

" Visual mode mappings {{{
" reselect visual block after indent
vnoremap < <gv
vnoremap > >gv
"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSearch('gv')<CR>
map <Leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

" Select last thing pasted
nnoremap gV `[v`]

" Select last thing pasted
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
"}}}

" shortcuts for windows {{{
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
"}}}

" Tab commands {{{
nnoremap <Leader>tn :tabnew<CR>
nnoremap <Leader>te :tabedit
nnoremap <Leader>tc :tabclose<CR>
nnoremap <Leader>tm :tabmove
nnoremap <Leader>tM :tabmove<CR>
nnoremap <C-Tab> :tabnext<CR>
nnoremap <C-S-Tab> :tabprevious<CR>
"}}}

" Buffer commands {{{
nnoremap <Leader>bc :close<CR>
nnoremap <Leader>bd :bdelete<CR>
nnoremap <Leader>bo :only<CR>
" Switch between buffers quickly
nnoremap gb :bnext<CR>
nnoremap gB :bprevious<CR>
nnoremap <Leader>bl :ls<CR>:e #
" window killer
nnoremap <silent> Q :call CloseWindowOrKillBuffer()<CR>
"}}}

" }}}

" No place holders for
let g:Imap_UsePlaceHolders=0

" ++> XML
let xml_use_xhtml = 1

" Useful Commands {{{
"""""""""""""""""""""
" Diff original file
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
command! Clear norm gg"_dG
command! -bar -nargs=* Sedit call ScratchEdit('edit', <q-args>)
command! -bar -nargs=* Ssplit call ScratchEdit('split', <q-args>)
command! -bar -nargs=* Svsplit call ScratchEdit('vsplit', <q-args>)
command! -bar -nargs=* Stabedit call ScratchEdit('tabe', <q-args>)

" autocmd {{{
  " go back to previous position of cursor if any
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \  exe 'normal! g`"zvzz' |
    \ endif

  autocmd FileType js,scss,css autocmd BufWritePre <buffer> call StripTrailingWhitespace()
  autocmd FileType css,scss setlocal foldmethod=marker foldmarker={,}
  autocmd FileType css,scss nnoremap <silent> <leader>S vi{:sort<CR>
"}}}
"}}}


" Finish loading {{{
filetype plugin indent on
syntax enable
NeoBundleCheck
"}}}


" vim: ft=vim fdm=marker ts=2 sts=2 sw=2 fdl=0
