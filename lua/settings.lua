----------------------------------------
-- General
----------------------------------------
--
-- General configuration options for most editor behaviours.
--
----------------------------------------

local cmd = vim.cmd             -- execute Vim commands
local exec = vim.api.nvim_exec     -- execute Vimscript
local fn = vim.fn               -- call Vim functions
local g = vim.g                 -- global variables
local opt = vim.opt             -- global/buffer/windows-scoped options

g.mapleader = '\\'

------------
-- Behaviour
------------
opt.wrap = false                                     -- No wrap by default
opt.linebreak = true                                 -- Break long lines at 'breakat'
-- opt.breakat = '\ \	;:,!?'                             -- Long lines break chars
opt.startofline = false                                  -- Cursor in same column for few commands
opt.whichwrap:append {'h','l','<','>','[',']','~'}                       -- Move to following line on certain keys
opt.splitbelow = true 
opt.splitright = true                          -- Splits open bottom right
opt.switchbuf = {'useopen','usetab'}                       -- Jump to the first open window in any tab
opt.switchbuf:append {'vsplit'}                              -- Switch buffer behavior to vsplit
opt.backspace = {'indent','eol','start'}                     -- Intuitive backspacing in insert mode
opt.diffopt = {'filler','iwhite'}                          -- Diff mode: show fillers, ignore white
opt.tags = {'.git/tags','tags'}                            --
opt.showfulltag = true                                    -- Show tag and tidy search in completion
opt.complete = '.'                                     -- No wins, buffs, tags, include scanning
opt.completeopt = 'menuone'                            -- Show menu even for one item
opt.completeopt:append 'noselect'                          -- Do not select a match in the menu
opt.virtualedit = 'block'                              -- Position cursor anywhere in visual block
opt.report = 0                                       -- Always report changes for ':' commands
opt.magic = true                                          -- Always use magic regex
opt.modeline = true                                       -- Use modelines for file-specific settings
opt.modelines = 5                                    -- Look for mode lines in top- and bottommost five lines
opt.mouse = 'a'                                        -- Enable mouse in all places
opt.mousehide = true                                      -- hide when characters are typed
opt.hidden = true                                        -- Allow buffer switching without saving
opt.autoread = true                                      -- Auto reload if file saved externally
opt.fileformats:append {'unix','dos','mac'}                      -- Add mac to auto-detection of file format line endings
opt.nrformats = {'octal','hex','alpha'}                      -- Consider octal, hexadecimal and alphanumeric as numbers
opt.shortmess:append {'c'}
opt.errorbells = false
opt.visualbell = false

-- Tabs, Indentation, and Whitespace {{{
-- ---------------------------------
opt.textwidth = 0                                    -- Text width maximum chars before wrapping
opt.tabstop = 4                                      -- The number of spaces a tab is
opt.softtabstop = 4                                  -- While performing editing operations
opt.shiftwidth = 4                                   -- Number of spaces to use in auto(indent)
opt.smarttab = true                                       -- Tab insert blanks according to 'shiftwidth'
opt.autoindent = true                                     -- Use same indenting on new lines
opt.smartindent = true                                   -- Smart autoindenting on new lines
opt.expandtab = false                                    -- Don't expand tabs to spaces.
opt.shiftround = true                                    -- Round indent to multiple of 'shiftwidth'
opt.list = false                                         -- Highlight whitespace
-- }}}

-- Timing {{{
-- ------
opt.timeout = true
opt.ttimeoutlen = true
opt.timeoutlen = 1000                                -- Time out on mappings
opt.updatetime = 500                                 -- Idle time to write swap and trigger CursorHold
opt.ttimeoutlen = -1                                 -- Keycode timeout
-- }}}

