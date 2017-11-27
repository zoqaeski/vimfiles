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
" Plugins
"
" This section contains all plugins and their associated sections. 
"
" Plugins that contain a lot of settings (for the moment NERDTree, FZF, and
" Lightline) source their own configurations
"
""""""""""""""""""""""""""""""""""""""""

call plug#begin()

" Core Plugins --------------------------------------------------------------{{{

Plug 'Shougo/vimproc', {
			\ 'do' : 'make'
			\ }

" Better language support? Disabled for now
" THIS CONFLICTS WITH MANY THINGS. HERE BE DRAGONS
" Plug 'sheerun/vim-polyglot'
  " let g:polyglot_disabled = ['latex']

"}}}

" Status line plugins -------------------------------------------------------{{{
" Supposedly better status lines. If nothing else, they're certainly pretty.
" Need to set noshowmode to hide it as the statusline updates

Plug 'itchyny/lightline.vim'
" A light and configurable statusline/tabline plugin for Vim
call SourceFile('plugins/lightline.vim')

" }}}

" Editing plugins -----------------------------------------------------------{{{

"Plug 'terryma/vim-expand-region'
"Plug 'terryma/vim-multiple-cursors'
Plug 'godlygeek/tabular' 

" Yankstack.vim is a lightweight implementation of the Emacs 'kill ring' for
" Vim. 
" Plug 'maxbrunsfeld/vim-yankstack'

Plug 'vim-scripts/matchit.zip'

" Plug 'machakann/vim-sandwich'
Plug 'tpope/vim-surround'
		augroup latexSurround
			autocmd!
			autocmd FileType tex call s:latexSurround()
		augroup END

		function! s:latexSurround()
			let b:surround_{char2nr("e")}
						\ = "\\begin{\1environment: \1}\n\t\r\n\\end{\1\1}"
			let b:surround_{char2nr("c")} = "\\\1command: \1{\r}"
		endfunction

Plug 'kana/vim-repeat'
" Plug 'tpope/vim-repeat'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-commentary'

Plug 'junegunn/vim-peekaboo'

Plug 'easymotion/vim-easymotion'

"}}}

" SCM (git, hg, etc) plugins ------------------------------------------------{{{

Plug 'tpope/vim-fugitive', { 'augroup' : 'fugitive'}
" Git wrapper with many many many features, some of which I will probably
" never use because I'm terrible at using Git.

	nnoremap <Leader>gs :Gstatus<CR>
	nnoremap <Leader>gd :Gdiff<CR>
	nnoremap <Leader>gc :Gcommit<CR>
	nnoremap <Leader>gb :Gblame<CR>
	nnoremap <Leader>gl :Glog<CR>
	nnoremap <Leader>gp :Git push<CR>
	nnoremap <Leader>gw :Gwrite<CR>
	nnoremap <Leader>gr :Gremove<CR>
	autocmd FileType gitcommit nmap <buffer> U :Git checkout -- <C-r><C-g><CR>
	autocmd BufReadPost fugitive://* set bufhidden=delete

Plug 'tpope/vim-rhubarb', { 'depends' : 'tpope/vim-fugitive' }
" If fugitive.vim is the Git, rhubarb.vim is the Hub. Here's the full list of
" features: 
" - Enables :Gbrowse from fugitive.vim to open GitHub URLs.  
" - Sets up :Git to use hub if installed rather than git.
" - In commit messages, GitHub issues, issue URLs, and collaborators can be
"   omni-completed (<C-X><C-O>, see :help compl-omni). This makes inserting
"   those Closes #123 remarks slightly easier than copying and pasting from
"   the browser.
Plug 'tpope/vim-git'

"}}}

" Navigation plugins --------------------------------------------------------{{{

" FZF is a fast fuzzy finder. TODO: Add some means of caching filesystem
" searches.
Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
Plug 'junegunn/fzf.vim'
call SourceFile('plugins/fzf.vim')

Plug 'mileszs/ack.vim' 
		let g:ackprg = 'ag --nogroup --nocolor --column'

" Always load NERDTree (on-demand loading prevents it from
" stealing focus from netrw)
Plug 'scrooloose/nerdtree'
" NERDTree API settings are in after/plugin/NERDTree.vim, other settings are in
" plugins/NERDTree.vim
call SourceFile('plugins/NERDTree.vim')

Plug 'MattesGroeger/vim-bookmarks'
call SourceFile('plugins/vim-bookmarks.vim')

"}}}

" Completion plugins -------------------------------------------------------{{{

Plug 'Shougo/deoplete.nvim', { 'do' : ':UpdateRemotePlugins' }
	let g:deoplete#enable_at_startup = 0
  let g:deoplete#complete_method = 'completefunc'

Plug 'mattn/emmet-vim'
		let g:user_emmet_mode='a'

""}}}

" LaTeX plugins -------------------------------------------------------------{{{

" VimTex
Plug 'lervag/vimtex'
		let g:tex_flavor = 'latex'
    let g:vimtex_fold_enabled = 1
		let g:vimtex_compiler_method = 'arara'
		let g:vimtex_quickfix_enabled = 1

		let g:vimtex_compiler_arara = {
					\ 'backend' : 'nvim',
					\ 'background' : 1,
					\ 'options' : ['--log'],
					\}

		" Not sure how to get this to work
		" if !exists('g:deoplete#omni#input_patterns')
		" 	let g:deoplete#omni#input_patterns = {}
		" endif
		" let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete

"}}}

" Web Plugins ---------------------------------------------------------------{{{
" -nil-
" }}}

" Python Plugins ------------------------------------------------------------{{{
"Plug 'klen/python-mode', {'autoload':{'filetypes':['python']}}
"let g:pymode_rope=0
"}}}

" Haskell Plugins -----------------------------------------------------------{{{

Plug 'dag/vim2hs', { 'for' : 'haskell' }
Plug 'lukerandall/haskellmode-vim', { 'for' : 'haskell' }
Plug 'eagletmt/ghcmod-vim', { 'for' : 'haskell' }
Plug 'eagletmt/neco-ghc', { 'for' : 'haskell' }
"Plug 'travitch/hasksyn', { 'for' : 'haskell' }

"}}}

" Lua {{{
" ---
Plug 'tbastos/vim-lua', { 'for': 'lua' }

" }}}

" Other plugins -------------------------------------------------------------{{{

Plug 'plasticboy/vim-markdown', { 'for' : 'markdown' }

"Plug 'wincent/terminus'
"Plug 'ashisha/image.vim', { 'disabled' : !has('python') }
Plug 'mhinz/vim-sayonara'
" Quit with 'q', and make macros use 'Q'
nnoremap <silent> q :Sayonara<CR>
nnoremap Q q
nnoremap gQ @q


Plug 'gorodinskiy/vim-coloresque'

Plug 'chriskempson/base16-vim'

Plug 'mattn/gist-vim', {'depends': 'mattn/webapi-vim'}

" Not sure what this plugin does, so it's being commented out for the time
" being.
" Plug 'tmux-plugins/vim-tmux'

Plug 'xolox/vim-session', {'depends': 'xolox/vim-misc'}
		set sessionoptions=blank,buffers,curdir,folds,resize,tabpages,winpos,winsize
		let g:session_autosave = 'yes'
		let g:session_autoload = 'no'
		let g:session_command_aliases = 1

" Required by other xolox	plugins. Made into a dependency for vim-session
" above.
Plug 'xolox/vim-misc'


"Plug 'scrooloose/syntastic' 
"let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': [], 'passive_filetypes': [] }
"let g:syntastic_quiet_warnings=1
"Plug 'xolox/vim-notes'
"let g:notes_directories = ['~/documents/notes', '~/documents/work']
"let g:notes_suffix = '.txt'
"Plug 'tpope/vim-abolish'
"Plug 'tpope/vim-haml'
"Plug 'tpope/vim-ragtag'

Plug 'rhysd/accelerated-jk'
	nmap j <Plug>(accelerated_jk_gj)
	nmap k <Plug>(accelerated_jk_gk)


"}}}

call plug#end()

" vim: ft=vim fdm=marker ts=2 sts=2 sw=2 fdl=0 :
