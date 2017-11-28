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
" Key mappings 
"
" This section is only used for key mappings that aren't associated with
" plugin functions. I do need a way to somehow merge the mappings from the
" plugins to here while avoiding conflicts with existing files.
"
""""""""""""""""""""""""""""""""""""""""

" Convenient editing mappings {{{
" ---------------------------
" Unset last search pattern
" nnoremap <Space> :nohlsearch<CR><Space>
" change cursor position in insert mode
inoremap <C-h> <left>
inoremap <C-l> <right>

" Change current word in a repeatable manner
nnoremap cn *``cgn
nnoremap cN *``cgN

" Change selected word in a repeatable manner
vnoremap <expr> cn "y/\\V\<C-r>=escape(@\", '/')\<CR>\<CR>" . "``cgn"
vnoremap <expr> cN "y/\\V\<C-r>=escape(@\", '/')\<CR>\<CR>" . "``cgN"

" Repeat paragraph
nnoremap cp yap<S-}>p

" Indent paragraph
nnoremap <leader>a =ip

" Duplicate lines
nnoremap yd m`YP``
vnoremap yd YPgv

" Drag current line/s vertically and auto-indent
vnoremap mk :m-2<CR>gv=gv
vnoremap mj :m'>+<CR>gv=gv
noremap  mk :m-2<CR>
noremap  mj :m+<CR>

" Source line and selection in vim
vnoremap <Leader>S y:execute @@<CR>:echo 'Sourced selection.'<CR>
nnoremap <Leader>S ^vg_y:execute @@<CR>:echo 'Sourced line.'<CR>

" }}}

" Folding {{{
" -------

nnoremap zr zr:echo &foldlevel<CR>
nnoremap zm zm:echo &foldlevel<CR>
nnoremap zR zR:echo &foldlevel<CR>
nnoremap zM zM:echo &foldlevel<CR>

" }}}

" Sane regex. Always be very magic {{{
" --------------------------------

" nnoremap / /\v
" vnoremap / /\v
" nnoremap ? ?\v
" vnoremap ? ?\v
" nnoremap :s/ :s/\v

" }}}

" Command-line mappings {{{
" ---------------------

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

" }}}

" Insert-mode mappings {{{
" --------------------

" Emacs mode in Insert? HERESY!!!
" inoremap <C-A> <Home>
" inoremap <C-E> <End>
" inoremap <C-K> <C-U>
" inoremap <C-b> <Left>
" inoremap <C-f> <Right>

" }}}

" Visual mode mappings {{{
" --------------------

" Use tab to indent in visual mode
vnoremap <Tab> >gv|
vnoremap <S-Tab> <gv

" Reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" Exit Visual Mode with q
vnoremap <silent> q <ESC>

" Select last thing pasted
nnoremap gV `[v`]

" Select last thing pasted
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
"}}}

" Windows and Buffers {{{
" -------------------

" Toggle between windows
" This breaks tab key for some reason :/
" nmap <Tab> <C-w>w
" nmap <S-Tab> <C-w>W

" Window-control prefix
nmap      s [window]
nnoremap  [window]   <nop>

nnoremap <silent> [window]i  :<C-u>split<CR>
nnoremap <silent> [window]v  :<C-u>vsplit<CR>
nnoremap <silent> [window]t  :tabnew<CR>
nnoremap <silent> [window]o  :<C-u>only<CR>
nnoremap <silent> [window]b  :ls<CR>
nnoremap <silent> [window]B  :ls<CR>:e #
nnoremap <silent> [window]q  :close<CR>
nnoremap <silent> [window]Q  :bdelete<CR>

" Split current buffer, go to previous window and previous buffer
nnoremap <silent> [window]sv :split<CR>:wincmd p<CR>:e#<CR>
nnoremap <silent> [window]sg :vsplit<CR>:wincmd p<CR>:e#<CR>

" Moving between windows and buffers
nnoremap <silent> [window]h <C-w>h
nnoremap <silent> [window]j <C-w>j
nnoremap <silent> [window]k <C-w>k
nnoremap <silent> [window]l <C-w>l
nnoremap <silent><nowait> [window]s  <C-w>w
nnoremap <silent><nowait> [window]S  <C-w>W

nnoremap <silent> [window]n :bnext<CR>
nnoremap <silent> [window]N :bprevious<CR>

nnoremap <silent> [window]H <C-w>H
nnoremap <silent> [window]J <C-w>J
nnoremap <silent> [window]K <C-w>K
nnoremap <silent> [window]L <C-w>L

" Quick moving between windows using ALT-
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
	" Terminal split openings
	nmap <A-t> [terminal]
	nmap [terminal] <nop>
	nnoremap [terminal]i :new term://zsh<CR>
	nnoremap [terminal]v :vnew term://zsh<CR>
endif


" Tab mappings
nnoremap <silent> g0 :<C-u>tabfirst<CR>
nnoremap <silent> g$ :<C-u>tablast<CR>
nnoremap <silent> gn :<C-u>tabnext<CR>
nnoremap <silent> gN :<C-u>tabprevious<CR>
nnoremap <Leader>> :tabmove +1<CR>
nnoremap <Leader>< :tabmove -1<CR>

" When pressing <leader>cd switch to the directory of the open buffer
map <Leader>cd :lcd %:p:h<CR>:pwd<CR>

" }}}


" vim: ft=vim fdm=marker ts=2 sts=2 sw=2 fdl=0 :
