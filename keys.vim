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
" plugin functions.
"
""""""""""""""""""""""""""""""""""""""""

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
" nnoremap / /\v
" vnoremap / /\v
" nnoremap ? ?\v
" vnoremap ? ?\v
" nnoremap :s/ :s/\v
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
"}}}

" }}}

" vim: ft=vim fdm=marker ts=2 sts=2 sw=2 fdl=0 :
