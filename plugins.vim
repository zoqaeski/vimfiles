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
" This section contains all plugins and their associated sections. Whilst I
" could split it into individual files, that seems like a lot of effort.
"
""""""""""""""""""""""""""""""""""""""""

call plug#begin()

" Core Plugins --------------------------------------------------------------{{{

Plug 'Shougo/vimproc', {
			\ 'do' : 'make'
			\ }
"}}}

" Editing plugins -----------------------------------------------------------{{{

"Plug 'terryma/vim-expand-region'
"Plug 'terryma/vim-multiple-cursors'
Plug 'tomtom/tcomment_vim'
Plug 'godlygeek/tabular' 

" Plug 'vim-scripts/YankRing.vim'
" 		let g:yankring_max_history = 100
" 		let g:yankring_max_display = 200
" 		let g:yankring_min_element_length = 1
" 		let g:yankring_ignore_operator = 'g~ gu gU ! = gq g? > < zf g@'
" 		let g:yankring_history_dir = g:vimLocal
" 		let g:yankring_history_file = 'yankring_history'
" 		let g:yankring_replace_n_pkey = '<M-p>'
" 		let g:yankring_replace_n_nkey = '<M-n>'
" 		nnoremap Y :<C-U>YRYankCount 'y$'<CR>
" 		noremap <Leader>y :YRShow<CR>
"}}}
Plug 'maxbrunsfeld/vim-yankstack'

" SCM (git, hg, etc) plugins ------------------------------------------------{{{

Plug 'tpope/vim-fugitive', { 'augroup' : 'fugitive'}
		nnoremap <silent> <leader>gs :Gstatus<CR>
		nnoremap <silent> <leader>gd :Gdiff<CR>
		nnoremap <silent> <leader>gc :Gcommit<CR>
		nnoremap <silent> <leader>gb :Gblame<CR>
		nnoremap <silent> <leader>gl :Glog<CR>
		nnoremap <silent> <leader>gp :Git push<CR>
		nnoremap <silent> <leader>gw :Gwrite<CR>
		nnoremap <silent> <leader>gr :Gremove<CR>
		autocmd FileType gitcommit nmap <buffer> U :Git checkout -- <C-r><C-g><CR>
		autocmd BufReadPost fugitive://* set bufhidden=delete

"}}}

" Navigation plugins --------------------------------------------------------{{{

Plug 'mileszs/ack.vim' 
		let g:ackprg = 'ag --nogroup --nocolor --column'
"}}}

" NERDTree ------------------------------------------------------------------{{{

" Disable netrw as it is annoying
" let g:loaded_netrw       = 1
" let g:loaded_netrwPlugin = 1

" Better fix: always load NERDTree (on-demand loading prevents it from
" stealing focus from netrw)
" Plug 'scrooloose/nerdtree', { 'on' : 'NERDTreeToggle', 'augroup' : 'NERDTreeHijackNetrw' }
Plug 'scrooloose/nerdtree'
		map <C-\><C-t> :NERDTreeToggle<CR>
		"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
		let NERDTreeShowHidden=1
		let g:NERDTreeWinSize=45
		let g:NERDTreeAutoDeleteBuffer=1

		"NERDTree File highlighting
		function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
			exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
			exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
		endfunction
"}}}

" Completion plugins -------------------------------------------------------{{{

Plug 'Shougo/deoplete.nvim', { 'do' : ':UpdateRemotePlugins' }

Plug 'mattn/emmet-vim'
		let g:user_emmet_mode='a'

""}}}

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

" LaTeX plugins -------------------------------------------------------------{{{
" Plug 'LaTeX-Box-Team/LaTeX-Box', {'for' : ['tex']}
" 		let g:LatexBox_latexmk_async = 1
" 		let g:LatexBox_latexmk_preview_continuously = 1
" 		let g:LatexBox_quickfix = 2
" 		let g:LatexBox_show_warnings = 0
" 		let g:LatexBox_Folding = 1
" 		let g:tex_flavor = 'latex'
" 		let g:tex_gotoerror = 0
" 		" Mappings
" 		imap <buffer> [[     \begin{
" 		imap <buffer> ]]     <Plug>LatexCloseCurEnv
" 		nmap <buffer> <F5>   <Plug>LatexChangeEnv
" 		vmap <buffer> <F7>   <Plug>LatexWrapSelection
" 		vmap <buffer> <S-F7> <Plug>LatexEnvWrapSelection
" 		imap <buffer> ((     \eqref{
Plug 'lervag/vimtex', {'for' : ['tex', 'latex']}
		let g:tex_flavor = 'latex'
    let g:vimtex_format_enabled = 0
    let g:vimtex_fold_enabled = 1
    let g:vimtex_latexmk_background = 1
		let g:vimtex_view_method = 'general'
" Plug 'git://vim-latex.git.sourceforge.net/gitroot/vim-latex/vim-latex'
"}}}

" Other plugins -------------------------------------------------------------{{{
Plug 'matchit.zip'
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
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-unimpaired'
"Plug 'wincent/terminus'
Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
Plug 'junegunn/fzf.vim'
let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-i': 'split',
      \ 'ctrl-v': 'vsplit',
      \ 'ctrl-a': 'argedit',
      \ 'ctrl-o': '!runa'
      \ }

let g:fzf_layout = {"down":'~40%'}

" Jump to existing window if possible
let g:fzf_buffers_jump = 1

nmap <c-p> [fzf]
nnoremap [fzf] <nop>

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

imap <C-x><C-l> <plug>(fzf-complete-line)
imap <c-x><c-k> <plug>(fzf-complete-word)

" Files in the current directory
nnoremap [fzf]p :Files<CR>
" Files in the current buffer's directory except for scm
nnoremap [fzf]d :call <SID>fzf('find -L . -type f ! -path "*.hg/*" ! -path "*.git/*"', ':Files %:p:h') <CR>
" All files in the home directory execpt for scm
nnoremap [fzf]f :Files ~<CR>
nnoremap [fzf]a :call <SID>fzf('find -L . -type f ! -path "*.hg/*" ! -path "*.git/*"', ':Files ~') <CR>
nnoremap [fzf]g :GitFiles<CR>
" Lines in the current buffer
nnoremap [fzf]l :BLines<CR>
" Lines in all buffers
nnoremap [fzf]<S-l> :Lines<CR>
" Switch between windows
nnoremap [fzf]w :Windows<CR>
" Switch between buffers
nnoremap [fzf]b :Buffers<CR>
" Search history
nnoremap [fzf]h :History<CR>
nnoremap [fzf]; :History:<CR>
nnoremap [fzf]/ :History/<CR>
" Snippets, tags and marks
nnoremap [fzf]s :Snippets<CR>
nnoremap [fzf]t :Tags<CR>
nnoremap [fzf]j :BTags<CR>
nnoremap [fzf]m :Marks<CR>

nnoremap [fzf]: :Commands<CR>
nnoremap [fzf]<S-c> :Colors<CR>
nnoremap [fzf]<S-m> :Maps<CR>
nnoremap [fzf]<S-h> :Helptags<CR>
command! -nargs=* -complete=file Ae :call s:fzf_ag_expand(<q-args>)

let s:fzf_btags_cmd = 'ctags -f - --sort=no --excmd=number --c++-kinds=+p '
let s:fzf_btags_options = {'options' : '--reverse -m -d "\t" --with-nth 1,4.. -n 1,-1 --prompt "BTags> "'}

function! s:fzf(fzf_default_cmd, cmd)
  let oldcmds = $FZF_DEFAULT_COMMAND | try
    let $FZF_DEFAULT_COMMAND = a:fzf_default_cmd
    execute a:cmd
  finally | let $FZF_DEFAULT_COMMAND = oldcmds | endtry
endfunction

function! s:fzf_ag_raw(cmd)
  call fzf#vim#ag_raw('--noheading '. a:cmd)
endfunction

" Some paths are ignored by git or hg; I need to use absolute path to avoid that.
function! s:fzf_ag_expand(cmd)
  let matches = matchlist(a:cmd, '\v(.{-})(\S*)\s*$')
  " readlink, remove trailing linebreak
  let ecmd = matches[1] . system("readlink -f " . matches[2])[0:-2]
  call s:fzf_ag_raw(ecmd)
endfunction

"Plug 'ashisha/image.vim', { 'disabled' : !has('python') }
Plug 'mhinz/vim-sayonara'
		nnoremap <silent> Q :Sayonara<CR>
Plug 'gorodinskiy/vim-coloresque'
Plug 'chriskempson/base16-vim'
Plug 'mattn/gist-vim', {'depends': 'mattn/webapi-vim'}

" This plugin isn't needed because I've done the necessary mappings in my
" tmux.conf
" Plug 'christoomey/vim-tmux-navigator', { 'disabled' : 1 }
" 		let g:tmux_navigator_no_mappings = 1
" 		nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
" 		nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
" 		nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
" 		nnoremap <silent> <C-h> :TmuxNavigateLeft<CR>
" 		nnoremap <silent> <C-;> :TmuxNavigatePrevious<cr>
" 		tmap <C-j> <C-\><C-n>:TmuxNavigateDown<cr>
" 		tmap <C-k> <C-\><C-n>:TmuxNavigateUp<cr>
" 		tmap <C-l> <C-\><C-n>:TmuxNavigateRight<cr>
" 		tmap <C-h> <C-\><C-n>:TmuxNavigateLeft<CR>
" 		tmap <C-;> <C-\><C-n>:TmuxNavigatePrevious<cr>
Plug 'tmux-plugins/vim-tmux'

Plug 'xolox/vim-session'
		set sessionoptions=blank,buffers,curdir,folds,resize,tabpages,winpos,winsize
		let g:session_autosave = 'yes'
		let g:session_autoload = 'no'
		let g:session_command_aliases = 1

Plug 'xolox/vim-misc'
Plug 'tpope/vim-markdown', { 'for' : 'markdown' }
"Plug 'scrooloose/syntastic' 
"let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': [], 'passive_filetypes': [] }
"let g:syntastic_quiet_warnings=1
"Plug 'xolox/vim-notes'
"let g:notes_directories = ['~/documents/notes', '~/documents/work']
"let g:notes_suffix = '.txt'
"Plug 'tpope/vim-abolish'
"Plug 'tpope/vim-haml'
"Plug 'tpope/vim-ragtag'
"}}}

call plug#end()

" vim: ft=vim fdm=marker ts=2 sts=2 sw=2 fdl=0 :
