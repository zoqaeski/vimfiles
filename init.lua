--[[
                                        d8b                   888                   
                                        Y8P                   888                   
                                                              888                   
    88888b.   .d88b.   .d88b.  888  888 888 88888b.d88b.      888 888  888  8888b.  
    888 "88b d8P  Y8b d88""88b 888  888 888 888 "888 "88b     888 888  888     "88b 
    888  888 88888888 888  888 Y88  88P 888 888  888  888     888 888  888 .d888888 
    888  888 Y8b.     Y88..88P  Y8bd8P  888 888  888  888 d8b 888 Y88b 888 888  888 
    888  888  "Y8888   "Y88P"    Y88P   888 888  888  888 Y8P 888  "Y88888 "Y888888 

    Author: Robbie Smith                         
    repo  : https://github.com/zoqaeski/vimfiles 

--]]

local fn = vim.fn
local cmd = vim.cmd

-- If Packer is not installed, download it and all plugins and reload config
-- If Packer is installed, load configuration as usual
local packer_install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(packer_install_path)) > 0
then
    -- Download Packer and add it
    cmd('!git clone https://github.com/wbthomason/packer.nvim '..packer_install_path)
    cmd('packadd packer.nvim')

    -- Load plugins
    require('plugins')

    -- Automatically sync packer and restart Vim
    cmd('PackerSync')
    require('utils').create_augroup({
        {'User', 'PackerComplete', '++once', 'lua require("nvim-reload").Restart()'}
    }, 'init_reload_after_packer')
else
    -- Load plugins
    require('plugins')

    -- Load keybinds
    require('mappings')

    -- Load configuration
    require('config')

    -- Load statusline
    -- require('statusline')
end

-- vim: fdm=marker et ts=2 sts=2 sw=2 fdl=0 :
