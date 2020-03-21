" Settings for Defx
" =================

call defx#custom#option('_', {
	\ 'resume': 1,
	\ 'toggle': 1,
	\ 'winwidth': 30,
	\ 'split': 'vertical',
	\ 'direction': 'topleft',
	\ 'show_ignored_files': 0,
	\ 'buffer_name': 'Files',
	\ 'columns': 'mark:indent:icon:filename',
	\ })


nnoremap <silent> <LocalLeader>e
	\ :<C-u>Defx -toggle<CR>
nnoremap <silent> <LocalLeader>E
	\ :<C-u>Defx `expand('%:p:h')` -search=`expand('%:p')`<CR>

augroup user_plugin_defx
	autocmd!

	" Define defx window mappings
	autocmd FileType defx call <SID>defx_mappings()

	" Delete defx if it's the only buffer left in the window
	autocmd WinEnter * if &filetype == 'defx' && winnr('$') == 1 | bdel | endif

	" Move focus to the next window if current buffer is defx
	autocmd TabLeave * if &filetype == 'defx' | wincmd w | endif

augroup END

" Internal functions
" ------------------

let s:original_width = get(get(defx#custom#_get().option, '_'), 'winwidth')

function! s:defx_mappings() abort
	" Defx window keyboard mappings
	setlocal signcolumn=no expandtab
	setlocal cursorline

	" Opening/executing files
	nnoremap <silent><buffer><expr> <CR>  <SID>defx_toggle_tree()
	nnoremap <silent><buffer><expr> e     <SID>defx_toggle_tree()
	nnoremap <silent><buffer><expr> l     <SID>defx_toggle_tree()
	nnoremap <silent><buffer><expr> h     defx#do_action('close_tree')
	nnoremap <silent><buffer><expr> t     defx#do_action('open_tree_recursive')
	nnoremap <silent><buffer><expr> st    defx#do_action('multi', [['drop', 'tabnew'], 'quit'])
	nnoremap <silent><buffer><expr> sv    defx#do_action('multi', [['drop', 'vsplit'], 'quit'])
	nnoremap <silent><buffer><expr> si    defx#do_action('multi', [['drop', 'split'], 'quit'])
	nnoremap <silent><buffer><expr> sT    defx#do_action('drop', 'tabnew')
	nnoremap <silent><buffer><expr> sV    defx#do_action('drop', 'vsplit')
	nnoremap <silent><buffer><expr> sI    defx#do_action('drop', 'split')
	nnoremap <silent><buffer><expr> yp    defx#do_action('yank_path')
	nnoremap <silent><buffer><expr> x     defx#do_action('execute_system')
	nnoremap <silent><buffer><expr> gx    defx#do_action('execute_system')

	" Change directory
	nnoremap <silent><buffer><expr> cd    defx#do_action('change_vim_cwd')
	nnoremap <silent><buffer><expr> <BS>  defx#async_action('cd', ['..'])
	nnoremap <silent><buffer><expr> ~     defx#async_action('cd')
	nnoremap <silent><buffer><expr> u     defx#do_action('cd', ['..'])
	nnoremap <silent><buffer><expr> 2u    defx#do_action('cd', ['../..'])
	nnoremap <silent><buffer><expr> 3u    defx#do_action('cd', ['../../..'])
	nnoremap <silent><buffer><expr> 4u    defx#do_action('cd', ['../../../..'])

	" Sorting and viewing files
	nnoremap <silent><buffer><expr> .   defx#do_action('toggle_ignored_files')
	nnoremap <silent><buffer><expr> w   defx#do_action('call', '<SID>toggle_width')

	" Selection
	nnoremap <silent><buffer><expr> *  defx#do_action('toggle_select_all')
	nnoremap <silent><buffer><expr><nowait> <Space>
		\ defx#do_action('toggle_select') . 'j'

	" File/dir management
	nnoremap <silent><buffer><expr><nowait> yy  defx#do_action('copy')
	nnoremap <silent><buffer><expr><nowait> dd  defx#do_action('move')
	nnoremap <silent><buffer><expr><nowait> p   defx#do_action('paste')
	nnoremap <silent><buffer><expr><nowait> cw  defx#do_action('rename')
	nnoremap <silent><buffer><expr> K           defx#do_action('new_directory')
	nnoremap <silent><buffer><expr> N           defx#do_action('new_multiple_files')

	" Defx's buffer management
	nnoremap <silent><buffer><expr> q      defx#do_action('quit')
	nnoremap <silent><buffer><expr> se     defx#do_action('save_session')
	nnoremap <silent><buffer><expr> <C-r>  defx#do_action('redraw')
	nnoremap <silent><buffer><expr> <C-g>  defx#do_action('print')
endfunction

" Open current file, or toggle directory expand/collapse
function! s:defx_toggle_tree() abort
	if defx#is_directory()
		return defx#do_action('open_or_close_tree')
	endif
	return defx#do_action('multi', ['drop', 'quit'])
endfunction

" Toggle between defx window width and longest line
function! s:toggle_width(context) abort
	let l:max = 0
	for l:line in range(1, line('$'))
		let l:len = len(getline(l:line))
		let l:max = max([l:len, l:max])
	endfor
	let l:new = l:max == winwidth(0) ? s:original_width : l:max
	call defx#call_action('resize', l:new)
endfunction
