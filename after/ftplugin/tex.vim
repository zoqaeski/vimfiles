" Configuration for vim-latex-suite

" No quote conversion. LaTeX does this for me.
let g:Tex_SmartKeyQuote = 0

" Compiler configuration
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_CompileRule_pdf = 'latexmk -quiet $*'
let g:Tex_CompileRule_xelatex = 'latexmk -quiet $*'
set iskeyword+=:

" Formatting and indent
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
