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
local map = vim.keymap.set

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

_G.smart_tab = function()
  if vim.fn.pumvisible() == 1 then
    return t("<C-n>")
  else
    return t("<Tab>")
  end
end

local wk = require("which-key")

------------------------------
-- Convenient editing mappings
------------------------------
-- Change current word in a repeatable manner
map("n", "cn", "*``cgn")
map("n", "cN", "*``cgN")

---- Duplicate lines
map("n", "yd", "m`YP``")
map("v", "yd", "YPgv")

-- Drag current line/s vertically and auto-indent
map("v", "mk", "<cmd>m-2<CR>gv=gv")
map("v", "mj", "<cmd>m'>+<CR>gv=gv")
map("n", "mk", "<cmd>m-2<CR>")
map("n", "mj", "<cmd>m+<CR>")

-- Better up/down movement
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- commenting
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcl<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcl<cr>fxa<bs>", { desc = "Add Comment Above" })

--------------------------
---- Command-line mappings
--------------------------
map("n", "::", "q:")
map("n", "//", "q/")
map("n", "??", "q?")

-- Emacs keys in command window
map("c", "<C-A>", "<Home>")
map("c", "<C-E>", "<End>")
map("c", "<C-K>", "<C-U>")
map("c", "<C-P>", "<Up>")
map("c", "<C-N>", "<Down>")

-- Shortcuts
map("c", "$h", "~/")
-- map({ "c", "$c", 'e <C-\\>eCurrentFileDir("e")<CR>' })

-----------------------
-- Insert-mode mappings
-----------------------
map("i", "<C-A>", "<Home>")
map("i", "<C-E>", "<End>")
map("i", "<C-K>", "<C-U>")
map("i", "<C-b>", "<Left>")
map("i", "<C-f>", "<Right>")

map("i", "<Tab>", "v:lua.smart_tab()", { expr = true })

-----------------------
-- Visual mode mappings
-----------------------
-- Use tab to indent in visual mode
map("v", "<Tab>", ">gv|")
map("v", "<S-Tab>", "<gv")

---- Reselect visual block after indent
map("v", "<", "<gv")
map("v", ">", ">gv")

----  In visual mode when you press * or # to search for the current selection
----map('v', '*', ':call VisualSearch('f')<CR>', 'silent')
----map('v', '#', ':call VisualSearch('b')<CR>', 'silent')

-- Exit Visual Mode with q
map("v", "q", "<ESC>", { silent = true })

map("n", "gV", "`[v`]", { desc = "Select last thing pasted" })

-- Select last thing pasted
--nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

----------------------
-- Windows and Buffers
----------------------
-- Unset s to use this key as a prefix
map("n", "s", "<Nop>")
map("v", "s", "<Nop>")
map("o", "s", "<Nop>")

-- Opening and closing windows
map("n", "<leader>ws", "<cmd>split<CR>", { desc = "Split window horizontally" })
map("n", "<leader>wv", "<cmd>vsplit<CR>", { desc = "Split window vertically" })
map("n", "<leader>wt", "<cmd>wincmd t<CR>", { desc = "Move buffer to new tab" })
map("n", "<leader>wo", "<cmd>only<CR>", { desc = "Close all windows but current" })
map("n", "<leader>wq", "<cmd>close<CR>", { desc = "Close window" })
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

-- Moving between windows
map("n", "<leader>wh", "<cmd>wincmd h<CR>", { desc = "Go to window left" })
map("n", "<leader>wj", "<cmd>wincmd j<CR>", { desc = "Go to window below" })
map("n", "<leader>wk", "<cmd>wincmd k<CR>", { desc = "Go to window above" })
map("n", "<leader>wl", "<cmd>wincmd l<CR>", { desc = "Go to window right" })
map("n", "<leader>ww", "<cmd>wincmd w<CR>", { desc = "Go to next window", nowait = true })
map("n", "<leader>wW", "<cmd>wincmd W<CR>", { desc = "Go to previous window", nowait = true })
-- Resizing windows
map("n", "<leader>wH", "<cmd>wincmd H<CR>", { desc = "Move window left" })
map("n", "<leader>wJ", "<cmd>wincmd J<CR>", { desc = "Move window below" })
map("n", "<leader>wK", "<cmd>wincmd K<CR>", { desc = "Move window above" })
map("n", "<leader>wL", "<cmd>wincmd L<CR>", { desc = "Move window right" })
map("n", "<leader>w=", "<cmd>wincmd =<CR>", { desc = "Equally high and wide" })
map("n", "<leader>w_", "<cmd>wincmd _<CR>", { desc = "Max out the height" })
map("n", "<leader>w|", "<cmd>wincmd |<CR>", { desc = "Max out the width" })

-- Buffers
map("n", "<leader>bd", function()
  Snacks.bufdelete()
end, { desc = "Delete buffer" })
map("n", "<leader>bD", "<cmd>bdelete<CR>", { desc = "Delete buffer and window" })
map("n", "<leader>bb", "<cmd>ls<CR>", { desc = "List open buffers" })
map("n", "<leader>bB", ":ls<CR><cmd>e #", { desc = "List open buffers and switch" })
map("n", "<leader>bt", ":ls<CR><cmd>tabe #", { desc = "List open buffers and open in new tab" })
map("n", "<leader>bs", ":ls<CR><cmd>split #", { desc = "List open buffers and split horizontally" })
map("n", "<leader>bv", ":ls<CR><cmd>vsplit #", { desc = "List open buffers and split vertically" })
map("n", "]b", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "[b", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "gb", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "gB", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- Terminal split openings - these are not necessary with snacks.nvim
-- map("n", "<leader>t", "<cmd>new term://zsh<CR>", { desc = "New terminal split horizontally" })
-- map("n", "<leader>tv", "<cmd>vnew term://zsh<CR>", { desc = "New terminal split vertically" })
-- map("n", "<leader>tt", "<cmd>tabnew term://zsh<CR>", { desc = "Open terminal in new tab" })

-- Tab mappings
map("n", "<leader><tab>0", "<cmd>tabfirst<CR>", { silent = true })
map("n", "<leader><tab>$", "<cmd>tablast<CR>", { silent = true })
map("n", "<leader><tab>>", "<cmd>tabmove +1<CR>", { silent = true })
map("n", "<leader><tab><", "<cmd>tabmove -1<CR>", { silent = true })
map("n", "<leader><tab>m", "<cmd>tabmove<CR>", { silent = true })
map("n", "<leader><tab>]", "<cmd>tabnext<CR>", { desc = "Next tab" })
map("n", "<leader><tab>[", "<cmd>tabprev<CR>", { desc = "Previous tab" })
-- let g:lasttab = 1
-- nnoremap <silent> gG :execute 'tabn '.g:lasttab<CR>

-- When pressing <LocalLeader>cd switch to the directory of the open buffer
map("n", "<LocalLeader>cd", "<cmd>lcd %:p:h<CR><cmd>pwd<CR>", { desc = "cd to directory of open buffer" })

-- diagnostic (taken from LazyVim)
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- Toggle UI options
Snacks.toggle.zen():map("<leader>uz")
Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
Snacks.toggle.option("cursorline", { name = "Cursor Line" }):map("<leader>ul")
Snacks.toggle.option("cursorcolumn", { name = "Cursor Column" }):map("<leader>uc")
