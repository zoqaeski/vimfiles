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
"
" General
"
" General configuration options I haven't sorted anywhere else yet.
"
""""""""""""""""""""""""""""""""""""""""

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

" vim: ft=vim fdm=marker ts=2 sts=2 sw=2 fdl=0 :
