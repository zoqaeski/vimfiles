" Settings for NERDTree
" ---------------------

" General Settings
let g:NERDTreeWinSize = 25
let g:NERDTreeCascadeOpenSingleChildDir = 1
let g:NERDTreeCascadeSingleChildDir = 0
let g:NERDTreeShowHidden = 0
let g:NERDTreeRespectWildIgnore = 0
let g:NERDTreeAutoDeleteBuffer = 0
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeHijackNetrw = 1
let g:NERDTreeBookmarksFile = $VARPATH.'/treemarks'
let NERDTreeIgnore = [
			\ '\.git$', '\.hg$', '\.svn$', '\.stversions$', '\.pyc$', '\.svn$',
			\ '\.DS_Store$', '\.sass-cache$', '__pycache__$', '\.egg-info$'
			\ ]

"NERDTree File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
	exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
	exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

" Mappings
let g:NERDTreeMapOpenSplit = 'si'
let g:NERDTreeMapOpenVSplit = 'sv'
let g:NERDTreeMapOpenInTab = 'st'
let g:NERDTreeMapOpenInTabSilent = 'sT'
let g:NERDTreeMapUpdirKeepOpen = '<BS>'
let g:NERDTreeMapOpenRecursively = 't'
let g:NERDTreeMapCloseChildren = 'T'
let g:NERDTreeMapToggleHidden = '.'

map <Leader>t :NERDTreeToggle<CR>
nmap <Leader>f :NERDTreeFind<CR>

" Nothing below this line works… and I don't know why
" =============================================================================
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
