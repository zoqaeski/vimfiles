----------------------------------------
-- Key mappings
----------------------------------------
--
-- This section is only used for key mappings that aren't associated with
-- plugin functions. I do need a way to somehow merge the mappings from the
-- plugins to here while avoiding conflicts with existing files.
--
----------------------------------------

local cmd = vim.cmd
local map = function(key)
	-- get the extra options
	local opts = { noremap = true }
	for i, v in pairs(key) do
		if type(i) == 'string' then opts[i] = v end
	end

	-- basic support for buffer-scoped keybindings
	local buffer = opts.buffer
	opts.buffer = nil

	if buffer then
		vim.api.nvim_buf_set_keymap(0, key[1], key[2], key[3], opts)
	else
		vim.api.nvim_set_keymap(key[1], key[2], key[3], opts)
	end
end

local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

_G.smart_tab = function()
	if vim.fn.pumvisible() == 1 then
		return t '<C-n>'
	else
		return t '<Tab>'
	end
end

local wk = require("which-key")

------------------------------
-- Convenient editing mappings
------------------------------
-- Change current word in a repeatable manner
map { 'n', 'cn', '*``cgn' }
map { 'n', 'cN', '*``cgN' }

---- Duplicate lines
map { 'n', 'yd', 'm`YP``' }
map { 'v', 'yd', 'YPgv' }

-- Drag current line/s vertically and auto-indent
map { 'v', 'mk', ':m-2<CR>gv=gv' }
map { 'v', 'mj', ':m\'>+<CR>gv=gv' }
map { 'n', 'mk', ':m-2<CR>' }
map { 'n', 'mj', ':m+<CR>' }

--------------------------
---- Command-line mappings
--------------------------
map { 'n', '::', 'q:' }
map { 'n', '//', 'q/' }
map { 'n', '??', 'q?' }

-- Emacs keys in command window
map { 'c', '<C-A>', '<Home>' }
map { 'c', '<C-E>', '<End>' }
map { 'c', '<C-K>', '<C-U>' }
map { 'c', '<C-P>', '<Up>' }
map { 'c', '<C-N>', '<Down>' }

-- Shortcuts
map { 'c', '$h', 'e ~/' }
map { 'c', '$c', 'e <C-\\>eCurrentFileDir("e")<CR>' }

-----------------------
-- Insert-mode mappings
-----------------------
-- Emacs mode in Insert? HERESY!!!
map { 'i', '<C-A>', '<Home>' }
map { 'i', '<C-E>', '<End>' }
map { 'i', '<C-K>', '<C-U>' }
map { 'i', '<C-b>', '<Left>' }
map { 'i', '<C-f>', '<Right>' }

vim.api.nvim_set_keymap(
	'i',
	'<Tab>',
	'v:lua.smart_tab()',
	{ noremap = true, expr = true }
)

-----------------------
-- Visual mode mappings
-----------------------
-- Use tab to indent in visual mode
map { 'v', '<Tab>', '>gv|' }
map { 'v', '<S-Tab>', '<gv' }

---- Reselect visual block after indent
map { 'v', '<', '<gv' }
map { 'v', '>', '>gv' }

----  In visual mode when you press * or # to search for the current selection
----map('v', '*', ':call VisualSearch('f')<CR>', 'silent')
----map('v', '#', ':call VisualSearch('b')<CR>', 'silent')

-- Exit Visual Mode with q
map { 'v', 'q', '<ESC>', silent = true }

-- Select last thing pasted
map { 'n', 'gV', '`[v`]' }

-- Select last thing pasted
--nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

----------------------
-- Windows and Buffers
----------------------
-- Unset s to use this key as a prefix
map { 'n', 's', '<Nop>' }
map { 'v', 's', '<Nop>' }
map { 'o', 's', '<Nop>' }

-- Opening and closing windows
map { 'n', 'si', ':<C-u>split<CR>', desc = "Split window horizontally" }
map { 'n', 'sv', ':<C-u>vsplit<CR>', desc = "Split window vertically" }
map { 'n', 'st', ':tabnew<CR>', desc = "Open new empty tab" }
map { 'n', 'so', ':<C-u>only<CR>', desc = "Close all windows but current" }
map { 'n', 'sb', ':ls<CR>', desc = "List open buffers" }
map { 'n', 'sB', ':ls<CR>:e #', desc = "List open buffers and switch" }
map { 'n', 'sT', ':ls<CR>:tabe #', desc = "List open buffers and open in new tab" }
map { 'n', 'sI', ':ls<CR>:split #', desc = "List open buffers and split horizontally" }
map { 'n', 'sV', ':ls<CR>:vsplit #', desc = "List open buffers and split vertically" }
map { 'n', 'sq', ':close<CR>', desc = "Close window" }
map { 'n', 'sQ', ':bdelete<CR>', desc = "Unload buffer" }
map { 'n', 'sh', '<C-w>h', desc = "Go to window left" }
map { 'n', 'sj', '<C-w>j', desc = "Go to window below" }
map { 'n', 'sk', '<C-w>k', desc = "Go to window above" }
map { 'n', 'sl', '<C-w>l', desc = "Go to window right" }
map { 'n', 'sH', '<C-w>H', desc = "Move window left" }
map { 'n', 'sJ', '<C-w>J', desc = "Move window below" }
map { 'n', 'sK', '<C-w>K', desc = "Move window above" }
map { 'n', 'sL', '<C-w>L', desc = "Move window right" }
map { 'n', 'ss', '<C-w>w', nowait = true, desc = "Go to next window" }
map { 'n', 'sS', '<C-w>W', nowait = true, desc = "Go to previous window" }

-- Quick moving between windows using ALT-
-- tnoremap <esc> <C-\><C-n><esc>
-- map { 't', '<A-h>', '<C-\\><C-n><C-w>h' }
-- map { 't', '<A-j>', '<C-\\><C-n><C-w>j' }
-- map { 't', '<A-k>', '<C-\\><C-n><C-w>k' }
-- map { 't', '<A-l>', '<C-\\><C-n><C-w>l' }
-- map { 'n', '<A-h>', '<C-w>h' }
-- map { 'n', '<A-j>', '<C-w>j' }
-- map { 'n', '<A-k>', '<C-w>k' }
-- map { 'n', '<A-l>', '<C-w>l' }

-- Terminal split openings
map { 'n', '<leader>ti', ':new term://zsh<CR>', desc = "New terminal split horizontally" }
map { 'n', '<leader>tv', ':vnew term://zsh<CR>', desc = "New terminal split vertically" }
map { 'n', '<leader>tt', ':tabnew term://zsh<CR>', desc = "Open terminal in new tab" }

-- Tab mappings
map { silent = true, 'n', 'g0', ':<C-u>tabfirst<CR>' }
map { silent = true, 'n', 'g$', ':<C-u>tablast<CR>' }
map { silent = true, 'n', 'g>', ':tabmove +1<CR>' }
map { silent = true, 'n', 'g<', ':tabmove -1<CR>' }
map { silent = true, 'n', 'gm', ':tabmove<CR>' }
-- let g:lasttab = 1
-- nnoremap <silent> gG :execute 'tabn '.g:lasttab<CR>

-- When pressing <Leader>cd switch to the directory of the open buffer
map { 'n', '<Leader>cd', ':lcd %:p:h<CR>:pwd<CR>', desc = "cd to directory of open buffer" }
