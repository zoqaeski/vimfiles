" gvimrc, attempt to fix sourcing of GUI when forking from term
colorscheme zarniwoop
set background=dark
" GUI Options
" (a) Autoselect in VISUAL mode
" (c) Console dialogs instead of popups 
" (g) Grey-out inactive menu items
" (i) Use a Vim icon
" (m) Display the menu bar
" (rR) Right hand scrollbar is always present
set guioptions=cim
" The following options override the defaults if somehow they get inserted.
" (lL) Left hand scrollbar is never present
set guioptions-=l
set guioptions-=L
" (e) Never display GTK+ tabs, but always display a tab line
set guioptions-=e
" (t) Never display tear-off menu items
" (T) Never display toolbar
set guioptions-=t
set guioptions-=T

" Fixed window width
set columns=148
set lines=36
" Resize X window to default size
nmap <Leader><S-s> :set columns=148 lines=36<CR>

" Fonts
"set guifont=Droid\ Sans\ Mono\ 11
set guifont=Droid\ Sans\ Mono\ 11

