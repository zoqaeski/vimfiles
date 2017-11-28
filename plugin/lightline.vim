" Settings for Lightline
" ----------------------

let g:lightline = {
			\ 'colorscheme' : 'wombat',
			\ 'active': {
			\   'left': [ [ 'mode', 'paste' ],
			\             [ 'gitbranch', 'filename' ],
			\             [ 'modified', 'readonly' ] ],
			\   'right': [['lineinfo'], ['percent'], 
			\             ['fileencoding', 'filetype']]
			\ },
			\ 'component_function': {
			\   'gitbranch': 'fugitive#head',
			\   'modified': 'LightlineMod',
			\   'readonly': 'LightlineRO',
			\   'filename': 'LightlineName',
			\   'fileformat': 'LightlineFileformat',
			\   'filetype': 'LightlineFiletype',
			\   'fileencoding': 'LightlineEncoding',
			\ },
			\ 'component_type': {
			\		'readonly': 'error',
			\ },
			\ }

" Custom functions for lightline.vim
" These were adapted from http://code.xero.nu/dotfiles
function! LightlineMod()
	return &ft =~ 'help\|vimfiler' ? '' : &modified ? '+' : &modifiable ? '' : ''
endfunction

function! LightlineRO()
	return &ft !~? 'help\|vimfiler' && &readonly ? 'RO' : ''
endfunction

" This function will return the path of the file compressed to show only the
" first character for all preceding directories except the last
function! LightlineName()
	let l:name = expand('%:t')
	" NERDTree
	if l:name =~ 'NetrwTreeListing\|NERD_tree'
		return '[Filesystem]'
	endif

	" Don't do path reduction on help files
	if &filetype == 'help'
		return expand('%:t')
	endif
	
	" Reduce path to ~/.x/x/x/x/directory/filename.ext
	let l:path = split(expand('%:~:.'), '\/')
	let i = 0
	while i < len(l:path) - 2
		let l:firstchar = strpart(l:path[i], 0, 1)
		if l:firstchar == '.'
			let l:path[i] = strpart(l:path[i], 0, 2)
		else 
			let l:path[i] = l:firstchar
		endif
		let i = i + 1
	endwhile
	return ('' != expand('%:t') ? join(l:path, '/') : '[none]') 
endfunction

function! LightlineFileformat()
	return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
	return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : '') : ''
endfunction

function! LightlineEncoding()
	return winwidth(0) > 70 ? (strlen(&fenc) ? &enc : &enc) : ''
endfunction

" TODO
" Come up with a LightlineMode function that will replace the
" NORMAL/INSERT/VISUAL mode text with plugin-specific things. From a quick
" glance through the source to Lightline, it looks a bit beyond my abilities
" right now

" Update and show lightline but only if it's visible (e.g., not in Goyo)
function! s:MaybeUpdateLightline()
	if exists('#lightline')
		call lightline#update()
	end
endfunction
