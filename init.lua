--[[
  
    ███╗  ██╗███████╗ █████╗ ██╗   ██╗██╗███╗   ███╗
    ████╗ ██║██╔════╝██╔══██╗██║   ██║██║████╗ ████║
    ██╔██╗██║█████╗  ██║  ██║╚██╗ ██╔╝██║██╔████╔██║
    ██║╚████║██╔══╝  ██║  ██║ ╚████╔╝ ██║██║╚██╔╝██║
    ██║ ╚███║███████╗╚█████╔╝  ╚██╔╝  ██║██║ ╚═╝ ██║
    ╚═╝  ╚══╝╚══════╝ ╚════╝    ╚═╝   ╚═╝╚═╝     ╚═╝
  
  neovim init file
  Version: 2025-08
  Maintainer: Robbie <zoqaeski>
  Website: https://github.com/zoqaeski/vimfiles

  Some of the configuration here was based off LazyVim
  (https://github.com/LazyVim/LazyVim) — I didn't want to use LazyVim directly, but
  there are a lot of useful things in the configs that I could learn from.
--]]

-----------------------------------------------------------
-- Import Lua modules
-----------------------------------------------------------
require('config.options')
require('config.lazy')
require('config.keymaps')
require('config.autocommands')

vim.cmd('colorscheme tokyonight')
