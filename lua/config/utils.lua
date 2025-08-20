--[[
    Utility functions
    =================

    Some of these were borrowed from [LunarVim](https://github.com/lunarvim/lunarvim)
--]]

local M = {}
local uv = vim.loop
local fn = vim.fn

-- inspect something
function M.inspect(item)
  vim.pretty_print(item)
end

--- Checks whether a given path exists and is a file.
--@param path (string) path to check
--@returns (bool)
function M.is_file(path)
  local stat = uv.fs_stat(path)
  return stat and stat.type == "file" or false
end

--- Checks whether a given path exists and is a directory
--@param path (string) path to check
--@returns (bool)
function M.is_directory(path)
  local stat = uv.fs_stat(path)
  return stat and stat.type == "directory" or false
end

M.join_paths = _G.join_paths

--- Checks whether a given path is executable
--@param path (string) path to check
--@returns (bool)
function M.executable(path)
  if fn.executable(path) > 0 then
    return true
  end
  return false
end

function M.may_create_dir()
  local fpath = fn.expand('<afile>')
  local parent_dir = fn.fnamemodify(fpath, ":p:h")
  local res = fn.isdirectory(parent_dir)

  if res == 0 then
    fn.mkdir(parent_dir, 'p')
  end
end

return M
