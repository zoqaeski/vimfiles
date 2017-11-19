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
" Somewhat inspired by the following configurations:
"
" rafi/vim-config  https://github.com/rafi/vim-config
" bling.vim	       https://github.com/bling/dotvim
"
""""""""""""""""""""""""""""""""""""""""

if &compatible
	set nocompatible
endif

" Set main configuration directory, and where cache is stored.
let $VARPATH = expand(($XDG_DATA_HOME ? $XDG_DATA_HOME : '~/.local/share').'/nvim')
let $CONFIGPATH = expand(($XDG_CONFIG_HOME ? $XDG_CONFIG_HOME : '~/.config').'/nvim')

if ! isdirectory(expand($VARPATH))
	" Create missing dirs i.e. ~/.local/share/nvim/{undo,backup,swap}
	call mkdir(expand('$VARPATH/swap'), 'p')
	call mkdir(expand('$VARPATH/undo'))
	call mkdir(expand('$VARPATH/backup'))
endif

" This file sourcing function was adapted from rafi/vim-config
function! SourceFile(path, ...) abort
	" let use_global = get(a:000, 0, ! has('vim_starting'))
	let abspath = resolve(expand($CONFIGPATH.'/'.a:path))
	execute 'source' fnameescape(abspath)
	return

	" let content = map(readfile(abspath),
	" 	\ "substitute(v:val, '^\\W*\\zsset\\ze\\W', 'setglobal', '')")
	" let tempfile = tempname()
	" try
	" 	echo 'Trying to load:'.tempfile
	" 	call writefile(content, tempfile)
	" 	execute printf('source %s', fnameescape(tempfile))
	" finally
	" 	if filereadable(tempfile)
	" 		call delete(tempfile)
	" 	endif
	" endtry
endfunction

" Setup ====================================================================={{{

if has('vim_starting')
	" Reset ALL THE THINGS!!!!
	set all& 
endif

" Clear vimrc autogroup so the rest of the file can add to it
augroup vimrc
	au!
augroup END

" Set the map leader before loading bundles
" These should be different, but I haven't gotten around to changing them as I
" don't really use the local leader much
let g:mapleader = '\'
let g:maplocalleader = '\'

" Release keymappings prefixes, evict entirely for use of plug-ins.
nnoremap s <nop>
xnoremap s <nop>
nnoremap m <nop>
xnoremap m <nop>

" Key mapping helpers {{{
" -------------------
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

" Disable preloaded plugins {{{
" -------------------------
"  netrw
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwFileHandlers = 1
let g:loaded_netrwSettings = 1
" vimball is broked
let g:loaded_vimball = 1
let g:loaded_vimballPlugin = 1
" open zipfiles?
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1
" misc
let g:loaded_tutor_mode_plugin = 1
let g:loaded_2html_plugin = 1
" }}}

" All the things
call SourceFile('general.vim')
call SourceFile('plugins.vim')    " This sources settings specific to plugins as well
call SourceFile('interface.vim')
call SourceFile('mappings.vim')
call SourceFile('filetypes.vim') " This should be in ftplugin, but I can't make it work

" vim: ft=vim fdm=marker ts=2 sts=2 sw=2 fdl=0 :
