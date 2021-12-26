" Settings for FZF
" ================

" Default actions
let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-i': 'split',
      \ 'ctrl-v': 'vsplit',
      \ 'ctrl-a': 'argedit'
      \ }

" let g:fzf_layout = {"down":'~40%'}
let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }

" Jump to existing window if possible
let g:fzf_buffers_jump = 1

" Key Mappings {{{
" ------------
nmap <Space> [fzf]
nnoremap [fzf] <nop>

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

imap <C-x><C-l> <plug>(fzf-complete-line)
imap <c-x><c-k> <plug>(fzf-complete-word)

nnoremap [fzf]p     :FZFMru<CR>
" Files in the current directory
nnoremap [fzf]<S-p> :Files<CR>
" Files in the current buffer's directory except for scm
" nnoremap [fzf]d :call <SID>fzf('find -L . -type f ! -path "*.hg/*" ! -path "*.git/*"', ':Files %:p:h') <CR>
nnoremap [fzf]d :call <SID>fzf('fd -L', ':Files %:p:h') <CR>
" All files in the home directory execpt for scm
nnoremap [fzf]f :Files ~<CR>
" nnoremap [fzf]a :call <SID>fzf('find -L . -type f ! -path "*.hg/*" ! -path "*.git/*"', ':Files ~') <CR>
nnoremap [fzf]a :call <SID>fzf('fd -L -H', ':Files ~') <CR>
nnoremap [fzf]g :GitFiles<CR>
" Files in a specific directory
nnoremap [fzf]<s-f> :Files<Space>
" Lines in the current buffer
nnoremap [fzf]l :BLines<CR>
" Lines in all buffers
nnoremap [fzf]<S-l> :Lines<CR>
" Searching with ripgrep
nnoremap [fzf]r :Rg<CR>
nnoremap [fzf]R :Rg<Space>
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
" }}}

" Colour scheme {{{
" -------------
" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
" }}}

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

" vim: ft=vim fdm=marker ts=2 sts=2 sw=2 fdl=0 :
