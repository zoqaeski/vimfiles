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
" Somewhat inspired by the bling.vim distribution at
" https://github.com/bling/dotvim
" I removed a lot of the stuff I didn't want though.
"
""""""""""""""""""""""""""""""""""""""""


" OS detection =============================================================={{{
let s:is_windows = has('win32') || has('win64')
let s:is_cygwin = has('win32unix')
let s:is_macvim = has('gui_macvim')
let g:vimHome = '~/.config/nvim' " All Configuration lies here
let g:vimLocal = '~/.local/share/nvim' " Local data
"}}}


" Setup ====================================================================={{{

if has('vim_starting')
	if &compatible
		set nocompatible
	endif

	" Reset ALL THE THINGS!!!!
	set all& 

	if s:is_windows
		set runtimepath+=~/.vim
	endif
endif

" Clear vimrc autogroup so the rest of the file can add to it
augroup vimrc
	au!
augroup END

" Set the map leader before loading bundles
let mapleader = '\'
let maplocalleader = '\'

" Key mapping helpers -------------------------------------------------------{{{

" These mappings allow plugins to "wrap" a key binding.
"
" The <Plug>(vimrc#key_base:KEY) mappings stand for the raw action
" itself. Any remappings of these mean the plugin needs to replace the action.
" For example, delimitMate will replace e.g. <Plug>(vimrc#key_base:<CR>)
" because it needs to replace the <CR> action.
"
" The <Plug>(vimrc#key:KEY) mappings are meant for plugins that want to
" conditionally perform the base action. For example, neocomplete will use
" these mappings to change behavior in some cases.
"
" A third mapping <Plug>(vimrc#key_raw:KEY) mapping is defined that types
" the given key without mappings. This can be used from base mappings.
"
" Note: By default, <BS> is imapped to <Plug>(vimrc#key:<C-h>) so plugins
" only have to remap <C-h> instead of <BS>. <Plug>(vimrc#key:<BS>) and
" <Plug>(vimrc#key_base:<BS>) still exist but are not mapped by anything.
"
" Note: We use two layers of <Plug>(vimrc#* mappings instead of just letting
" the key itself be the "filter" mapping so plugins that check whether a given
" key is mapped (such as delimitMate) will properly avoid setting a mapping on
" the key. Similarly, this is set up here before bundles are loaded to ensure
" the mappings exist.

function! s:setupMappingHelper(name)
	exe printf("inoremap <silent> <Plug>(vimrc#key_base:%s) %s", a:name, a:name)
	exe printf("inoremap <silent> <Plug>(vimrc#key_raw:%s) %s", a:name, a:name)
	exe printf("imap <silent> <Plug>(vimrc#key:%s) <Plug>(vimrc#key_base:%s)", a:name, a:name)
	exe printf("imap <silent> %s <Plug>(vimrc#key:%s)", a:name, a:name)
endfunction

call s:setupMappingHelper("<CR>")
call s:setupMappingHelper("<C-h>")
call s:setupMappingHelper("<BS>")
imap <silent> <BS> <Plug>(vimrc#key:<C-h>)
call s:setupMappingHelper("<S-BS>")
call s:setupMappingHelper("<Space>")
call s:setupMappingHelper("<Tab>")
call s:setupMappingHelper("<S-Tab>")
call s:setupMappingHelper("<C-n>")
call s:setupMappingHelper("<C-p>")
call s:setupMappingHelper("'")
call s:setupMappingHelper("<C-l>")
"}}}

" Reset the colorscheme now to avoid errors when reloading vimrc.
unlet! g:colors_name
" Turn on syntax now to ensure any appropriate autocommands run after the
" syntax file has loaded.
syntax on

" }}}

" All the things
exec "source ".g:vimHome."/functions.vim"
exec "source ".g:vimHome."/general.vim"
exec "source ".g:vimHome."/plugins.vim"
exec "source ".g:vimHome."/interface.vim"
exec "source ".g:vimHome."/keys.vim"

" Additional Settings ======================================================={{{

" Hit enter in the file browser to open the selected
" file with :vsplit to the right of the browser.
let g:netrw_browse_split = 4
let g:netrw_altv = 1

" Default to tree mode
let g:netrw_liststyle=3

" No place holders for
let g:Imap_UsePlaceHolders=0

" XML default to XHTML
let xml_use_xhtml = 1
"}}}

" vim: ft=vim fdm=marker ts=2 sts=2 sw=2 fdl=0 :
