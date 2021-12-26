" Name: Zork
" Purpose: A colour scheme based on my Xdefaults colours. Don't ask why it's
" called Zork
" Maintainer: Robbie Smith
" Last Modified: Tuesday 10 November 2009
" TODO Fix x colours
" ================================================================

" ================================================================
" Preamble
" ================================================================

"set background=light

hi clear

if exists("syntax-on")
syntax reset
endif

let colors_name = "zork"

" General colours
" --------------
if &background == "light"
	let s:foreground=	"#1A1C20"
	"let s:background=	"#BDBEBF"
	"let s:background=	"#B6B7B8"
    "let s:background=	"#A2A4A6"
	let s:background=	"#B3AFA9"
	"let s:background=	"#959799"

	" Black
	let s:black0	=	"#1A1C20"
	let s:black1	=	"#4C5057"

	" Red
	let s:red0		=	"#B31E1E"
	let s:red1		=	"#E62727"

	" Green
	let s:green0	=	"#1A7338"
	"let s:green0	=	"#1D803E"
	let s:green1	=	"#208C44"
	"let s:green1	=	"#23994A"

	" Yellow (Orange)
	let s:yellow0	=	"#D97400"
	"let s:yellow1	=	"#E67A00"
	let s:yellow1	=	"#F28100"

	" Blue
	let s:blue0	=		"#2B5F99"
	"let s:blue1	=	"#2E67A6"
	let s:blue1	=		"#326FB3"
	"let s:blue1	=	"#3577BF"
	"let s:blue1	=	"#397FCC"
	"let s:blue1	=	"#3D87D9"
	"let s:blue1	=	"#408FE6"
	"let s:blue1	=	"#4497F3"

	" Magenta
	let s:magenta0	=	"#804079"
	let s:magenta1	=	"#994D91"

	" Cyan
	let s:cyan0		=	"#058A8C"
	"let s:cyan1	=	"#059799"
    let s:cyan1		=	"#05A4A6"
	
	" Grey/White/etc
	let s:white0	=	"#D7D4D7"
	let s:white1	=	"#EBE8EB"
	let s:cursor	=	"#858385"

else
	let s:foreground=	"#A2A4A6"
	let s:background=	"#1A1C20"

	" Black
	let s:black0	=	"#1A1C20"
	let s:black1	=	"#4C5057"

	" Red
	let s:red0		=	"#B31E1E"
	let s:red1		=	"#E62727"

	" Green
	let s:green0	=	"#23994A"
	let s:green1	=	"#28B356"

	" Yellow (Orange)
	let s:yellow0	=	"#E67A00"
	let s:yellow1	=	"#FF8800"

	" Blue
	let s:blue0		=	"#326FB3"
	let s:blue1		=	"#397FCC"

	" Magenta
	let s:magenta0	=	"#994D91"
	let s:magenta1	=	"#A6539D"

	" Cyan
	let s:cyan0		=	"#058A8C"
	let s:cyan1		=	"#05A4A6"

	" Grey/White/etc
	let s:white0	=	"#D7D4D7"
	let s:white1	=	"#EBE8EB"
	let s:cursor	=	"#858385"

endif

	let s:grey1		=	"#25282E"
	let s:grey2		=	"#30333B"
	let s:grey3		=	"#3A3E47"
	let s:grey4		=	"#444A54"
	let s:grey5		=	"#4E5561"
	let s:grey6		=	"#59606E"
	let s:grey7		=	"#636B7A"
	let s:grey8		=	"#7D7687"


" ================================================================
" Colour Mappings
" ================================================================
exe "hi Normal			guibg=".s:background."	guifg=".s:foreground.""
exe "hi Comment			gui=italic				guifg=".s:blue0."		ctermfg=darkblue"
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
exe "hi PreProc			gui=italic				guifg=".s:magenta0."	ctermfg=darkmagenta"
"exe "hi Include"
"exe "hi Define"
"exe "hi Macro"
"exe "hi PreCondit"
exe "hi Type gui=bold							guifg=".s:green0."		ctermfg=darkgreen"
"exe "hi StorageClass"
"exe "hi Structure"
"exe "hi Typedef"
exe "hi Special									guifg=".s:blue0."		ctermfg=darkblue"
"exe "hi SpecialChar"
"exe "hi Tag"
"exe "hi Delimiter"
exe "hi SpecialComment	gui=italic				guifg=".s:blue0."		ctermfg=darkblue"
"exe "hi Debug"
exe "hi Underlined		gui=underline			guifg=".s:blue0."		ctermfg=darkblue	cterm=underline"
exe "hi Ignore									guifg=".s:background."	ctermfg=black"
exe "hi Error			guibg=".s:red1."		guifg=".s:white1."		ctermfg=grey		ctermbg=lightred"
exe "hi Todo			guibg=".s:yellow1."		guifg=".s:background."	ctermfg=black		ctermbg=yellow"
exe "hi MatchParen		guibg=".s:magenta0."	guifg=".s:white0."		ctermfg=white		ctermfg=darkmagenta"

" ================================================================
" VIM's style
" ================================================================
exe "hi CursorLine		guibg=".s:background
exe "hi LineNr			guibg=".s:background."	guifg=".s:black1."		ctermfg=darkgrey"
exe "hi StatusLine		guibg=".s:yellow1."		guifg=".s:grey2."		ctermfg=yellow		ctermbg=black	cterm=bold"
exe "hi StatusLineNC	guibg=".s:grey8."		guifg=".s:grey2."		ctermfg=black		ctermbg=darkgrey"
exe "hi Pmenu			guibg=".s:grey1."		guifg=".s:white0."		ctermfg=grey	    ctermbg=black"
exe "hi PmenuSel		guibg=".s:magenta0."	guifg=".s:white1."	    ctermfg=grey        ctermbg=darkmagenta"
exe "hi Visual			guibg=".s:blue1."		guifg=".s:white1
exe "hi TabLine			guibg=".s:background."	guifg=".s:foreground."  gui=none			ctermbg=black	ctermfg=darkgreen"
exe "hi TabLineSel		guibg=".s:background."	guifg=".s:green0."		ctermfg=lightgreen	ctermbg=none"
exe "hi TabLineFill		guibg=".s:background."	guifg=".s:background."	ctermbg=black		ctermfg=none"
exe "hi Title   		                        guifg=".s:blue1."       gui=bold            ctermfg=lightblue"
exe "hi DiffAdd			guibg=".s:blue0."		guifg=".s:black0."		ctermbg=darkblue	ctermfg=black"
exe "hi DiffChange		guibg=".s:magenta0."	guifg=".s:black0."		ctermbg=darkmagenta	ctermfg=black"
exe "hi DiffDelete		guibg=".s:cyan0."		guifg=".s:black0."		ctermbg=darkcyan	ctermfg=black"
exe "hi DiffText		guibg=".s:red0."		guifg=".s:white1."		gui=bold			ctermbg=darkred	ctermfg=lightgrey"
exe "hi Folded			guibg=".s:grey1."		guifg=".s:blue1
exe "hi Question		guifg=".s:green1."		ctermfg=lightgreen"
