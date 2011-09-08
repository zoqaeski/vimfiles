" ================================================================
" Name: Tango3
" Purpose: Yet another colour scheme using the Tango colour palette.
" Maintainer: Robbie Smith
" Last Modified: Friday 25 April 2009
" ================================================================
" ================================================================
" Preamble
" ================================================================

set background=light

hi clear

if exists("syntax-on")
syntax reset
endif

let colors_name = "tango3"

" =============================================================================
" General colours
" Loosely based on the Tango pallete, although I extended it a little.
" =============================================================================

let s:butter1      = "#fce94f"
let s:orange1      = "#fcaf3e"
let s:chocolate1   = "#e9b96e"
let s:chameleon1   = "#8ae234"
let s:mint1        = "#34e28b"
let s:skyblue1     = "#729fcf"
let s:plum1        = "#ad7fa8"
let s:scarletred1  = "#ef2929"

let s:butter2     = "#edd400"
let s:orange2     = "#f57900"
let s:chocolate2  = "#c17d11"
let s:chameleon2  = "#73d216"
let s:mint2        = "#30d181"
let s:skyblue2    = "#3465a4"
let s:plum2       = "#75507b"
let s:scarletred2 = "#cc0000"

let s:butter3       = "#c4a000"
let s:orange3       = "#ce5c00"
let s:chocolate3    = "#8f5902"
let s:chameleon3    = "#4e9a06"
let s:mint3        = "#069a50"
let s:skyblue3      = "#204a87"
let s:plum3         = "#5c3566"
let s:scarletred3   = "#a40000"

let s:chameleon4    = "#397004"
let s:mint4        = "#057a40"
let s:skyblue4      = "#193b6b"

let s:mint5        = "#046133"
let s:skyblue5      = "#132b4f"

let s:white         = "#f5f5f3"
let s:grey1         = "#e6e6e4"
"let s:grey2         = "#d3d7cf"
"let s:grey3         = "#babdb6"
let s:grey4         = "#888a85"
let s:grey5         = "#555753"
let s:grey6         = "#2e3436"
let s:black         = "#16191a"

"let s:white         = "#f5f5f5"
"let s:grey1         = "#ededed"
let s:grey2         = "#c2c0c2"
"let s:grey2         = "#c6c6c6"
let s:grey3         = "#b9b9b9"
"let s:grey4         = "#878787"
"let s:grey5         = "#555555"
"let s:grey6         = "#323232"
"let s:black         = "#181818"

" =============================================================================
" Colour Mappings
" =============================================================================
exe "hi Normal guibg=".s:grey2." guifg=".s:grey6
exe "hi Comment gui=italic guifg=".s:skyblue3
exe "hi Constant guifg=".s:scarletred3
"exe "hi String"
"exe "hi Character"
"exe "hi Number"
"exe "hi Boolean"
"exe "hi Float"
exe "hi Identifier guifg=".s:mint4
"exe "hi Function"
exe "hi Statement guifg=".s:plum3
"exe "hi Conditional"
"exe "hi Repeat"
"exe "hi Label"
"exe "hi Operator"
"exe "hi Keyword"
"exe "hi Exception"
exe "hi PreProc gui=italic guifg=".s:plum2
"exe "hi Include"
"exe "hi Define"
"exe "hi Macro"
"exe "hi PreCondit"
exe "hi Type gui=bold guifg=".s:mint5
"exe "hi StorageClass"
"exe "hi Structure"
"exe "hi Typedef"
exe "hi Special guifg=".s:skyblue3
"exe "hi SpecialChar"
"exe "hi Tag"
"exe "hi Delimiter"
exe "hi SpecialComment gui=italic guifg=".s:skyblue3
"exe "hi Debug"
exe "hi Underlined guifg=".s:skyblue3
exe "hi Ignore guifg=".s:black
exe "hi Error guibg=".s:scarletred2." guifg=".s:white
exe "hi Todo guibg=".s:butter2." guifg=".s:black
exe "hi MatchParen guibg=".s:plum1." guifg=".s:grey1

" ========================================================================
" VIM's style
" ================================================================
exe "hi CursorLine guibg=".s:grey2 
exe "hi LineNr guifg=".s:orange3 
exe "hi StatusLine guibg=".s:grey2." guifg=".s:grey6 
exe "hi StatusLineNC guibg=".s:grey2." guifg=".s:grey6 
exe "hi Pmenu guibg=".s:grey6." guifg=".s:white 
exe "hi PmenuSel guibg=".s:grey5." guifg=".s:butter2 
exe "hi Visual guibg=".s:grey1

