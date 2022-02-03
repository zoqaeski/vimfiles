----------------------------------------
--
-- Key mappings 
--
-- This section is only used for key mappings that aren't associated with
-- plugin functions. I do need a way to somehow merge the mappings from the
-- plugins to here while avoiding conflicts with existing files.
--
----------------------------------------

local cmd = vim.cmd
local map = function(key)
  -- get the extra options
  local opts = {noremap = true}
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
    return t'<C-n>'
  else
    return t'<Tab>'
  end
end

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
map { 'v', 'mk',':m-2<CR>gv=gv' }
map { 'v', 'mj',':m\'>+<CR>gv=gv' }
map { 'n', 'mk',':m-2<CR>' }
map { 'n', 'mj',':m+<CR>' }

--------------------------
---- Command-line mappings
--------------------------
map { 'n', '::', 'q:' }
map { 'n', '//', 'q/' }
map { 'n', '??', 'q?' }

-- Emacs keys in command window
map { 'c', '<C-A>', '<Home>'}
map { 'c', '<C-E>', '<End>'}
map { 'c', '<C-K>', '<C-U>'}
map { 'c', '<C-P>', '<Up>'}
map { 'c', '<C-N>', '<Down>'}

-- Shortcuts
map { 'c', '$h', 'e ~/'}
map { 'c', '$c', 'e <C-\\>eCurrentFileDir("e")<CR>'}

-----------------------
-- Insert-mode mappings
-----------------------
-- Emacs mode in Insert? HERESY!!!
map { 'i', '<C-A>', '<Home>'}
map { 'i', '<C-E>', '<End>'}
map { 'i', '<C-K>', '<C-U>'}
map { 'i', '<C-b>', '<Left>'}
map { 'i', '<C-f>', '<Right>'}

vim.api.nvim_set_keymap(
  'i',
  '<Tab>',
  'v:lua.smart_tab()',
  {noremap = true, expr = true}
)

-----------------------
-- Visual mode mappings
-----------------------
-- Use tab to indent in visual mode
map { 'v', '<Tab>', '>gv|'}
map { 'v', '<S-Tab>', '<gv'}

---- Reselect visual block after indent
map { 'v', '<', '<gv'}
map { 'v', '>', '>gv'}

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
-- Window-control prefix
--vim.api.nvim_del_keymap('n', 's')
--vim.api.nvim_del_keymap('v', 's')
--vim.api.nvim_del_keymap('o', 's')
--cmd [[unmap s]]
map {'', 's', '[window]' , noremap = false }
map {'n', '[window]', '', silent = true }

-- Opening and closing windows
map { 'n', '[window]i', ':<C-u>split<CR>' }
map { 'n', '[window]v', ':<C-u>vsplit<CR>' }
map { 'n', '[window]t', ':tabnew<CR>' }
map { 'n', '[window]o', ':<C-u>only<CR>' }
map { 'n', '[window]b', ':ls<CR>' }
map { 'n', '[window]B', ':ls<CR>:e #' }
map { 'n', '[window]q', ':close<CR>' }
map { 'n', '[window]Q', ':bdelete<CR>' }

-- Split current buffer, go to previous window and previous buffer
map { 'n', '[window]I', ':split<CR>:wincmd p<CR>:e#<CR>' }
map { 'n', '[window]V', ':vsplit<CR>:wincmd p<CR>:e#<CR>' }

-- Moving between windows and buffers
map { 'n', '[window]h', '<C-w>h' }
map { 'n', '[window]j', '<C-w>j' }
map { 'n', '[window]k', '<C-w>k' }
map { 'n', '[window]l', '<C-w>l' }
map { 'n', '[window]s', '<C-w>w', nowait = true }
map { 'n', '[window]S', '<C-w>W', nowait = true }

map { 'n', '[window]n', ':bnext<CR>' }
map { 'n', '[window]N', ':bprevious<CR>' }

map { 'n', '[window]H', '<C-w>H' }
map { 'n', '[window]J', '<C-w>J' }
map { 'n', '[window]K', '<C-w>K' }
map { 'n', '[window]L', '<C-w>L' }

--[[
-- Window resizing
let g:resize_active=0
function! ToggleResizeMode() " {{{
	if g:resize_active == 0
		let g:resize_active = 1
		" ESC should exit
		nnoremap <ESC> :call ToggleResizeMode()<CR>
		" Switch to resize keys
		nnoremap h <C-w><
		nnoremap j <C-w>-
		nnoremap k <C-w>+
		nnoremap l <C-w>>
		" Switch to window moving keys
		nnoremap H <C-w>H
		nnoremap J <C-w>J
		nnoremap K <C-w>K
		nnoremap L <C-w>L
		nnoremap = <C-w>=
		nnoremap _ <C-w>_
		nnoremap + <C-w><bar>
		echom 'Resize Mode'
	else
		let g:resize_active = 0
		" Switch back to 'normal' keys
		nnoremap <esc> <esc>
		nnoremap h h
		nnoremap k k
		nnoremap j j
		nnoremap l l
		nnoremap K {
		nnoremap J }
		nnoremap H ^
		nnoremap L $
		nnoremap = =
		nnoremap _ _
		nnoremap + +
		echom ''
	endif
endfunction " }}}
nnoremap <silent> <Leader>r :call ToggleResizeMode()<CR>
--]]

-- Quick moving between windows using ALT-
-- tnoremap <esc> <C-\><C-n><esc>
map { 't', '<A-h>', '<C-\\><C-n><C-w>h' }
map { 't', '<A-j>', '<C-\\><C-n><C-w>j' }
map { 't', '<A-k>', '<C-\\><C-n><C-w>k' }
map { 't', '<A-l>', '<C-\\><C-n><C-w>l' }
map { 'n', '<A-h>', '<C-w>h' }
map { 'n', '<A-j>', '<C-w>j' }
map { 'n', '<A-k>', '<C-w>k' }
map { 'n', '<A-l>', '<C-w>l' }
-- Terminal split openings
-- These will eventually replaced with the terminal drawer once I reimplement it in Lua.
map {'', '<Leader>t', '[terminal]' , noremap = false }
map {'n', '[terminal]', '', silent = true }
map {'n', '[terminal]i', ':new term://zsh<CR>' }
map {'n', '[terminal]v', ':vnew term://zsh<CR>' }
map {'n', '[terminal]t', ':tabnew term://zsh<CR>' }

-- nnoremap <Leader>t           :call ToggleTerminalDrawer()<CR>
-- tnoremap <Leader>t <C-\><C-n>:call ToggleTerminalDrawer()<CR>
-- nnoremap <Leader>T  :call ToggleTerm($SHELL)<CR>

-- Tab mappings
map { silent = true, 'n', 'g0', ':<C-u>tabfirst<CR>' }
map { silent = true, 'n', 'g$', ':<C-u>tablast<CR>' }
map { silent = true, 'n', 'gn', ':<C-u>tabnext<CR>' }
map { silent = true, 'n', 'gN', ':<C-u>tabprevious<CR>' }
map { silent = true, 'n', 'g>', ':tabmove +1<CR>' }
map { silent = true, 'n', 'g<', ':tabmove -1<CR>' }
map { silent = true, 'n', 'gm', ':tabmove<CR>' }
-- let g:lasttab = 1
-- nnoremap <silent> gG :execute 'tabn '.g:lasttab<CR>

-- When pressing <Leader>cd switch to the directory of the open buffer
map { 'n', '<Leader>cd', ':lcd %:p:h<CR>:pwd<CR>' }
