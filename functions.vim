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

" Ensures a directory exists
function! EnsureExists(path) " {{{
	if !isdirectory(expand(a:path))
		call mkdir(expand(a:path))
	endif
endfunction " }}}

" Gets the current working directory
function! Cwd() " {{{
	let cwd = getcwd()
	return "e " . cwd 
endfunction " }}}

" Gets the current file directory
function! CurrentFileDir(cmd) " {{{
	return a:cmd . " " . expand("%:p:h") . "/"
endfunction " }}}

" Searches in Visual Mode
function! VisualSearch(direction) range " {{{		
	let l:saved_reg = @"
	execute "normal! vgvy"

	let l:pattern = escape(@", '\\/.*$^~[]')
	let l:pattern = substitute(l:pattern, "\n$", "", "")

	if a:direction == 'b'
		execute "normal ?" . l:pattern . "^M"
	elseif a:direction == 'f'
		execute "normal /" . l:pattern . "^M"
	endif

	let @/ = l:pattern
	let @" = l:saved_reg
endfunction " }}}

" Creates a temporary working buffer
function! ScratchEdit(cmd, options) " {{{
	exe a:cmd tempname()
	setl buftype=nofile bufhidden=wipe nobuflisted
	if !empty(a:options) | exe 'setl' a:options | endif
endfunction " }}}

" Identifies the syntax colouring item under the cursor
function! <SID>SynStack() " {{{
	if !exists("*synstack")
		return
	endif
	echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc " }}}

" Terminal Drawer
" Pops up a terminal window at the bottom of the screen
let g:terminal_drawer = { 'win_id': v:null, 'buffer_id': v:null } " {{{
function! ToggleTerminalDrawer() abort
	if win_gotoid(g:terminal_drawer.win_id)
		hide
		set laststatus=2 showmode ruler
	else
		botright new
		if !g:terminal_drawer.buffer_id
			call termopen($SHELL, {"detach": 0})
			let g:terminal_drawer.buffer_id = bufnr("")
		else
			exec 'buffer' g:terminal_drawer.buffer_id
			call RemoveEmptyBuffers()
		endif

		exec 'resize' float2nr(&lines * 0.25)
		setlocal laststatus=0 noshowmode noruler
		setlocal nobuflisted
		echo ''
		startinsert!
		let g:terminal_drawer.win_id = win_getid()

		tnoremap <buffer><Esc> <C-\><C-n>
		nnoremap <buffer><silent><Esc> :q<cr>
	endif
endfunction
" }}}

" Creates a centered floating window
function! CreateCenteredFloatingWindow() "  {{{
	let width  = float2nr(&columns * 0.9)
	let height = float2nr(&lines * 0.8)
	let top    = ((&lines - height) / 2) - 1
	let left   = (&columns - width) / 2
	let opts   = { 'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal' }
	let top    = "╭" . repeat("─", width - 2) . "╮"
	let mid    = "│" . repeat(" ", width - 2) . "│"
	let bot    = "╰" . repeat("─", width - 2) . "╯"
	let lines  = [top] + repeat([mid], height - 2) + [bot]
	let s:buf  = nvim_create_buf(v:false, v:true)

	call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
	call nvim_open_win(s:buf, v:true, opts)
	set winhl=Normal:Floating

	call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, CreatePadding(opts))
	autocmd BufWipeout <buffer> exe 'bwipeout '.s:buf
endfunction

function! CreatePadding(opts)
	let a:opts.row    += 1
	let a:opts.height -= 2
	let a:opts.col    += 2
	let a:opts.width  -= 4
	return a:opts
endfunction
" }}}

" Toggle Terminal 
" Creates a centered terminal floating window
function! ToggleTerm(cmd) " {{{
	if empty(bufname(a:cmd))
		call CreateCenteredFloatingWindow()
		call termopen(a:cmd, { 'on_exit': function('OnTermExit') })
	else
		bwipeout!
	endif
endfunction

function! OnTermExit(job_id, code, event) dict
	if a:code == 0
		bwipeout!
	endif
endfunction
" }}}

" Removes empty buffers
function! RemoveEmptyBuffers() " {{{
	let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val)<0 && !getbufvar(v:val, "&mod")')
	if !empty(buffers)
		silent exe 'bw ' . join(buffers, ' ')
	endif
endfunction
" }}}

" Useful Commands {{{
" ---------------

" Diff original file
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
command! Clear norm gg"_dG

" Scratch buffers
command! -bar -nargs=* Sedit call ScratchEdit('edit', <q-args>)
command! -bar -nargs=* Ssplit call ScratchEdit('split', <q-args>)
command! -bar -nargs=* Svsplit call ScratchEdit('vsplit', <q-args>)
command! -bar -nargs=* Stabedit call ScratchEdit('tabe', <q-args>)



" AutoCommands {{{
" ------------

" Changes line numbers to be absolute on insert mode and relative otherwise.
augroup NumberToggle
	autocmd!
	autocmd InsertLeave * set relativenumber
	autocmd InsertEnter * set norelativenumber
augroup END

" Default settings for terminal
augroup TerminalBehavior
	autocmd!
	autocmd TermOpen * setlocal listchars= nonumber norelativenumber nowrap winfixwidth laststatus=0 noruler signcolumn=no noshowmode
	autocmd TermOpen * startinsert
	autocmd TermClose * set laststatus=2 showmode ruler
augroup END

" }}}

" vim: ft=vim fdm=marker et ts=2 sts=2 sw=2 fdl=0 :
