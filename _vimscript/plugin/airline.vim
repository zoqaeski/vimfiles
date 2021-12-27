" Settings for vim-airline
" ========================

let g:airline_powerline_fonts = 0
let g:airline_exclude_preview = 1
let g:airline_theme = 'base16'

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_section_z = '%l/%L:%c%V (%P)'

let g:airline#extensions#ale#enabled = 1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#tab_nr_type = 2
let g:airline#extensions#tabline#tabs_label = ''

let g:airline#extensions#scrollbar#enabled = 0

let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#whitespace#mixed_indent_algo = 2
let g:airline#extensions#whitespace#checks = [ 'indent', 'long', 'mixed-indent-file', 'conflicts' ]
