" Name: ZXTC
" Purpose: A colour scheme based on my Xfce4-terminal theme
" Maintainer: Robbie Smith
" Last Modified: Tuesday 10 November 2009
" TODO Fix x colours
" ================================================================

" ================================================================
" Preamble
" ================================================================

set background=light

hi clear

if exists("syntax-on")
syntax reset
endif

let colors_name = "zxtc"

" General colours
" Loosely based on the Tango pallete, although I extended it a little.
" --------------

let s:foreground    = "#202426"
let s:background    = "#B6B7B8"
                              
let s:black0        = "#202426"
let s:red0          = "#B80000"
let s:green0        = "#046624"
let s:yellow0       = "#D67200"
let s:blue0         = "#193B6B"
let s:magenta0      = "#5C3F61"
let s:cyan0         = "#036466"
let s:white0        = "#D7D4D7"
                              
let s:black1        = "#555753"
let s:red1          = "#E62727"
let s:green1        = "#23994A"
let s:yellow1       = "#F28100"
let s:blue1         = "#547599"
let s:magenta1      = "#946D90"
let s:cyan1         = "#059799"
let s:white1        = "#EBE8EB"

" ================================================================
" Colour Mappings
" ================================================================
exe "hi Normal			guibg=".s:background."	guifg=".s:foreground.""
exe "hi Comment			gui=italic				guifg=".s:blue1."		ctermfg=lightblue"
exe "hi Constant								guifg=".s:red0."		ctermfg=darkred"
"exe "hi String"
"exe "hi Character"
"exe "hi Number"
"exe "hi Boolean"
"exe "hi Float"
exe "hi Identifier								guifg=".s:green0."		ctermfg=darkgreen"
"exe "hi Function"
exe "hi Statement								guifg=".s:magenta0."	ctermfg=darkmagenta"
"exe "hi Conditional"
"exe "hi Repeat"
"exe "hi Label"
"exe "hi Operator"
"exe "hi Keyword"
"exe "hi Exception"
exe "hi PreProc			gui=italic				guifg=".s:magenta0."	ctermfg=lightmagenta"
"exe "hi Include"
"exe "hi Define"
"exe "hi Macro"
"exe "hi PreCondit"
exe "hi Type gui=bold							guifg=".s:green0."		ctermfg=darkgreen"
"exe "hi StorageClass"
"exe "hi Structure"
"exe "hi Typedef"
exe "hi Special									guifg=".s:blue1."		ctermfg=darkblue"
"exe "hi SpecialChar"
"exe "hi Tag"
"exe "hi Delimiter"
exe "hi SpecialComment	gui=italic				guifg=".s:blue1."		ctermfg=lightblue"
"exe "hi Debug"
exe "hi Underlined		gui=underline			guifg=".s:blue1."		ctermfg=lightblue	cterm=underline"
exe "hi Ignore									guifg=".s:black0."		ctermfg=black"
exe "hi Error			guibg=".s:red1."		guifg=".s:white1."		ctermfg=grey		ctermbg=lightred"
exe "hi Todo			guibg=".s:yellow1."		guifg=".s:black0."		ctermfg=black		ctermbg=yellow"
exe "hi MatchParen		guibg=".s:magenta0."	guifg=".s:white0."		ctermfg=white		ctermfg=darkmagenta"

" ================================================================
" VIM's style
" ================================================================
exe "hi CursorLine		guibg=".s:background
exe "hi LineNr			guibg=".s:background."	guifg=".s:yellow0."		ctermfg=darkyellow"
exe "hi StatusLine		guibg=".s:white0."		guifg=".s:black0 
exe "hi StatusLineNC	guibg=".s:white0."		guifg=".s:black0."		ctermfg=grey		ctermbg=black"
exe "hi Pmenu			guibg=".s:black0."		guifg=".s:white0."		ctermfg=grey	    ctermbg=black"
exe "hi PmenuSel		guibg=".s:magenta0."	guifg=".s:white1."	    ctermfg=grey        ctermbg=darkmagenta"
exe "hi Visual			guibg=".s:white0

