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
"}}}


" Setup ====================================================================={{{
" If neobundle is not installed, do it first
let bundleExists = 1
if (!isdirectory(expand(g:vimHome.'/bundle/neobundle.vim')))
	call mkdir(expand(g:vimHome."/bundle"))
	call system(expand("git clone https://github.com/Shougo/neobundle.vim ".g:vimHome."/bundle/neobundle.vim"))
	let bundleExists = 0
endif
if 0 | endif

if has('vim_starting')
	if &compatible
		set nocompatible
	endif

	" Reset ALL THE THINGS!!!!
	set all& 

	if s:is_windows
		set runtimepath+=~/.vim
	endif
	set runtimepath+=~/.config/nvim/bundle/neobundle.vim
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

call neobundle#begin(expand(g:vimHome.'/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

" Use neobundle standard recipes
NeoBundle 'Shougo/neobundle-vim-recipes', {'force' : 1}
" }}}


" Plugins ==================================================================={{{

" Core Plugins --------------------------------------------------------------{{{

NeoBundle 'Shougo/vimproc', {
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

"NeoBundle 'terryma/vim-expand-region'
"NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'godlygeek/tabular' 

NeoBundle 'vim-scripts/YankRing.vim'
if neobundle#tap('YankRing.vim')
	function! neobundle#hooks.on_source(bundle)
		let g:yankring_max_history = 100
		let g:yankring_max_display = 200
		let g:yankring_min_element_length = 1
		let g:yankring_ignore_operator = 'g~ gu gU ! = gq g? > < zf g@'
		let g:yankring_history_dir = g:vimHome
		let g:yankring_history_file = 'yankring_history'
		let g:yankring_replace_n_pkey = '<M-p>'
		let g:yankring_replace_n_nkey = '<M-n>'
		nnoremap Y :<C-U>YRYankCount 'y$'<CR>
		noremap <Leader>y :YRShow<CR>
	endfunction
	call neobundle#untap()
endif
"}}}

" SCM (git, hg, etc) plugins ------------------------------------------------{{{

NeoBundle 'tpope/vim-fugitive', { 'augroup' : 'fugitive'}
if neobundle#tap('vim-fugitive')
	function! neobundle#hooks.on_source(bundle)
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
	endfunction
	call neobundle#untap()
endif

"NeoBundleLazy 'gregsexton/gitv', {'depends':['tpope/vim-fugitive'], 'autoload':{'commands':'Gitv'}}
"nnoremap <silent> <leader>gv :Gitv<CR>
"nnoremap <silent> <leader>gV :Gitv!<CR>
"}}}

" Navigation plugins --------------------------------------------------------{{{

NeoBundleLazy 'mileszs/ack.vim' 
if neobundle#tap('ack.vim')
	function! neobundle#hooks.on_source(bundle)
		let g:ackprg = 'ag --nogroup --nocolor --column'
	endfunction
	call neobundle#untap()
endif
"}}}

" NERDTree ------------------------------------------------------------------{{{

NeoBundle 'scrooloose/nerdtree', { 'augroup' : 'NERDTreeHijackNetrw'}
if neobundle#tap('nerdtree')
	function! neobundle#hooks.on_source(bundle)
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
	endfunction
	call neobundle#untap()
endif
"}}}

" Unite plugins and settings ------------------------------------------------{{{

NeoBundle 'Shougo/unite.vim'
let bundle = neobundle#get('unite.vim')
function! bundle.hooks.on_source(bundle)
	call unite#filters#matcher_default#use(['matcher_fuzzy'])
	call unite#filters#sorter_default#use(['sorter_rank'])
	call unite#custom#profile('files', 'context.smartcase', 1)
	call unite#custom#source('line,outline','matchers','matcher_fuzzy')
endfunction

if neobundle#tap('unite.vim')
	function! neobundle#hooks.on_source(bundle)

		let g:unite_data_directory='~/.config/nvim/.cache/unite'
		let g:unite_enable_start_insert=0
		let g:unite_source_history_yank_enable=1
		let g:unite_source_rec_max_cache_files=5000
		let g:unite_prompt='» '

		" Unset unite grep arguments?
		" let g:unite_source_grep_default_opts=''
		" let g:unite_source_grep_recursive_opt=''
		if executable('ag')
			let g:unite_source_grep_command = 'ag'
			let g:unite_source_grep_default_opts =
						\ '-i --vimgrep --hidden --ignore ' .
						\ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
			let g:unite_source_grep_recursive_opt = ''
		elseif executable('ack')
			let g:unite_source_grep_command='ack'
			let g:unite_source_grep_default_opts='--no-heading --no-color -C4'
			let g:unite_source_grep_recursive_opt=''
		endif

		function! s:unite_settings()
			nmap <buffer> Q <plug>(unite_exit)
			nmap <buffer> <esc> <plug>(unite_exit)
			imap <silent><buffer><expr> <C-i> unite#do_action('split')
			imap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
		endfunction
		autocmd FileType unite call s:unite_settings()

		nmap <space> [unite]
		nnoremap [unite] <nop>

		if has('win32') || has('win64')
			nnoremap <silent> [unite]<space> :<C-u>Unite -resume -buffer-name=mixed -start-insert -no-restore file_rec:! buffer file_mru bookmark<cr><C-u>
			nnoremap <silent> [unite]f :<C-u>Unite -resume -buffer-name=files -start-insert -no-restore file_rec:!<cr><C-u>
		elseif has('nvim')
			nnoremap <silent> [unite]<space> :<C-u>Unite -no-split -start-insert -buffer-name=mixed file_rec/neovim:! buffer tab file_mru file bookmark<CR><C-u>
			nnoremap <silent> [unite]f :<C-u>Unite -no-split -start-insert file file_rec/neovim<CR><C-u>
		else
			nnoremap <silent> [unite]<space> :<C-u>Unite -resume -buffer-name=mixed -start-insert -no-restore file_rec/async:! buffer file_mru bookmark<cr><C-u>
			nnoremap <silent> [unite]f :<C-u>Unite -resume -buffer-name=files -start-insert -no-restore file_rec/async:!<cr><C-u>
		endif

		nnoremap <silent> [unite]d :<C-u>Unite -resume -buffer-name=files -start-insert -no-restore -default-action=lcd directory<cr><C-u>
		" nnoremap <silent> [unite]e :<C-u>Unite -resume -buffer-name=files -start-insert -no-restore neomru/file<cr><C-u>

		nnoremap <silent> [unite]l :<C-u>Unite -resume -buffer-name=line -start-insert -no-restore line<cr><C-u>
		nnoremap <silent> [unite]y :<C-u>Unite -buffer-name=yanks history/yank<cr>
		nnoremap <silent> [unite]b :<C-u>Unite -buffer-name=buffers buffer<cr>
		nnoremap <silent> [unite]/ :<C-u>Unite -buffer-name=search -no-quit grep:.<cr>
		nnoremap <silent> [unite]m :<C-u>Unite -buffer-name=mappings mapping<cr>
		nnoremap <silent> [unite]s :<C-u>Unite -buffer-name=quick_buffers -quick-match buffer<cr>
		nnoremap <silent> [unite]j :<C-u>Unite -buffer-name=jumps jump<cr>
		nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=registers register<cr>
		nnoremap <silent> [unite]o :<C-u>Unite -auto-resize -buffer-name=outline outline<CR>

		NeoBundleLazy 'Shougo/neoyank.vim', {'autoload':{'unite_sources':'history/yank'}}
		NeoBundleLazy 'Shougo/unite-outline', {'autoload':{'unite_sources':'outline'}}
		NeoBundleLazy 'Shougo/neomru.vim', {'autoload':{'unite_sources':'file_mru'}}
	endfunction
	call neobundle#untap()
endif
"}}}

"" Completion plugins -------------------------------------------------------{{{

NeoBundle 'mattn/emmet-vim'
if neobundle#tap('emmet-vim')
	function! neobundle#hooks.on_source(bundle)
		let g:user_emmet_mode='a'
	endfunction
	call neobundle#untap()
endif

NeoBundle 'Shougo/neocomplete.vim', {
			\ 'depends' : 'Shougo/context_filetype.vim',
			\ 'disabled' : !has('lua')
			\ }

if neobundle#tap('neocomplete.vim')
	function! neobundle#hooks.on_source(bundle)
		let g:neocomplete#enable_at_startup = 1
		let g:neocomplete#enable_smart_case = 1
		let g:neocomplete#max_list = 15

		""" <TAB>: completion.
		"inoremap <expr><TAB>  pumvisible() ? "<C-n>" : "<TAB>"
		""" <C-h>, <BS>: close popup and delete backword char.
		"inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
		"inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
		"inoremap <expr><C-y>  neocomplete#close_popup()
		"inoremap <expr><C-e>  neocomplete#cancel_popup()
		"" Close popup by <Space>.
		""inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"
	endfunction
	call neobundle#untap()
endif

"" Enable Omni Completion
augroup neocomplete_omni_complete
	autocmd!
	autocmd FileType css        setlocal omnifunc=csscomplete#CompleteCSS
	autocmd FileType html       setlocal omnifunc=htmlcomplete#CompleteTags
	autocmd FileType markdown   setlocal omnifunc=htmlcomplete#CompleteTags
	autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType xml        setlocal omnifunc=xmlcomplete#CompleteTags
	autocmd FileType python     setlocal omnifunc=pythoncomplete#Complete
	autocmd FileType haskell    setlocal omnifunc=necoghc#omnifunc
augroup END

"" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
	let g:neocomplete#sources#omni#input_patterns = {}
	let g:neocomplete#sources#omni#input_patterns.tex = '\\\a\+'
	let g:neocomplete#sources#buffer#max_keyword_width = 0
endif

""}}}

" Web Plugins ---------------------------------------------------------------{{{
" -nil-
" }}}

" Python Plugins ------------------------------------------------------------{{{
"NeoBundleLazy 'klen/python-mode', {'autoload':{'filetypes':['python']}}
"let g:pymode_rope=0
"}}}

" Haskell Plugins -----------------------------------------------------------{{{
NeoBundleLazy 'dag/vim2hs', {'autoload':{'filetypes':['haskell']}}
NeoBundleLazy 'lukerandall/haskellmode-vim', {'autoload':{'filetypes':['haskell']}}
NeoBundleLazy 'eagletmt/ghcmod-vim', {'autoload':{'filetypes':['haskell']}}
NeoBundleLazy 'eagletmt/neco-ghc', {'autoload':{'filetypes':['haskell']}}
"NeoBundleLazy 'travitch/hasksyn', {'autoload':{'filetypes':['haskell']}}
"}}}

" LaTeX plugins -------------------------------------------------------------{{{
NeoBundle 'LaTeX-Box-Team/LaTeX-Box', {'autoload':{'filetypes':['tex']}}
if neobundle#tap('LaTeX-Box')
	function! neobundle#hooks.on_source(bundle)
		let g:LatexBox_latexmk_async = 1
		let g:LatexBox_quickfix = 2
		let g:LatexBox_show_warnings = 0
		let g:LatexBox_Folding = 1
		let g:tex_flavor = 'latex'
		let g:tex_gotoerror = 0
	endfunction
	call neobundle#untap()
endif
"NeoBundle 'git://vim-latex.git.sourceforge.net/gitroot/vim-latex/vim-latex'
"}}}

" Other plugins -------------------------------------------------------------{{{
NeoBundle 'matchit.zip'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'tpope/vim-eunuch'
NeoBundle 'tpope/vim-unimpaired'
"NeoBundle 'wincent/terminus'
NeoBundle 'junegunn/fzf', { 'dir': '~/.fzf' }
NeoBundle 'junegunn/fzf.vim'
"NeoBundle 'ashisha/image.vim', { 'disabled' : !has('python') }
NeoBundle 'mhinz/vim-sayonara'
if neobundle#tap('vim-sayonara')
	function! neobundle#hooks.on_source(bundle)
		nnoremap <silent> Q :Sayonara<CR>
	endfunction
	call neobundle#untap()
endif
NeoBundle 'gorodinskiy/vim-coloresque'
NeoBundle 'chriskempson/base16-vim'
"NeoBundle 'mhartington/oceanic-next'
"NeoBundle 'ryanoasis/vim-devicons'
NeoBundle 'mattn/gist-vim', {'depends': 'mattn/webapi-vim'}

" This plugin isn't needed because I've done the necessary mappings in my
" tmux.conf
NeoBundle 'christoomey/vim-tmux-navigator', { 'disabled' : 1 }
if neobundle#tap('vim-tmux-navigator')
	function! neobundle#hooks.on_source(bundle)
		let g:tmux_navigator_no_mappings = 1
		nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
		nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
		nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
		nnoremap <silent> <C-h> :TmuxNavigateLeft<CR>
		nnoremap <silent> <C-;> :TmuxNavigatePrevious<cr>
		tmap <C-j> <C-\><C-n>:TmuxNavigateDown<cr>
		tmap <C-k> <C-\><C-n>:TmuxNavigateUp<cr>
		tmap <C-l> <C-\><C-n>:TmuxNavigateRight<cr>
		tmap <C-h> <C-\><C-n>:TmuxNavigateLeft<CR>
		tmap <C-;> <C-\><C-n>:TmuxNavigatePrevious<cr>
	endfunction
	call neobundle#untap()
endif

NeoBundle 'xolox/vim-session'
if neobundle#tap('vim-session')
	function! neobundle#hooks.on_source(bundle)
		set sessionoptions=blank,buffers,curdir,folds,resize,tabpages,winpos,winsize
		let g:session_autosave = 'no'
		let g:session_autoload = 'no'
		let g:session_command_aliases = 1
	endfunction
	call neobundle#untap()
endif

NeoBundle 'xolox/vim-misc'
NeoBundleLazy 'tpope/vim-markdown', {'autoload':{'filetypes':['markdown']}}
"NeoBundle 'scrooloose/syntastic' 
"let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': [], 'passive_filetypes': [] }
"let g:syntastic_quiet_warnings=1
"NeoBundle 'xolox/vim-notes'
"let g:notes_directories = ['~/documents/notes', '~/documents/work']
"let g:notes_suffix = '.txt'
"NeoBundle 'tpope/vim-abolish'
"NeoBundle 'tpope/vim-haml'
"NeoBundle 'tpope/vim-ragtag'
"}}}

call neobundle#end()
filetype plugin indent on
syntax enable
NeoBundleCheck

if !has('vim_starting')
	" Call on_source hook when reloading .vimrc
	call neobundle#call_hook('on_source')
endif
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
set wildignore+=*.sw?                            " Vim swap files
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
	exec "set undodir=".g:vimHome."/.cache/undo/"
	set noundofile
	set undolevels=1000
	set undoreload=10000
	au BufWritePre /tmp/* setlocal noundofile
endif

" Turn Backup off: reduces clutter
if exists('+backup')
	exec "set backupdir=".g:vimHome."/.cache/backup/"
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
exec "set dir=".g:vimHome."/.cache/swap/"

" Write swap file to disk after every 50 characters
set updatecount=200

call EnsureExists(g:vimHome.'/.cache')
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
colorscheme base16-default
let base16colorspace=256

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
	tnoremap <esc> <C-\><C-n><esc>
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
