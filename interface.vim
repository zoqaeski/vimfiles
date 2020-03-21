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
" User Interface
""""""""""""""""""""""""""""""""""""""""
" 
" Settings specific to the user interface. These have been moved to a separate
" file because the colour schemes are dependent on plugins, and wouldn't
" otherwise be loaded.
"
""""""""""""""""""""""""""""""""""""""""

" User Interface {{{
" --------------
set noshowmode                                     " Don't show the mode in the command window
set termguicolors                                  " Enable full colours in terminal
set relativenumber number                          " Display relative line numbers
set lazyredraw                                     " Don't redraw screen whilst executing macros
set laststatus=2                                   " Always show status line
set foldenable                                     " Enable folds by default
set foldmethod=syntax                              " Fold via syntax of files
set foldlevelstart=99                              " Open all folds by default
set showtabline=2                                  " Always show tab line
set nocursorline                                   " STOP UNDERLINING THE CURRENT LINE!!!
set noshowcmd                                      " Don't show partial command in bottom corner
set cmdheight=1                                    " One lines for the command line
set signcolumn=yes                                 " Always show the sign column

" Allow lots of tab pages -- 100 should be plenty
set tabpagemax=100
" Disable menu activation behaviour
set winaltkeys=no

" Wrapping and edge characters
" set fillchars=vert:│,fold:─
set listchars=tab:››,extends:…,precedes:«,nbsp:␣,trail:·,eol:$
let &showbreak='↳ '

if has('cmdline_info')
	" Show the ruler
	set ruler
	" a ruler on steroids
	" set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
	" Show partial commands in status line and selected characters/lines in visual mode
	set showcmd
endif

" Set colour scheme from Base16
if filereadable(expand("~/.vimrc_background"))
  source ~/.vimrc_background
endif

" GUI font
set guifont=Source\ Code\ Pro:h12

" }}}

" Status Line {{{
" -----------
" Always show a status line
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


" vim: ft=vim fdm=marker ts=2 sts=2 sw=2 fdl=0 :
