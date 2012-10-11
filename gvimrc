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
set guioptions=aci
" (lL) Left hand scrollbar is never present
set guioptions-=lL
" (e) Never display GTK+ tabs, but always display a tab line
set guioptions-=em
set showtabline=2
" (t) Never display tear-off menu items
" (T) Never display toolbar
set guioptions-=tT

" Fixed window width
set columns=112
set lines=28
" Resize X window to default size
nmap <Leader><S-s> :set columns=112 lines=28<CR>

" Fonts
"set guifont=Droid\ Sans\ Mono\ 11
set guifont=DejaVu\ Sans\ Mono\ 11

