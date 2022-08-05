--[[
  
    ███╗  ██╗███████╗ █████╗ ██╗   ██╗██╗███╗   ███╗
    ████╗ ██║██╔════╝██╔══██╗██║   ██║██║████╗ ████║
    ██╔██╗██║█████╗  ██║  ██║╚██╗ ██╔╝██║██╔████╔██║
    ██║╚████║██╔══╝  ██║  ██║ ╚████╔╝ ██║██║╚██╔╝██║
    ██║ ╚███║███████╗╚█████╔╝  ╚██╔╝  ██║██║ ╚═╝ ██║
    ╚═╝  ╚══╝╚══════╝ ╚════╝    ╚═╝   ╚═╝╚═╝     ╚═╝
  
  neovim init file
  Version: 2021-12-26
  Maintainer: Robbie <zoqaeski>
  Website: https://github.com/zoqaeski/vimfiles
--]]

-----------------------------------------------------------
-- Import Lua modules
-----------------------------------------------------------
--require('functions')
require('settings')
--require('interface')
require('keymaps')
require('plugins.packer')
