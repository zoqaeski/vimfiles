" Configuration for vim-latex-suite

" No quote conversion. LaTeX does this for me.
let g:Tex_SmartKeyQuote = 0

" Compiler configuration
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_CompileRule_pdf = 'latexmk -quiet $*'
let g:Tex_CompileRule_xelatex = 'latexmk -quiet $*'
set iskeyword+=:
