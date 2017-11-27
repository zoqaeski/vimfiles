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

" Plugin: Smart h/l navigation {{{
" @see https://github.com/jballanc/nerdtree-space-keys
" ---
call NERDTreeAddKeyMap({
	\ 'key':           'l',
	\ 'callback':      s:SNR.'descendTree',
	\ 'quickhelpText': 'open tree and go to first child',
	\ 'scope':         'DirNode' })
call NERDTreeAddKeyMap({
	\ 'key':           'h',
	\ 'callback':      s:SNR.'closeOrAscendTree',
	\ 'quickhelpText': 'close dir or move to parent dir',
	\ 'scope':         'DirNode' })
call NERDTreeAddKeyMap({
	\ 'key':           'h',
	\ 'callback':      s:SNR.'ascendTree',
	\ 'quickhelpText': 'move to parent dir',
	\ 'scope':         'FileNode' })

function! s:descendTree(dirnode)
	call a:dirnode.open()
	call b:NERDTree.render()
	if a:dirnode.getChildCount() > 0
		let chld = a:dirnode.getChildByIndex(0, 1)
		call chld.putCursorHere(0, 0)
	end
endfunction

function! s:closeOrAscendTree(dirnode)
	if a:dirnode.isOpen
		call a:dirnode.close()
		call b:NERDTree.render()
	else
		call s:ascendTree(a:dirnode)
	endif
endfunction

function! s:ascendTree(node)
	let parent = a:node.parent
	if parent != {}
		call parent.putCursorHere(0, 0)
		if parent.isOpen
			call parent.close()
			call b:NERDTree.render()
		end
	end
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
