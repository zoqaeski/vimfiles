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
" Functions and Commands
"
" This section contains functions and commands that are required by other
" sections of my vimrc.
" 
""""""""""""""""""""""""""""""""""""""""

" Functions ================================================================={{{

function! EnsureExists(path)
	if !isdirectory(expand(a:path))
		call mkdir(expand(a:path))
	endif
endfunction

function! Cwd()
	let cwd = getcwd()
	return "e " . cwd 
endfunction

function! CurrentFileDir(cmd)
	return a:cmd . " " . expand("%:p:h") . "/"
endfunction

function! CmdLine(str)
	exe "menu Foo.Bar :" . a:str
	emenu Foo.Bar
	unmenu Foo
endfunction

function! VisualSearch(direction) range "{{{		
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
endfunction "}}}

" Buffer closing
" command! BClose call <SID>BufCloseCloseIt()
" function! <SID>BufCloseCloseIt() "{{{
" 	let l:currentBufNum = bufnr("%")
" 	let l:alternateBufNum = bufnr("#")
"
" 	if buflisted(l:alternateBufNum)
" 		buffer #
" 	else
" 		bnext
" 	endif
"
" 	if bufnr("%") == l:currentBufNum
" 		new
" 	endif
"
" 	if buflisted(l:currentBufNum)
" 		execute("bdelete! ".l:currentBufNum)
" 	endif
" endfunction "}}}

" function! CloseWindowOrKillBuffer()
" 	let number_of_windows_to_this_buffer = len(filter(range(1, winnr('$')), "winbufnr(v:val) == bufnr('%')"))
"
" 	" never bdelete a nerd tree
" 	if matchstr(expand("%"), 'NERD') == 'NERD'
" 		wincmd c
" 		return
" 	endif
"
" 	if number_of_windows_to_this_buffer > 1
" 		wincmd c
" 	else
" 		bdelete
" 	endif
" endfunction

" Creates a temporary working buffer
function! ScratchEdit(cmd, options) "{{{
	exe a:cmd tempname()
	setl buftype=nofile bufhidden=wipe nobuflisted
	if !empty(a:options) | exe 'setl' a:options | endif
endfunction "}}}

" Identifies the syntax colouring item under the cursor
function! <SID>SynStack()
	if !exists("*synstack")
		return
	endif
	echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

"function! ToggleVExplorer() "{{{
"	if exists("t:expl_buf_num")
"		let expl_win_num = bufwinnr(t:expl_buf_num)
"		if expl_win_num != -1
"			let cur_win_nr = winnr()
"			exec expl_win_num . 'wincmd w'
"			close
"			exec cur_win_nr . 'wincmd w'
"			unlet t:expl_buf_num
"		else
"			unlet t:expl_buf_num
"		endif
"	else
"		exec '1wincmd w'
"		Vexplore
"		let t:expl_buf_num = bufnr("%")
"	endif
"endfunction "}}}
" }}}
" Useful Commands ==========================================================={{{

" Diff original file
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
command! Clear norm gg"_dG
command! -bar -nargs=* Sedit call ScratchEdit('edit', <q-args>)
command! -bar -nargs=* Ssplit call ScratchEdit('split', <q-args>)
command! -bar -nargs=* Svsplit call ScratchEdit('vsplit', <q-args>)
command! -bar -nargs=* Stabedit call ScratchEdit('tabe', <q-args>)

" autocmd {{{
" go back to previous position of cursor if any
autocmd BufReadPost *
			\ if line("'\"") > 0 && line("'\"") <= line("$") |
			\  exe 'normal! g`"zvzz' |
			\ endif

"autocmd FileType js,scss,css autocmd BufWritePre <buffer> call StripTrailingWhitespace()
autocmd FileType css,scss setlocal foldmethod=marker foldmarker={,}
autocmd FileType css,scss nnoremap <silent> <leader>S vi{:sort<CR>
"}}}
"}}}

" vim: ft=vim fdm=marker ts=2 sts=2 sw=2 fdl=0 :
