----------------------------------------
-- Autocommands
----------------------------------------

-- Shorthand function to create autogroups
local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

-- Toggle line numbers between absolute and relative when switching modes
local number_toggle = vim.api.nvim_create_augroup("number_toggle", { clear = true })
vim.api.nvim_create_autocmd("InsertEnter", {
	group = number_toggle,
	command = "set norelativenumber"
})
vim.api.nvim_create_autocmd("InsertLeave", {
	group = number_toggle,
	command = "set relativenumber"
})

-- Close certain buffer types with q
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "checkhealth",
    "gitsigns-blame",
    "help",
    "lspinfo",
    "notify",
    "qf",
    "startuptime",
    "tsplayground",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd("close")
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = "Quit buffer",
      })
    end)
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})
-- vim: et ts=2 sts=2
