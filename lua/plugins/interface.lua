----------------------------------------
-- Interface
----------------------------------------
--
-- Plugins that configure the interface (statusline, tabs, buffers, etc)
--
----------------------------------------
return {
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      options = {
        numbers = "none",
        show_tab_indicators = true,
        persist_buffer_sort = true,
        always_show_bufferline = true,
        diagnostics = "nvim_lsp",
        close_command = function(n)
          Snacks.bufdelete(n)
        end,
        right_mouse_command = function(n)
          Snacks.bufdelete(n)
        end,
      },
    },
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
      { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
      { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        icons_enabled = false,
        theme = "auto",
        section_separators = "",
        component_separators = "",
        disabled_filetypes = {},
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = {
          "filename",
          {
            spell,
            color = { fg = "black", bg = "#a7c080" },
          },
        },
        lualine_x = {
          "encoding",
          {
            "fileformat",
            symbols = {
              unix = "unix",
              dos = "win",
              mac = "mac",
            },
          },
          "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = {
          "location",
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
          },
          {
            trailing_space,
            color = "WarningMsg",
          },
          {
            mixed_indent,
            color = "WarningMsg",
          },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { "quickfix", "fugitive", "nvim-tree" },
    },
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      explorer = { enabled = true, replace_netrw = true },
      indent = { enabled = true },
      -- input = { enabled = true },
      picker = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      terminal = { enabled = true },
      words = { enabled = true },
    },
    -- stylua: ignore
    keys = { 
      -- Scratch buffers
      { "<leader>.", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer", },
      { "<leader>S", function() Snacks.scratch.select() end, desc = "Select Scratch Buffer", },
      -- History
      { "<leader>/", function() Snacks.picker.search_history() end, desc = "Search History" },
      { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
      { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
      { '<leader>"', function() Snacks.picker.registers() end, desc="Registers" },
      -- Find/Files
      { "<leader>fe", function() Snacks.explorer() end, desc = "File Explorer" },
      { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
      { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
      { "<leader>fh", function() Snacks.picker.files({ cwd = "~" }) end, desc = "Find Files in $HOME" },
      { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
      { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
      -- Grep
      { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<leader>sb", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
      { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Grep Word" },
      { "<leader>sl", function() Snacks.picker.lines() end, desc = "Lines" },
      -- Search
      { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
      { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
      { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
      { "<leader>sm", function() Snacks.picker.man() end, desc = "Manual Pages" },
      { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
      { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo history" },
      -- Git
      { "<leader>gg", function() Snacks.lazygit.open() end, desc = "LazyGit" },
      { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
      { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
      { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
      { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
      { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
      { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
      { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
      -- Terminal
      { "<leader>t", function() Snacks.terminal() end, desc = "Terminal", },
      -- User Interface
      -- { "<leader>ux", function()
      --     Snacks.toggle.option()
      -- end},
    },
  },
  -- Replaced fzf-lua with snacks
  -- {
  --   "ibhagwan/fzf-lua",
  --   event = "VeryLazy",
  --   dependencies = { "echasnovski/mini.icons" },
  --   cmd = "FzfLua",
  --   opts = function(_, opts)
  --     local fzf = require("fzf-lua")
  --     local config = fzf.config
  --     local actions = fzf.actions
  --     local utils = fzf.utils
  --
  --     return {
  --       "default-title",
  --       fzf_colors = true,
  --       fzf_opts = {
  --         ["--no-scrollbar"] = true,
  --       },
  --       defaults = {
  --         -- formatter = "path.filename_first",
  --         formatter = "path.dirname_first",
  --       },
  --       winopts = {
  --         width = 0.8,
  --         height = 0.8,
  --         row = 0.5,
  --         col = 0.5,
  --         preview = {
  --           scrollchars = { "┃", "" },
  --         },
  --       },
  --       files = {
  --         cwd_prompt = false,
  --         actions = {
  --           ["alt-i"] = actions.toggle_ignore,
  --           ["alt-h"] = actions.toggle_hidden,
  --           ["enter"] = actions.file_edit_or_qf,
  --           ["ctrl-s"] = actions.file_split,
  --           ["ctrl-v"] = actions.file_vsplit,
  --           ["ctrl-t"] = actions.file_tabedit,
  --           ["alt-q"] = actions.file_sel_to_qf,
  --           ["alt-l"] = actions.file_sel_to_ll,
  --         },
  --       },
  --     }
  --   end,
  --   keys = {
  --     { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Files" },
  --     { "<leader>fg", "<cmd>FzfLua git_files<cr>", desc = "Find Files (git-files)" },
  --     { "<leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
  --     { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent Files" },
  --     { "<leader>H", "<cmd>FzfLua help_tags<cr>", desc = "Help Pages" },
  --     { "<leader>K", "<cmd>FzfLua keymaps<cr>", desc = "Key Mappings" },
  --     { "<leader>C", "<cmd>FzfLua commands<cr>", desc = "Commands" },
  --     { "<leader>:", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
  --     { "<leader>/", "<cmd>FzfLua search_history<cr>", desc = "Search History" },
  --     { '<leader>"', "<cmd>FzfLua registers<cr>", desc = "Registers" },
  --     {
  --       "<C-x><C-f>",
  --       function()
  --         require("fzf-lua").complete_path()
  --       end,
  --       { "n", "v", "i" },
  --       { silent = true, desc = "Fuzzy complete path" },
  --     },
  --   },
  -- },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    -- opts_extend = { "spec" },
    opts = {
      -- preset = "helix",
      -- defaults = {},
      triggers = {
        { "<leader>", mode = { "n", "v" } },
        { "[", mode = { "n", "v" } },
        { "]", mode = { "n", "v" } },
        { "g", mode = { "n", "v" } },
        { "gs", mode = { "n", "v" } },
        -- { "s", mode = "n" },
        { "z", mode = { "n", "v" } },
      },
      spec = {
        {
          mode = { "n", "v" },
          { "<leader><tab>", group = "tabs" },
          { "<leader>b", group = "buffers" },
          { "<leader>w", group = "window" },
          --     { "<leader>c", group = "code" },
          --     { "<leader>d", group = "debug" },
          { "<leader>f", group = "file/find" },
          { "<leader>g", group = "git" },
          { "<leader>q", group = "quit/session" },
          { "<leader>s", group = "search" },
          { "<leader>u", group = "user interface" },
          --     { "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
          { "[", group = "prev" },
          { "]", group = "next" },
          { "g", group = "goto" },
          { "gs", group = "surround" },
          -- { "s", group = "window" },
          { "z", group = "fold" },
          --     -- better descriptions
          --     { "gx", desc = "Open with system app" },
        },
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
}
-- vim: et ts=2 sts=2
