""""""""""""""""""""""""""""""""""""""""
" ~/.vim/ftplugin/tex.vim
"
" Sections
" -> <url:#tn=General Stuff>
" -> <url:#tn=LaTeX-box>
" -> <url:#tn=vim-latexsuite>
"  
""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""
" => General Stuff
""""""""""""""""""""""""""""""""""""""""
" Use 2 spaces for <Tab> and :retab
setlocal tabstop=2
setlocal softtabstop=2
setlocal expandtab
setlocal smarttab

" Use indents of 4 spaces
setlocal shiftwidth=2

" Smart auto-indententation
setlocal autoindent
setlocal smartindent

" Round indent to multiple of 'shiftwidth' for > and < commands
setlocal shiftround

map <F3> :w !detex \| wc -w<CR>
" nmap <leader>lx :w !xelatex %<CR>

""""""""""""""""""""""""""""""""""""""""
" => LaTeX-box
""""""""""""""""""""""""""""""""""""""""
" Citation patterns
let g:LatexBox_cite_pattern = '\c\\\a*cite\a*\*\?\_\s*{'

" Nifty mappings
imap <buffer> [[ \begin{
imap <buffer> ]] <plug>LatexCloseCurEnv
nmap <buffer> <F5> <plug>LatexChangeEnv
vmap <buffer> <F7> <plug>LatexWrapSelection
vmap <buffer> <S-F7> <plug>LatexEnvWrapSelection
imap <buffer> (( \eqref{

"setlocal formatoptions+=wa

""""""""""""""""""""""""""""""""""""""""
" => vim-latexsuite
""""""""""""""""""""""""""""""""""""""""
" Compilation Rules
let g:Tex_CompileRule_pdf='xelatex -shell-escape -interaction=nonstopmode $*'
let g:Tex_CompileRule_xelatex='xelatex -interaction=nonstopmode $*'
let g:Tex_CompileRule_xgnuplot='xelatex -shell-escape -interaction=nonstopmode $*'
"let g:Tex_CompileRule_dvi = 'latex --interaction=nonstopmode $*'
"let g:Tex_CompileRule_ps = 'dvips -Ppdf -o $*.ps $*.dvi'
"let g:Tex_CompileRule_pdf = 'ps2pdf $*.ps'
"let g:Tex_CompileRule_pdf = 'pdflatex --interaction=nonstopmode $*'
"let g:Tex_CompileRule_pdf = 'latex --interaction=nonstopmode $* && dvips -Ppdf -o $*.ps $*.dvi && ps2pdf $*.ps'

" View rules
let g:Tex_ViewRule_ps = 'evince'
let g:Tex_ViewRule_pdf = 'evince'

" Target formats
let g:Tex_DefaultTargetFormat = 'pdf'
"let g:Tex_DefaultTargetFormat = 'ps'
"let g:Tex_FormatDependency_ps = 'dvi,ps'
"let g:Tex_FormatDependency_pdf = 'dvi,ps,pdf'

" Ignore some warnings
let g:Tex_IgnoredWarnings="Font""\n"

" Solves the problems that vim-latexsuite has with ã and â. As I've replaced
" it with LaTeX-box I've commented these out to avoid any issues.
"imap <buffer> <silent> <M-C> <Plug>Tex_MathCal
"imap <buffer> <silent> <M-B> <Plug>Tex_MathBF
"imap <buffer> <leader>it <Plug>Tex_InsertItemOnThisLine
"imap <buffer> <silent> <M-A>  <Plug>Tex_InsertItem
""imap <buffer> <silent> <M-E>  <Plug>Tex_InsertItem
""imap <buffer> <silent> <M-e>  <Plug>Tex_InsertItemOnThisLine
"imap <buffer> <silent> \c <Plug>Traditional
"map <buffer> <silent> é é
"map <buffer> <silent> á á
"map <buffer> <silent> ã ã
""imap ã <Plug>Tex_MathCal
""imap é <Plug>Traditional

