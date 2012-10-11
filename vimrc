""""""""""""""""""""""""""""""""""""""""
"
" ~/.vimrc
"
" Version 3.141592654....
"
" Heavily Inspired by amix the lucky stiff's vimrc
" Well, the layout and the functions are
"
" Sections
"	-> <url:#General Stuff>
"	-> <url:#Interface>
"	-> <url:#Status Line>
"	-> <url:#Files, Backups and Undo>
"	-> <url:#Text/Tab/Indentation>
"	-> <url:#Visual Mode Mappings>
"	-> <url:#Command Mode Mappings>
"	-> <url:#Moving Around, Tabs and Buffers>
"	-> <url:#Editing Mappings>
"	-> <url:#Filetype Settings>
"	-> <url:#Useful Commands>
"	-> <url:#Autocommands>
"	-> <url:#Plugin Settings>
"
""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""
" +> General Stuff
""""""""""""""""""""""""""""""""""""""""

" VUNDLE!
source ~/.vim/vundlerc

" Some parts require a vim home to function
let g:vimHome = strpart(&rtp, 0, stridx(&rtp, '/bundle'))

function! MySys()
	return "linux"
endfunction

" Map Leader for extra mappings and keybindings
let mapleader = ","
let g:mapleader = ","
let maplocalleader = ","
let g:maplocalleader = ","

" Quick Editing and Sourcing of ~/.vimrc
nnoremap <Leader>s :source $MYVIMRC<CR>
nnoremap <Leader>v :edit $MYVIMRC<CR>
" When .vimrc is edited, reload it
"autocmd! bufwritepost .vimrc source ~/.vimrc

" Remember things between sessions
" '20  - remember marks for 20 previous files
" \"50 - save 50 lines for each register
" :50  - remember 50 items in command-line history 
set viminfo='20,\"50,:50,/50

" Session options
set sessionoptions=blank,buffers,curdir,folds,resize,tabpages,winpos,winsize

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" No place holders for
let g:Imap_UsePlaceHolders=0

" Modelines
set modeline
set modelines=10

""""""""""""""""""""""""""""""""""""""""
" +> Interface
""""""""""""""""""""""""""""""""""""""""
" Minimum number of lines to keep above/below the cursor
set scrolloff=4
set sidescrolloff=0

" Command <Tab> completion, list matches and complete the longest common part, then, cycle through the matches
set wildmenu
set wildmode=list:longest,full

" Ignore these file types when opening
set wildignore=*.bak,*~,*.jpg,*.gif,*.png,*.pdf,*.class,*.pyc,*.o,*.obj,*.swp

" Browse menus from command line
source $VIMRUNTIME/menu.vim
set cpo-=<
set wcm=<C-Z>
map <F4> :emenu <C-Z>

if has('cmdline_info')
	" Show the ruler
	set ruler

	" a ruler on steroids
	set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)

	" Show partial commands in status line and selected characters/lines in visual mode
	set showcmd
endif

" Hide buffers -- allows buffer changing without saving
set hidden

" Backspace for dummies
set backspace=indent,eol,start

" Searching
set ignorecase
set smartcase
set nohlsearch
set incsearch

" Don't redraw whilst executing macros
set nolazyredraw

" Regex magick
set magic

" Don't jump to matching brackets/parenthesis
set noshowmatch

" match, to be used with %
set matchpairs+=<:>

" Error Bells
set noerrorbells
set novisualbell

" Turn syntax highlighting on
syntax on

" My own preferred colour scheme; I'm looking for a better one
let g:solarized_contrast="high"    "default value is normal

" Change background
"call togglebg#map("<F12>")
set background=dark

colorscheme default

if has('gui_running') 
	source ~/.gvimrc
endif

" Always show tab line
set showtabline=2

" STOP UNDERLINING THE CURRENT LINE!!!
set nocursorline

" Default file encoding
set encoding=utf-8

" File formats
set ffs=unix,dos,mac

" Allow lots of tab pages -- 100 should be plenty
set tpm=100

" Always make split windows equal
set equalalways

" Folding
set foldenable

" Disable menu activation behaviour
set winaltkeys=no

" Remember up to 100 'colon' commmands and search patterns
set history=100

" Show line numbers
set number

