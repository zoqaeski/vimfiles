"              __                            
"      __  __ /\_\    ___ ___   _ __   ___   
"     /\ \/\ \\/\ \ /' __` __`\/\`'__\/'___\ 
"   __\ \ \_/ |\ \ \/\ \/\ \/\ \ \ \//\ \__/ 
"  /\_\\ \___/  \ \_\ \_\ \_\ \_\ \_\\ \____\
"  \/_/ \/__/    \/_/\/_/\/_/\/_/\/_/ \/____/
"                                            
"                                            
" Author: Robbie Smith
" repo  : https://github.com/zoqaeski/vimfiles
"
" Somewhat inspired by the bling.vim distribution at
" https://github.com/bling/dotvim
" I removed a lot of the stuff I didn't want though.
"
""""""""""""""""""""""""""""""""""""""""


" OS detection =============================================================={{{
let s:is_windows = has('win32') || has('win64')
let s:is_cygwin = has('win32unix')
let s:is_macvim = has('gui_macvim')
let g:vimHome = '~/.config/nvim' " All Configuration lies here
let g:vimLocal = '~/.local/share/nvim' " Local data
"}}}


" Setup ====================================================================={{{

if has('vim_starting')
	if &compatible
		set nocompatible
	endif

	" Reset ALL THE THINGS!!!!
	set all& 

	if s:is_windows
		set runtimepath+=~/.vim
	endif
endif

" Clear vimrc autogroup so the rest of the file can add to it
augroup vimrc
	au!
augroup END

" Set the map leader before loading bundles
let mapleader = '\'
let maplocalleader = '\'

" Key mapping helpers -------------------------------------------------------{{{

" These mappings allow plugins to "wrap" a key binding.
"
" The <Plug>(vimrc#key_base:KEY) mappings stand for the raw action
" itself. Any remappings of these mean the plugin needs to replace the action.
" For example, delimitMate will replace e.g. <Plug>(vimrc#key_base:<CR>)
" because it needs to replace the <CR> action.
"
" The <Plug>(vimrc#key:KEY) mappings are meant for plugins that want to
" conditionally perform the base action. For example, neocomplete will use
" these mappings to change behavior in some cases.
"
" A third mapping <Plug>(vimrc#key_raw:KEY) mapping is defined that types
" the given key without mappings. This can be used from base mappings.
"
" Note: By default, <BS> is imapped to <Plug>(vimrc#key:<C-h>) so plugins
" only have to remap <C-h> instead of <BS>. <Plug>(vimrc#key:<BS>) and
" <Plug>(vimrc#key_base:<BS>) still exist but are not mapped by anything.
"
" Note: We use two layers of <Plug>(vimrc#* mappings instead of just letting
" the key itself be the "filter" mapping so plugins that check whether a given
" key is mapped (such as delimitMate) will properly avoid setting a mapping on
" the key. Similarly, this is set up here before bundles are loaded to ensure
" the mappings exist.

function! s:setupMappingHelper(name)
	exe printf("inoremap <silent> <Plug>(vimrc#key_base:%s) %s", a:name, a:name)
	exe printf("inoremap <silent> <Plug>(vimrc#key_raw:%s) %s", a:name, a:name)
	exe printf("imap <silent> <Plug>(vimrc#key:%s) <Plug>(vimrc#key_base:%s)", a:name, a:name)
	exe printf("imap <silent> %s <Plug>(vimrc#key:%s)", a:name, a:name)
endfunction

call s:setupMappingHelper("<CR>")
call s:setupMappingHelper("<C-h>")
call s:setupMappingHelper("<BS>")
imap <silent> <BS> <Plug>(vimrc#key:<C-h>)
call s:setupMappingHelper("<S-BS>")
call s:setupMappingHelper("<Space>")
call s:setupMappingHelper("<Tab>")
call s:setupMappingHelper("<S-Tab>")
call s:setupMappingHelper("<C-n>")
call s:setupMappingHelper("<C-p>")
call s:setupMappingHelper("'")
call s:setupMappingHelper("<C-l>")
"}}}

" Reset the colorscheme now to avoid errors when reloading vimrc.
unlet! g:colors_name
" Turn on syntax now to ensure any appropriate autocommands run after the
" syntax file has loaded.
syntax on

" }}}


" Plugins ==================================================================={{{

call plug#begin()

" Core Plugins --------------------------------------------------------------{{{

Plug 'Shougo/vimproc', {
			\ 'build' : {
			\     'windows' : 'tools\\update-dll-mingw',
			\     'cygwin' : 'make -f make_cygwin.mak',
			\     'mac' : 'make -f make_mac.mak',
			\     'linux' : 'make',
			\     'unix' : 'gmake',
			\    },
			\ }
"}}}

" Editing plugins -----------------------------------------------------------{{{

"Plug 'terryma/vim-expand-region'
"Plug 'terryma/vim-multiple-cursors'
Plug 'tomtom/tcomment_vim'
Plug 'godlygeek/tabular' 

Plug 'vim-scripts/YankRing.vim'
		let g:yankring_max_history = 100
		let g:yankring_max_display = 200
		let g:yankring_min_element_length = 1
		let g:yankring_ignore_operator = 'g~ gu gU ! = gq g? > < zf g@'
		let g:yankring_history_dir = g:vimLocal
		let g:yankring_history_file = 'yankring_history'
		let g:yankring_replace_n_pkey = '<M-p>'
		let g:yankring_replace_n_nkey = '<M-n>'
		nnoremap Y :<C-U>YRYankCount 'y$'<CR>
		noremap <Leader>y :YRShow<CR>
"}}}

" SCM (git, hg, etc) plugins ------------------------------------------------{{{

Plug 'tpope/vim-fugitive', { 'augroup' : 'fugitive'}
		nnoremap <silent> <leader>gs :Gstatus<CR>
		nnoremap <silent> <leader>gd :Gdiff<CR>
		nnoremap <silent> <leader>gc :Gcommit<CR>
		nnoremap <silent> <leader>gb :Gblame<CR>
		nnoremap <silent> <leader>gl :Glog<CR>
		nnoremap <silent> <leader>gp :Git push<CR>
		nnoremap <silent> <leader>gw :Gwrite<CR>
		nnoremap <silent> <leader>gr :Gremove<CR>
		autocmd FileType gitcommit nmap <buffer> U :Git checkout -- <C-r><C-g><CR>
		autocmd BufReadPost fugitive://* set bufhidden=delete

"}}}

" Navigation plugins --------------------------------------------------------{{{

Plug 'mileszs/ack.vim' 
		let g:ackprg = 'ag --nogroup --nocolor --column'
"}}}

" NERDTree ------------------------------------------------------------------{{{

Plug 'scrooloose/nerdtree', { 'on' : 'NERDTreeToggle', 'augroup' : 'NERDTreeHijackNetrw' }
		map <C-\><C-t> :NERDTreeToggle<CR>
		"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
		let NERDTreeShowHidden=1
		let g:NERDTreeWinSize=45
		let g:NERDTreeAutoDeleteBuffer=1

		"NERDTree File highlighting
		function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
			exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
			exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
		endfunction
"}}}

"" Completion plugins -------------------------------------------------------{{{

Plug 'mattn/emmet-vim'
		let g:user_emmet_mode='a'

""}}}

" Web Plugins ---------------------------------------------------------------{{{
" -nil-
" }}}

" Python Plugins ------------------------------------------------------------{{{
"Plug 'klen/python-mode', {'autoload':{'filetypes':['python']}}
"let g:pymode_rope=0
"}}}

" Haskell Plugins -----------------------------------------------------------{{{
Plug 'dag/vim2hs', { 'for' : 'haskell' }
Plug 'lukerandall/haskellmode-vim', { 'for' : 'haskell' }
Plug 'eagletmt/ghcmod-vim', { 'for' : 'haskell' }
Plug 'eagletmt/neco-ghc', { 'for' : 'haskell' }
"Plug 'travitch/hasksyn', { 'for' : 'haskell' }
"}}}

" LaTeX plugins -------------------------------------------------------------{{{
Plug 'LaTeX-Box-Team/LaTeX-Box', {'for' : ['tex']}
		let g:LatexBox_latexmk_async = 1
		let g:LatexBox_latexmk_preview_continuously = 1
		let g:LatexBox_quickfix = 2
		let g:LatexBox_show_warnings = 0
		let g:LatexBox_Folding = 1
		let g:tex_flavor = 'latex'
		let g:tex_gotoerror = 0
		" Mappings
		imap <buffer> [[     \begin{
		imap <buffer> ]]     <Plug>LatexCloseCurEnv
		nmap <buffer> <F5>   <Plug>LatexChangeEnv
		vmap <buffer> <F7>   <Plug>LatexWrapSelection
		vmap <buffer> <S-F7> <Plug>LatexEnvWrapSelection
		imap <buffer> ((     \eqref{
" Plug 'lervag/vimtex', {'for' : ['tex', 'latex']}
" 		let g:tex_flavor = 'latex'
"     let g:vimtex_format_enabled = 0
"     let g:vimtex_fold_enabled = 1
"     let g:vimtex_latexmk_background = 1
" 		let g:vimtex_view_method = 'general'
"Plug 'git://vim-latex.git.sourceforge.net/gitroot/vim-latex/vim-latex'
"}}}

" Other plugins -------------------------------------------------------------{{{
Plug 'matchit.zip'
Plug 'tpope/vim-surround'
		augroup latexSurround
			autocmd!
			autocmd FileType tex call s:latexSurround()
		augroup END

		function! s:latexSurround()
			let b:surround_{char2nr("e")}
						\ = "\\begin{\1environment: \1}\n\t\r\n\\end{\1\1}"
			let b:surround_{char2nr("c")} = "\\\1command: \1{\r}"
		endfunction
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-unimpaired'
"Plug 'wincent/terminus'
Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
Plug 'junegunn/fzf.vim'
		let g:fzf_action = {
					\ 'ctrl-t': 'tab split',
					\ 'ctrl-i': 'split',
					\ 'ctrl-v': 'vsplit'}

		" Jump to existing window if possible
		let g:fzf_buffers_jump = 1


		nmap <space> [fzf]
		nnoremap [fzf] <nop>
		nnoremap <silent> [fzf]<space> :FZF<cr>
		nnoremap <silent> [fzf]f :Files ~<cr>
		nnoremap <silent> [fzf]d :FZF -m %:p:h<cr>
		nnoremap <silent> [fzf]b :Buffers<cr>
		nnoremap <silent> [fzf]h :History<cr>
		nnoremap <silent> [fzf]l :Lines<cr>

		nmap <leader><tab> <plug>(fzf-maps-n)
		xmap <leader><tab> <plug>(fzf-maps-x)
		omap <leader><tab> <plug>(fzf-maps-o)

		imap <C-x><C-l> <plug>(fzf-complete-line)
		imap <c-x><c-k> <plug>(fzf-complete-word)


"Plug 'ashisha/image.vim', { 'disabled' : !has('python') }
Plug 'mhinz/vim-sayonara'
		nnoremap <silent> Q :Sayonara<CR>
Plug 'gorodinskiy/vim-coloresque'
Plug 'chriskempson/base16-vim'
Plug 'mattn/gist-vim', {'depends': 'mattn/webapi-vim'}

" This plugin isn't needed because I've done the necessary mappings in my
" tmux.conf
" Plug 'christoomey/vim-tmux-navigator', { 'disabled' : 1 }
" 		let g:tmux_navigator_no_mappings = 1
" 		nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
" 		nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
" 		nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
" 		nnoremap <silent> <C-h> :TmuxNavigateLeft<CR>
" 		nnoremap <silent> <C-;> :TmuxNavigatePrevious<cr>
" 		tmap <C-j> <C-\><C-n>:TmuxNavigateDown<cr>
" 		tmap <C-k> <C-\><C-n>:TmuxNavigateUp<cr>
" 		tmap <C-l> <C-\><C-n>:TmuxNavigateRight<cr>
" 		tmap <C-h> <C-\><C-n>:TmuxNavigateLeft<CR>
" 		tmap <C-;> <C-\><C-n>:TmuxNavigatePrevious<cr>
Plug 'tmux-plugins/vim-tmux'

Plug 'xolox/vim-session'
		set sessionoptions=blank,buffers,curdir,folds,resize,tabpages,winpos,winsize
		let g:session_autosave = 'yes'
		let g:session_autoload = 'no'
		let g:session_command_aliases = 1

Plug 'xolox/vim-misc'
Plug 'tpope/vim-markdown', { 'for' : 'markdown' }
"Plug 'scrooloose/syntastic' 
"let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': [], 'passive_filetypes': [] }
"let g:syntastic_quiet_warnings=1
"Plug 'xolox/vim-notes'
"let g:notes_directories = ['~/documents/notes', '~/documents/work']
"let g:notes_suffix = '.txt'
"Plug 'tpope/vim-abolish'
"Plug 'tpope/vim-haml'
"Plug 'tpope/vim-ragtag'
"}}}

call plug#end()
"}}}


" Functions ================================================================={{{

function! EnsureExists(path)
	if !isdirectory(expand(a:path))
		call mkdir(expand(a:path))
	endif
endfunction

function! Cwd()
	let cwd = getcwd()
	return "e " . cwd 
endfunction

function! CurrentFileDir(cmd)
	return a:cmd . " " . expand("%:p:h") . "/"
endfunction

function! CmdLine(str)
	exe "menu Foo.Bar :" . a:str
	emenu Foo.Bar
	unmenu Foo
endfunction

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

" function! CloseWindowOrKillBuffer()
" 	let number_of_windows_to_this_buffer = len(filter(range(1, winnr('$')), "winbufnr(v:val) == bufnr('%')"))
"
" 	" never bdelete a nerd tree
" 	if matchstr(expand("%"), 'NERD') == 'NERD'
" 		wincmd c
" 		return
" 	endif
"
" 	if number_of_windows_to_this_buffer > 1
" 		wincmd c
" 	else
" 		bdelete
" 	endif
" endfunction

" Creates a temporary working buffer
function! ScratchEdit(cmd, options) "{{{
	exe a:cmd tempname()
	setl buftype=nofile bufhidden=wipe nobuflisted
	if !empty(a:options) | exe 'setl' a:options | endif
endfunction "}}}

" Identifies the syntax colouring item under the cursor
function! <SID>SynStack()
	if !exists("*synstack")
		return
	endif
	echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

"function! ToggleVExplorer() "{{{
"	if exists("t:expl_buf_num")
"		let expl_win_num = bufwinnr(t:expl_buf_num)
"		if expl_win_num != -1
"			let cur_win_nr = winnr()
"			exec expl_win_num . 'wincmd w'
"			close
"			exec cur_win_nr . 'wincmd w'
"			unlet t:expl_buf_num
"		else
"			unlet t:expl_buf_num
"		endif
"	else
"		exec '1wincmd w'
"		Vexplore
"		let t:expl_buf_num = bufnr("%")
"	endif
"endfunction "}}}
" }}}


" Basic Configuration ======================================================={{{

set timeoutlen=1500                              " mapping timeout
set ttimeoutlen=-1                               " keycode timeout

set mouse=a                                      " enable mouse
set mousehide                                    " hide when characters are typed
set history=1000                                 " number of command lines to remember
set viewoptions=folds,options,cursor,unix,slash  " unix/windows compatibility
"set encoding=utf-8                              " set encoding for text
set hidden                                       " allow buffer switching without saving
set autoread                                     " auto reload if file saved externally
set fileformats+=unix,dos,mac                    " add mac to auto-detection of file format line endings
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
set backspace=indent,eol,start                   " allow backspacing everything in insert mode
set autoindent                                   " automatically indent to match adjacent lines
set smartindent                                  
set noexpandtab                                  " spaces instead of tabs
set smarttab                                     " use shiftwidth to enter tabs
set tabstop=4                                    " number of spaces per tab for display
set softtabstop=4                                " number of spaces per tab in insert mode
set shiftwidth=4                                 " number of spaces when indenting
set nolist                                       " highlight whitespace
set listchars=tab:>-,trail:·,eol:$               
set shiftround                                   
set linebreak                                    
let &showbreak='↪ '                              
set nowrap                                       
set textwidth=0                                  

set scrolloff=5                                  " always show content after scroll
set scrolljump=5                                 " minimum number of lines to scroll
set sidescrolloff=10                             " minimum number of characters to show left-right
set display+=lastline                            
set wildmenu                                     " show list for autocomplete
set wildmode=list:longest,full
set wildignorecase
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out                      " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
" set wildignore+=*.sw?                            " Vim swap files - no
" longer ignoring these as it could be useful for recovery
set wildignore+=.DS_Store                        " OS X
set wildignore+=*.luac                           " Lua byte code
set wildignore+=*.pyc                            " Python byte code

set splitbelow
set splitright

" disable sounds
set noerrorbells
set novisualbell

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

if exists('+shada')
	set shada='100,f1,<50,:100,s100
endif

if executable('ag')
	set grepprg=ag\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow
	set grepformat=%f:%l:%c:%m
elseif executable('ack')
	set grepprg=ack\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow\ $*
	set grepformat=%f:%l:%c:%m
endif
" }}}


" Files, Backups and Undo ==================================================={{{

" persistent undo
if exists('+undofile')
	exec "set undodir=".g:vimLocal."/undo/"
	set noundofile
	set undolevels=1000
	set undoreload=10000
	au BufWritePre /tmp/* setlocal noundofile
endif

" Turn Backup off: reduces clutter
if exists('+backup')
	exec "set backupdir=".g:vimLocal."/backup/"
	set nobackup
	set writebackup
	set backupskip+=/tmp
	set backupskip+=/private/tmp " OS X /tmp
	" Skip backups of Git files
	set backupskip+=*.git/COMMIT_EDITMSG,*.git/MERGE_MSG,*.git/TAG_EDITMSG
	set backupskip+=*.git/modules/*/COMMIT_EDITMSG,*.git/modules/*/MERGE_MSG
	set backupskip+=*.git/modules/*/TAG_EDITMSG,git-rebase-todo
	" Skip backups of SVN commit files
	set backupskip+=svn-commit*.tmp
	au BufWritePre * let &bex = '-' . strftime("%Y%m%d-%H%M%S") . '.vimbackup'
endif

" Swap file
set swapfile
exec "set dir=".g:vimLocal."/swap/"

" Write swap file to disk after every 50 characters
set updatecount=50

call EnsureExists(g:vimLocal)
call EnsureExists(&undodir)
call EnsureExists(&backupdir)
call EnsureExists(&directory)
"}}}


" User Interface configuration =============================================={{{

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
set showmatch                                       "automatically highlight matching braces/brackets/etc.
set matchtime=2                                     "tens of a second to show matching parentheses
set relativenumber number
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
set background=dark
let base16colorspace=256
colorscheme base16-twilight

" This breaks things!
"if has('gui_running') 
"	source ~/.gvimrc
"endif

if has('cmdline_info')
	" Show the ruler
	set ruler
	" a ruler on steroids
	set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
	" Show partial commands in status line and selected characters/lines in visual mode
	set showcmd
endif


" Status Line ---------------------------------------------------------------{{{

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


" Additional Settings ======================================================={{{

" Hit enter in the file browser to open the selected
" file with :vsplit to the right of the browser.
let g:netrw_browse_split = 4
let g:netrw_altv = 1

" Default to tree mode
let g:netrw_liststyle=3

" No place holders for
let g:Imap_UsePlaceHolders=0

" XML default to XHTML
let xml_use_xhtml = 1
"}}}


" Key mappings =============================================================={{{
"
" This section is only used for key mappings that aren't associated with
" plugin functions.
"

" Unset last search pattern
nnoremap <CR> :noh<CR><CR>
" change cursor position in insert mode
inoremap <C-h> <left>
inoremap <C-l> <right>

" Tab stuff
imap <S-Tab> <C-o><<

" Syntax highlight checking
nnoremap <leader>e :call <SID>SynStack()<CR>

" Folding -------------------------------------------------------------------{{{
nnoremap zr zr:echo &foldlevel<CR>
nnoremap zm zm:echo &foldlevel<CR>
nnoremap zR zR:echo &foldlevel<CR>
nnoremap zM zM:echo &foldlevel<CR>
" }}}

" Sane regex. Always be very magic ------------------------------------------{{{
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v
nnoremap :s/ :s/\v
" }}}

" Command-line mappings -----------------------------------------------------{{{
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

" Insert-mode mappings ------------------------------------------------------{{{

" Emacs mode in Insert? HERESY!!!
" inoremap <C-A> <Home>
" inoremap <C-E> <End>
" inoremap <C-K> <C-U>
" inoremap <C-b> <Left>
" inoremap <C-f> <Right>

" }}}

" Visual mode mappings ------------------------------------------------------{{{

" reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSearch('gv')<CR>
map <Leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

" Exit Visual Mode with q
vnoremap <silent> q <ESC>

" Select last thing pasted
nnoremap gV `[v`]

" Select last thing pasted
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
"}}}

" Shortcuts for windows -----------------------------------------------------{{{
if has('nvim')
	" tnoremap <esc> <C-\><C-n><esc>
	tnoremap <A-h> <C-\><C-n><C-w>h
	tnoremap <A-j> <C-\><C-n><C-w>j
	tnoremap <A-k> <C-\><C-n><C-w>k
	tnoremap <A-l> <C-\><C-n><C-w>l
	nnoremap <A-h> <C-w>h
	nnoremap <A-j> <C-w>j
	nnoremap <A-k> <C-w>k
	nnoremap <A-l> <C-w>l
else
	nnoremap <C-h> <C-w>h
	nnoremap <C-j> <C-w>j
	nnoremap <C-k> <C-w>k
	nnoremap <C-l> <C-w>l
endif
"}}}

" Tab mappings --------------------------------------------------------------{{{
nnoremap <Leader>tn :tabnew<CR>
nnoremap <Leader>te :tabedit
nnoremap <Leader>tc :tabclose<CR>
nnoremap <Leader>tm :tabmove
nnoremap <Leader>tM :tabmove<CR>
nnoremap <Leader>> :tabmove +1<CR>
nnoremap <Leader>< :tabmove -1<CR>
nnoremap <C-Tab> :tabnext<CR>
nnoremap <C-S-Tab> :tabprevious<CR>
"}}}

" Buffer mappings -----------------------------------------------------------{{{
nnoremap <Leader>bc :close<CR>
nnoremap <Leader>bd :bdelete<CR>
nnoremap <Leader>bo :only<CR>
" Switch between buffers quickly
nnoremap gb :bnext<CR>
nnoremap gB :bprevious<CR>
nnoremap <Leader>bl :ls<CR>:e #
" window killer
" nnoremap <silent> Q :call CloseWindowOrKillBuffer()<CR>
"}}}

" }}}


" Useful Commands ==========================================================={{{

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

"autocmd FileType js,scss,css autocmd BufWritePre <buffer> call StripTrailingWhitespace()
autocmd FileType css,scss setlocal foldmethod=marker foldmarker={,}
autocmd FileType css,scss nnoremap <silent> <leader>S vi{:sort<CR>
"}}}
"}}}


" Plugin Extra Settings ====================================================={{{
"}}}

" vim: ft=vim fdm=marker ts=2 sts=2 sw=2 fdl=0 :
