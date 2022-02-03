-- This file can be loaded by calling `lua require('plugins')` from your init.vim

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]

-- Automatically compile packer plugin list on file change
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerCompile
  augroup END
]])

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  ---------------
  -- Core Plugins
  ---------------
  use {
	  'nvim-telescope/telescope.nvim',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {
	  'nvim-treesitter/nvim-treesitter',
	  run = ':TSUpdate'
  }

  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'

  -------------------------------
  -- Interface and Colour Schemes
  -------------------------------
  use 'RRethy/nvim-base16'
  use 'glepnir/zephyr-nvim'

  ------------------
  -- Editing Plugins
  ------------------
  use 'tpope/vim-repeat'
  use 'tpope/vim-dispatch'
  use 'tpope/vim-eunuch'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-sleuth'
  use 'tpope/vim-commentary'

  -----------------------------
  -- SCM (git, hg, etc) Plugins
  -----------------------------
   use {
     'tpope/vim-fugitive', 
     cmd = { 'Git', 'Gstatus', 'Gblame', 'Gpush', 'Gpull' }
   }

  -------------------
  -- Language Servers
  -------------------
  use 'neovim/nvim-lspconfig'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