" Display current mode
set showmode

" Abbreviation of messages (avoids 'hit enter')
set shortmess+=atI

" Squeak squeak!
set mouse=ar

" Enable CTRL-A/CTRL-X to work on octal and hex numbers, as well as characters
set nrformats=octal,hex,alpha


""""""""""""""""""""""""""""""""""""""""
" +> Status Line
""""""""""""""""""""""""""""""""""""""""
" always show a status line
set laststatus=2

" A SUPER STATUS LINE!!
set statusline=                                 " Clears status line
set statusline+=\ %<                            " Separator, truncate
set statusline+=\ (%n)                          " Buffer
set statusline+=\ %f                            " File (relative path)
set statusline+=\ %M                            " Modified + -
set statusline+=\ %R%H%W                        " RO/HLP/PRV
set statusline+=\ %=                            " Separator left/right
set statusline+=\ [                             " Start group
set statusline+=%{strlen(&ft)?&ft:'none'}/      " File type
set statusline+=%{&fileformat}/                 " File format
set statusline+=%{(&fenc==\"\"?&enc:&fenc)}     " File encoding
set statusline+=]                               " End group
set statusline+=\ %l:%c%V                       " Line, column, virtual column
set statusline+=\ %P                            " Percentage


""""""""""""""""""""""""""""""""""""""""
" +> Files, Backups and Undo
""""""""""""""""""""""""""""""""""""""""
" Turn Backup off: reduces clutter
set backup
set writebackup
exec "set backupdir=".g:vimHome."/tmp/backup//,/tmp//"
au BufWritePre * let &bex = '-' . strftime("%Y%m%d-%H%M%S") . '.vimbackup'

" Swap file
set swapfile
exec "set dir=".g:vimHome."/tmp/swap//"

" Write swap file to disk after every 50 characters
set updatecount=200

" Persistent Undo
exec "set undodir=".g:vimHome."/tmp/undo//"
set undofile
set undolevels=1000
set undoreload=10000
au BufWritePre /tmp/* setlocal noundofile


""""""""""""""""""""""""""""""""""""""""
" +> Text/Tab/Indentation
""""""""""""""""""""""""""""""""""""""""
" Use 4 spaces for <Tab> and :retab
set tabstop=4
set softtabstop=4
set noexpandtab
set smarttab

" Use indents of 4 spaces
set shiftwidth=4

" Smart auto-indententation
set autoindent
set smartindent

" Round indent to multiple of 'shiftwidth' for > and < commands
set shiftround

" Wrap long lines
set nowrap
set textwidth=0
set linebreak
map <F2> :set wrap!<CR>


""""""""""""""""""""""""""""""""""""""""
" +> Visual Mode Mappings
""""""""""""""""""""""""""""""""""""""""
" Really useful!
"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSearch('gv')<CR>
map <Leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv 

" Select last thing pasted
nnoremap gV `[v`]

function! CmdLine(str)
	exe "menu Foo.Bar :" . a:str
	emenu Foo.Bar
	unmenu Foo
endfunction

" From an idea by Michael Naumann (via amix the lucky stiff)
function! VisualSearch(direction) range
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
endfunction


""""""""""""""""""""""""""""""""""""""""
" +> Command Mode Mappings
""""""""""""""""""""""""""""""""""""""""
" Smart mappings on command line
cno $h e ~/
cno $c e <C-\>eCurrentFileDir("e")<CR>

" $q is super useful when browsing on the command line
"cno $q <C-\>eDeleteTillSlash()<CR>

" Default shell-like keys for the command line
" Is it a sin to use Emacs keys in Vim?
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-K> <C-U>
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

" Vi-style editing in the command-line : NOICE
noremap :: q:
noremap // q/
noremap ?? q?

function! Cwd()
  let cwd = getcwd()
  return "e " . cwd 
endfunction

function! DeleteTillSlash()
	let g:cmd = getcmdline()
	if MySys() == "linux" || MySys() == "mac"
		let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
	else
		let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
	endif
	if g:cmd == g:cmd_edited
		if MySys() == "linux" || MySys() == "mac"
			let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
		else
			let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
		endif
	endif
	return g:cmd_edited
endfunction

function! CurrentFileDir(cmd)
  return a:cmd . " " . expand("%:p:h") . "/"
endfunction


""""""""""""""""""""""""""""""""""""""""
" +> Moving Around, Tabs and Buffers
""""""""""""""""""""""""""""""""""""""""
" Searching
"map <space> / " Not sure if I want this
"map <C-space> ? " Not sure if I want this
noremap <silent> <Leader><CR> :set hlsearch! hlsearch?<CR>

" Close the current buffer
nnoremap <Leader>bc :close<CR>
nnoremap <Leader>bd :BClose<CR>
nnoremap <Leader>bD :BClose<CR>:close<CR>

" Switch between buffers quickly
nnoremap gb :bnext<CR>
nnoremap gB :bprevious<CR>
nmap <Leader>bl :buffers<CR>

" Tab commands
nmap <Leader>tn :tabnew<CR>
nmap <Leader>te :tabedit
nmap <Leader>tc :tabclose<CR>
nmap <Leader>tm :tabmove
nmap <Leader>tM :tabmove<CR>
nmap <Leader>t> :tabmove +1<CR>
nmap <Leader>t< :tabmove -1<CR>

" When pressing <leader>cd switch to the directory of the open buffer
nmap <leader>cd :cd %:p:h<cr>

" Stop QuickFix window from borking my tab pages
set switchbuf=usetab

" Buffer closing
command! BClose call <SID>BufCloseCloseIt()
function! <SID>BufCloseCloseIt()
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
endfunction


""""""""""""""""""""""""""""""""""""""""
" +> Editing Mappings
""""""""""""""""""""""""""""""""""""""""
" Insert blank lines
noremap <Leader>o o<Esc>k
noremap <Leader>O O<Esc>j

" Show hidden characters
set listchars=tab:>-,trail:·,eol:$
nmap <silent> <Leader>h :set nolist!<CR>

" Delete word with Backspace
imap <S-BS> <Esc>bdwa
nmap <S-BS> <Esc>bdwa

" Delete and backspace in insert mode
inoremap <C-H> <BS>
inoremap <C-D> <Del>

" Use F11 to toggle 'paste' mode... whatever that is
set pastetoggle=<F11>
"nmap <Leader>p :set invpaste<CR>
"nmap <Leader>P :set paste<CR>I

" Tab stuff
imap <S-Tab> <C-o><<

" Transpose words, Emacs-style
" TODO

" TODO: Add a TaskList Toggle perhaps?

""""""""""""""""""""""""""""""""""""""""
" +> Filetype Settings
""""""""""""""""""""""""""""""""""""""""
" ++> LaTeX
let g:tex_flavor='latex'
let g:tex_gotoerror=0

" ++> XML
let xml_use_xhtml = 1

""""""""""""""""""""""""""""""""""""""""
" +> Useful Commands
"""""""""""""""""""""""""""""""""""""""
" Diff original file
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
command! Scratch tabnew | set bt=nofile
command! Clear norm gg"_dG

""""""""""""""""""""""""""""""""""""""""
" +> Autocommands
"""""""""""""""""""""""""""""""""""""""
" I may expand these in future
" Moved to <url:./.vim/filetype.vim>

""""""""""""""""""""""""""""""""""""""""
" +> Plugin Settings
""""""""""""""""""""""""""""""""""""""""

" ++> NERDTree
nnoremap <Leader>n :NERDTreeToggle %:p:h<CR>

" ++> YankRing
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

" ++> UltiSnips
exec "set runtimepath+=".g:vimHome."/ultisnips_rep"

" ++> UTL
let g:utl_cfg_hdl_scm_http_system = 'silent !xdg-open %u'  
nnoremap <Leader>] :Utl<CR>

" ++> HTML tools
let g:do_xhtml_mappings = 'yes'
let g:html_tag_case = 'lowercase'
let g:no_html_toolbar = 'yes'
let g:no_html_menu = 'yes'

" ++> matchit
let b:match_words = '‹:›,«:»,”:„,“:”,‘:’'

" ++> Notes
let g:notes_directory = '~/documents/notes'
let g:notes_suffix = '.txt'

" ++> Shell
let g:shell_mappings_enabled = 0
let g:shell_fullscreen_items = 'mT'
nnoremap <F6> :Open<CR>
