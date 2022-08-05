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
  -- Caching of Lua files?
  -- use {'lewis6991/impatient.nvim', config = [[require('impatient')]]}

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

  --------------
  -- Language Server Plugins
  --------------
  use({"onsails/lspkind-nvim", event = "VimEnter"})
  -- auto-completion engine
  use {"hrsh7th/nvim-cmp", after = "lspkind-nvim", config = [[require('plugins.nvim-cmp')]]}

  -- nvim-cmp completion sources
  use {"hrsh7th/cmp-nvim-lsp", after = "nvim-cmp"}
  use {"hrsh7th/cmp-nvim-lua", after = "nvim-cmp"}
  use {"hrsh7th/cmp-path", after = "nvim-cmp"}
  use {"hrsh7th/cmp-buffer", after = "nvim-cmp"}
  use { "hrsh7th/cmp-omni", after = "nvim-cmp" }

  -- nvim-lsp configuration (it relies on cmp-nvim-lsp, so it should be loaded after cmp-nvim-lsp).
  use({ "neovim/nvim-lspconfig", after = "cmp-nvim-lsp", config = [[require('plugins.lsp')]] })


  -------------------------------
  -- Interface and Colour Schemes
  -------------------------------
  
  -- LuaLine instead of AirLine
  use {
    'nvim-lualine/lualine.nvim',
    event = 'VimEnter',
    config = [[require('plugins.statusline')]]
  }

  --use {
  --  'kdheepak/tabline.nvim',
  --  requires = { { 'hoob3rt/lualine.nvim', opt = true }, {'kyazdani42/nvim-web-devicons', opt = true} },
  --  config = [[require('plugins.tabline')]]
  --}
  use { 
    "akinsho/bufferline.nvim", 
    event = "VimEnter", 
    config = [[require('plugins.bufferline')]] 
  }

  -- Show match number and index for searching
  use {
    'kevinhwang91/nvim-hlslens',
    branch = 'main',
    keys = {{'n', '*'}, {'n', '#'}, {'n', 'n'}, {'n', 'N'}},
    config = [[require('plugins.hlslens')]]
  }

  -- The missing auto-completion for cmdline!
  --use({"gelguy/wilder.nvim", opt = true, setup = [[vim.cmd('packadd wilder.nvim')]]})

  use 'RRethy/nvim-base16'
  --use 'glepnir/zephyr-nvim'

  -- A list of colorscheme plugin you may want to try. Find what suits you.
  use({"lifepillar/vim-gruvbox8", opt = true})
  use({"navarasu/onedark.nvim", opt = true})
  use({"sainnhe/edge", opt = true})
  use({"sainnhe/sonokai", opt = true})
  use({"sainnhe/gruvbox-material", opt = true})
  use({"shaunsingh/nord.nvim", opt = true})
  use({"NTBBloodbath/doom-one.nvim", opt = true})
  use({"sainnhe/everforest", opt = true})
  use({"EdenEast/nightfox.nvim", opt = true})
  use({"rebelot/kanagawa.nvim", opt = true})

  ------------------
  -- Editing Plugins
  ------------------

  -- Repeat vim motions
  use({"tpope/vim-repeat", event = "VimEnter"})

  -- Asynchronous command execution
  use 'tpope/vim-dispatch'
  -- use({ "skywind3000/asyncrun.vim", opt = true, cmd = { "AsyncRun" } })

  -- Session management plugin
  use({"tpope/vim-obsession", cmd = 'Obsession'})

  -- Handy unix command inside Vim (Rename, Move etc.)
  use 'tpope/vim-eunuch'

  -- This plugin provides several pairs of bracket maps.
  use 'tpope/vim-unimpaired'

  -- Heuristically set buffer options
  use 'tpope/vim-sleuth'

  -- Automatic insertion and deletion of a pair of characters
  use({"Raimondi/delimitMate", event = "InsertEnter"})

  -- Comment plugin
  use({"tpope/vim-commentary", event = "VimEnter"})


  -- Vim tabular plugin for manipulate tabular, required by markdown plugins
  use({ "godlygeek/tabular", cmd = { "Tabularize" } })

  -- Plugin to manipulate character pairs quickly
  -- use 'tpope/vim-surround'
  use({"machakann/vim-sandwich", event = "VimEnter"})

  -- Add indent object for vim (useful for languages like Python)
  use({"michaeljsmith/vim-indent-object", event = "VimEnter"})

  -- Modern matchit implementation
  use({"andymass/vim-matchup", event = "VimEnter"})


  -----------------------------
  -- SCM (git, hg, etc) Plugins
  -----------------------------
  -- Git command inside vim
  use({ "tpope/vim-fugitive", 
    event = "User InGitRepo" ,
    cmd = { 'Git', 'Gstatus', 'Gblame', 'Gpush', 'Gpull' }
  })

  -- Better git log display
  use({ "rbong/vim-flog", requires = "tpope/vim-fugitive", cmd = { "Flog" } })

  use({ "christoomey/vim-conflicted", requires = "tpope/vim-fugitive", cmd = {"Conflicted"}})

  -------------------
  -- Filetype Plugins
  -------------------

  -- LaTeX
  use({ "lervag/vimtex", ft = { "tex" } })
  
  -- Markdown
  -- Another markdown plugin
  use({ "plasticboy/vim-markdown", ft = { "markdown" } })

  -- Faster footnote generation
  use({ "vim-pandoc/vim-markdownfootnotes", ft = { "markdown" } })

  -- Markdown JSON header highlight plugin
  use({ "elzr/vim-json", ft = { "json", "markdown" } })



  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