-- Searching {{{
-- ---------
opt.hlsearch   = true                                   -- Highlight searches
opt.incsearch  = true                                   -- Incremental searching
opt.ignorecase = true                                   -- Ignore case for searching
opt.smartcase  = true                                   -- Do case-sensitive if there's a capital letter
opt.wrapscan   = true                                   -- Searches wrap around the end of files
opt.showmatch  = true                                   -- Jump to matching bracket
opt.matchpairs:append {'<:>'}                                -- Add HTML brackets to pair matching
opt.matchtime = 1                                    -- Tenths of a second to show the matching paren
opt.cpoptions :remove {'m'}                                   -- showmatch will wait 0.5s or until a char is typed
-- }}}

-- Wildmenu {{{
-- --------
-- if has('wildmenu')
	opt.wildmenu = true                                    -- show list for autocomplete
	opt.wildmode = {'list:longest,full'
	opt.wildoptions = 'tagfile'
	opt.wildignorecase
	opt.wildignore:append {'.hg','.git','.svn'}                    -- Version control
	opt.wildignore:append {'*.aux','*.out'}                      -- LaTeX intermediate files
	opt.wildignore:append {'*.jpg','*.bmp','*.gif','*.png','*.jpeg'}   -- binary images
	opt.wildignore:append {'*.o','*.obj','*.exe','*.dll','*.manifest'} -- compiled object files
	opt.wildignore:append {'*.spl'}                            -- compiled spelling word lists
	-- opt.wildignore:append {'*.sw?'}                          -- Don't ignore Vim swap files
	opt.wildignore:append {'.DS_Store'}                        -- OS X
	opt.wildignore:append {'*.luac'}                           -- Lua byte code
	opt.wildignore:append {'*.pyc'}                            -- Python byte code
-- endif
-- }}}

-- Session Saving {{{
-- --------------
opt.sessionoptions:remove 'blank'
opt.sessionoptions:remove 'options'
opt.sessionoptions:remove 'globals'
opt.sessionoptions:remove 'help'
opt.sessionoptions:append 'tabpages'

-- What to save for views
opt.viewoptions:remove 'options'
opt.viewoptions:remove 'unix,slash'
-- }}}

-- History Saving {{{
-- --------------
opt.history = 1000                                   -- number of command lines to remember
-- Remember things between sessions
-- '20  - remember marks for 20 previous files
-- \--50 - save 50 lines for each register
-- :50  - remember 50 items in command-line history 
-- opt.viminfo = '20,\--50,:50,/50'

-- if exists('+shada')
-- 	opt.shada = '100,f1,<50,:100,s100
-- endif
-- }}}

-- Vim Directories {{{
-- ---------------
opt.swapfile
-- opt.directory = $VARPATH/swap//
-- opt.viewdir = $VARPATH/view/
opt.spell = false 
-- opt.spellfile = '$CONFIGPATH/spell/en.utf-8.add'

-- persistent undo
if exists('+undofile')
	-- opt.undodir = $VARPATH/undo//
	opt.undofile = true
	opt.undolevels = 1000
	opt.undoreload = 10000
	-- au BufWritePre /tmp/* setlocal noundofile
endif

-- Turn Backup off: reduces clutter
if exists('+backup')
	-- opt.backupdir = '$VARPATH/backup/'
	opt.backup = false
	opt.writebackup = false
	opt.backupskip:append '/tmp'
	opt.backupskip:append '/private/tmp' -- OS X /tmp
	-- Skip backups of Git files
	opt.backupskip:append '*.git/COMMIT_EDITMSG,*.git/MERGE_MSG,*.git/TAG_EDITMSG'
	opt.backupskip:append '*.git/modules/*/COMMIT_EDITMSG,*.git/modules/*/MERGE_MSG'
	opt.backupskip:append '*.git/modules/*/TAG_EDITMSG,git-rebase-todo'
	-- Skip backups of SVN commit files
	opt.backupskip:append svn-commit*.tmp
	-- au BufWritePre * let &bex = '-' . strftime(--%Y%m%d-%H%M%S--) . '.vimbackup'
endif

-- Write swap file to disk after every 50 characters
opt.updatecount = 50
-- }}}
