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
""""""""""""""""""""""""""""""""""""""""
" General
""""""""""""""""""""""""""""""""""""""""
"
" General configuration options for most editor behaviours.
"
""""""""""""""""""""""""""""""""""""""""

" Behaviour {{{
" ---------
set nowrap                                         " No wrap by default
set linebreak                                      " Break long lines at 'breakat'
set breakat=\ \	;:,!?                              " Long lines break chars
set nostartofline                                  " Cursor in same column for few commands
set whichwrap+=h,l,<,>,[,],~                       " Move to following line on certain keys
set splitbelow splitright                          " Splits open bottom right
set switchbuf=useopen,usetab                       " Jump to the first open window in any tab
set switchbuf+=vsplit                              " Switch buffer behavior to vsplit
set backspace=indent,eol,start                     " Intuitive backspacing in insert mode
set diffopt=filler,iwhite                          " Diff mode: show fillers, ignore white
set tags=.git/tags,tags                          
set showfulltag                                    " Show tag and tidy search in completion
set complete=.                                     " No wins, buffs, tags, include scanning
set completeopt=menuone                            " Show menu even for one item
set completeopt+=noselect                          " Do not select a match in the menu
set virtualedit=block                              " Position cursor anywhere in visual block
set report=0                                       " Always report changes for ':' commands
set magic                                          " Always use magic regex
set modeline                                       " Use modelines for file-specific settings
set modelines=5                                    " Look for mode lines in top- and bottommost five lines
set mouse=a                                        " Enable mouse in all places
set mousehide                                      " hide when characters are typed
set hidden                                         " Allow buffer switching without saving
set autoread                                       " Auto reload if file saved externally
set fileformats+=unix,dos,mac                      " Add mac to auto-detection of file format line endings
set nrformats=octal,hex,alpha                      " Consider octal, hexadecimal and alphanumeric as numbers
" Disable sounds
set noerrorbells                                  
set novisualbell                                   
" }}}

" Tabs, Indentation, and Whitespace {{{
" ---------------------------------
set textwidth=80                                   " Text width maximum chars before wrapping
set tabstop=4                                      " The number of spaces a tab is
set softtabstop=4                                  " While performing editing operations
set shiftwidth=4                                   " Number of spaces to use in auto(indent)
set smarttab                                       " Tab insert blanks according to 'shiftwidth'
set autoindent                                     " Use same indenting on new lines
set smartindent                                    " Smart autoindenting on new lines
set noexpandtab                                    " Don't expand tabs to spaces.
set shiftround                                     " Round indent to multiple of 'shiftwidth'
set nolist                                         " Highlight whitespace

" }}}

" Timing {{{
" ------
set timeout ttimeout
set timeoutlen=1000                                " Time out on mappings
set updatetime=1000                                " Idle time to write swap and trigger CursorHold
set ttimeoutlen=-1                                 " Keycode timeout

" }}}

" Searching {{{
" ---------
set hlsearch                                       " Highlight searches
set incsearch                                      " Incremental searching
set ignorecase                                     " Ignore case for searching
set smartcase                                      " Do case-sensitive if there's a capital letter
set wrapscan                                       " Searches wrap around the end of files
set showmatch                                      " Jump to matching bracket
set matchpairs+=<:>                                " Add HTML brackets to pair matching
set matchtime=1                                    " Tenths of a second to show the matching paren
set cpoptions-=m                                   " showmatch will wait 0.5s or until a char is typed
" }}}

" Wildmenu {{{
" --------
if has('wildmenu')
	set wildmenu                                     " show list for autocomplete
	set wildmode=list:longest,full
	set wildoptions=tagfile
	set wildignorecase
	set wildignore+=.hg,.git,.svn                    " Version control
	set wildignore+=*.aux,*.out                      " LaTeX intermediate files
	set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
	set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
	set wildignore+=*.spl                            " compiled spelling word lists
	" set wildignore+=*.sw?                          " Don't ignore Vim swap files
	set wildignore+=.DS_Store                        " OS X
	set wildignore+=*.luac                           " Lua byte code
	set wildignore+=*.pyc                            " Python byte code
endif
" }}}

" Session Saving {{{
" --------------
set sessionoptions-=blank
set sessionoptions-=options
set sessionoptions-=globals
set sessionoptions-=help
set sessionoptions+=tabpages

" What to save for views
set viewoptions-=options
set viewoptions-=unix,slash
" }}}

" History Saving {{{
" --------------
set history=1000                                   " number of command lines to remember
" Remember things between sessions
" '20  - remember marks for 20 previous files
" \"50 - save 50 lines for each register
" :50  - remember 50 items in command-line history 
set viminfo='20,\"50,:50,/50

if exists('+shada')
	set shada='100,f1,<50,:100,s100
endif
" }}}

" Vim Directories {{{
" ---------------
set swapfile
set directory=$VARPATH/swap//
set viewdir=$VARPATH/view/
set nospell spellfile=$CONFIGPATH/spell/en.utf-8.add

" persistent undo
if exists('+undofile')
	set undodir=$VARPATH/undo//
	set undofile
	set undolevels=1000
	set undoreload=10000
	au BufWritePre /tmp/* setlocal noundofile
endif

" Turn Backup off: reduces clutter
if exists('+backup')
	set backupdir=$VARPATH/backup/
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

" Write swap file to disk after every 50 characters
set updatecount=50
" }}}

if executable('ag')
	set grepprg=ag\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow
	set grepformat=%f:%l:%c:%m
elseif executable('ack')
	set grepprg=ack\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow\ $*
	set grepformat=%f:%l:%c:%m
endif

" vim: ft=vim fdm=marker ts=2 sts=2 sw=2 fdl=0 :
