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

""""""""""""""""""""""""""""""""""""""""
"
" Filetypes
"
" This section contains all filetype settings that should be placed in ftplugin
" yet for some weird reason don't work.
"
""""""""""""""""""""""""""""""""""""""""

augroup FileTypeCmd " {{{
" -----------------

	" Check if file changed when its window is focus, more eager than 'autoread'
	autocmd WinEnter,FocusGained * checktime

	" Perform syntax highlighting on at least 200 lines
	autocmd Syntax * if 5000 < line('$') | syntax sync minlines=200 | endif

	" When editing a file, always jump to the last known cursor position.
	" Don't do it when the position is invalid or when inside an event handler
	autocmd BufReadPost *
		\ if &ft !~ '^git\c' && ! &diff && line("'\"") > 0 && line("'\"") <= line("$")
		\|   execute 'normal! g`"zvzz'
		\| endif

	" Update most recent tab
	autocmd TabLeave * let g:lasttab = tabpagenr()

	autocmd FileType markdown
		\ set expandtab
		\ | setlocal spell autoindent formatoptions=tcroqn2 comments=n:>

	"autocmd FileType js,scss,css autocmd BufWritePre <buffer> call StripTrailingWhitespace()
	autocmd FileType css,scss setlocal foldmethod=marker foldmarker={,}

	autocmd BufNewFile,BufRead Tmuxfile,tmux/config setlocal filetype=tmux

augroup END " }}}

" TeX/LaTeX {{{
" ---------

" Disable error highlighting
let g:tex_no_error=1
let g:tex_stylish=1
let g:tex_fast="bcmprsSvV"

" Automatic folding of TeX sections
let g:tex_fold_enabled=1

" }}}

" CSS {{{
" ---

" }}}

" Vim {{{
" ---
let g:vimsyntax_noerror = 1
let g:vim_indent_cont = &shiftwidth
" }}}

" vim: ft=vim fdm=marker ts=2 sts=2 sw=2 fdl=0 :
