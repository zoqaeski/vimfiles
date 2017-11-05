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
" User Interface
"
""""""""""""""""""""""""""""""""""""""""

" let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
set termguicolors                                   "enable full colours in terminal
set showmatch                                       "automatically highlight matching braces/brackets/etc.
set matchtime=2                                     "tens of a second to show matching parentheses
set relativenumber number
set lazyredraw
set laststatus=2
set foldenable                                      "enable folds by default
set foldmethod=syntax                               "fold via syntax of files
set foldlevelstart=99                               "open all folds by default
let g:xml_syntax_folding=1                          "enable xml folding

" Only display the current mode if lightline is active and loaded. 
" if exists('#lightline')
" 	set noshowmode
" else
" 	set showmode
" end

" My own preferred colour scheme; I'm looking for a better one
" let g:solarized_contrast="high"    "default value is normal

" Change background
" set background=dark
" let base16colorspace=256
" colorscheme base16-3024

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

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


" vim: ft=vim fdm=marker ts=2 sts=2 sw=2 fdl=0 :
