" Settings for NERDTree
" ---------------------
"
"  Additional settings for NerdTree that must be loaded after VimEnter
"

" Private helpers {{{
function! s:SID()
	if ! exists('s:sid')
		let s:sid = matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
	endif
	return s:sid
endfunction
let s:SNR = '<SNR>'.s:SID().'_'

function! s:get_containing_dir(node)
	let path = a:node.path
	if ! path.isDirectory || ! a:node.isOpen
		let path = path.getParent()
	endif
	return path.str()
endfunction
" }}}

" Plugin: Jump to $HOME {{{
" ---------------------
call NERDTreeAddKeyMap({
	\ 'key': 'gh',
	\ 'callback': s:SNR.'jump_home',
	\ 'quickhelpText': 'open user home directory' })

function! s:jump_home()
	call s:_set_root($HOME)
endfunction

function! s:_set_root(dir)
	let path = g:NERDTreePath.New(a:dir)
	let node = g:NERDTreeDirNode.New(path, b:NERDTree)
	call b:NERDTree.changeRoot(node)
endfunction
" }}}

" Plugin: Yank path {{{
" -----------------
call NERDTreeAddKeyMap({
	\ 'key': 'yy',
	\ 'callback': s:SNR.'yank_path',
	\ 'quickhelpText': 'yank current node',
	\ 'scope': 'Node' })

function! s:yank_path(node)
	let l:path = a:node.path.str()
	call setreg('*', l:path)
	echomsg 'Yank node: '.l:path
endfunction
" }}}
