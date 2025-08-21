----------------------------------------
-- Interface
----------------------------------------
--
-- Plugins that configure the interface (statusline, tabs, buffers, etc)
--
----------------------------------------
return {
    {
        'akinsho/bufferline.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        event = "VeryLazy",
        opts = {
            options = {
                numbers = 'none',
                show_tab_indicators = true,
                persist_buffer_sort = true,
                always_show_bufferline = true,
                diagnostics = "nvim_lsp",
                close_command = function(n) Snacks.bufdelete(n) end,
                right_mouse_command = function(n) Snacks.bufdelete(n) end,
            },
        },
        keys = {
            { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
            { "[b",         "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
            { "]b",         "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
            { "[B",         "<cmd>BufferLineMovePrev<cr>",  desc = "Move buffer prev" },
            { "]B",         "<cmd>BufferLineMoveNext<cr>",  desc = "Move buffer next" },
        },
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
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
                        color = { fg = 'black', bg = '#a7c080' }
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
                        sources = { "nvim_diagnostic" }
                    },
                    {
                        trailing_space,
                        color = "WarningMsg"
                    },
                    {
                        mixed_indent,
                        color = "WarningMsg"
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
            extensions = { 'quickfix', 'fugitive', 'nvim-tree' },
        }
    },
    {
        'folke/snacks.nvim',
        priority = 1000,
        lazy = false,
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            bigfile = { enabled = true },
            dashboard = { enabled = true },
            explorer = { enabled = true },
            indent = { enabled = true },
            input = { enabled = true },
            picker = { enabled = true },
            notifier = { enabled = true },
            quickfile = { enabled = true },
            scope = { enabled = true },
            scroll = { enabled = true },
            statuscolumn = { enabled = true },
            terminal = { enabled = true },
            words = { enabled = true },
        },
        keys = {
            { "<leader>.", function() Snacks.scratch() end,        desc = "Toggle Scratch Buffer" },
            { "<leader>S", function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
            { "<leader>E", function() Snacks.explorer() end,       desc = "Explorer" },
            { "<leader>T", function() Snacks.terminal() end,       desc = "Terminal" },
        },
    },
    {
        "ibhagwan/fzf-lua",
        event = "VeryLazy",
        dependencies = { "echasnovski/mini.icons" },
        cmd = "FzfLua",
        opts = function(_, opts)
            local fzf = require("fzf-lua")
            local config = fzf.config
            local actions = fzf.actions
            local utils = fzf.utils

            return {
                "default-title",
                fzf_colors = true,
                fzf_opts = {
                    ["--no-scrollbar"] = true,
                },
                defaults = {
                    -- formatter = "path.filename_first",
                    formatter = "path.dirname_first",
                },
                winopts = {
                    width = 0.8,
                    height = 0.8,
                    row = 0.5,
                    col = 0.5,
                    preview = {
                        scrollchars = { "┃", "" },
                    },
                },
                files = {
                    cwd_prompt = false,
                    actions = {
                        ["alt-i"] = actions.toggle_ignore,
                        ["alt-h"] = actions.toggle_hidden,
                        ["enter"] = actions.file_edit_or_qf,
                        ["ctrl-i"] = actions.file_split,
                        ["ctrl-v"] = actions.file_vsplit,
                        ["ctrl-t"] = actions.file_tabedit,
                        ["alt-q"] = actions.file_sel_to_qf,
                        ["alt-l"] = actions.file_sel_to_ll,
                    },
                },
            }
        end,
        keys = {
            { "<leader>ff", "<cmd>FzfLua files<cr>",                                    desc = "Files" },
            { "<leader>fg", "<cmd>FzfLua git_files<cr>",                                desc = "Find Files (git-files)" },
            { "<leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
            { "<leader>fr", "<cmd>FzfLua oldfiles<cr>",                                 desc = "Recent Files" },
            { "<leader>fh", "<cmd>FzfLua help_tags<cr>",                                desc = "Help Pages" },
            { "<leader>fk", "<cmd>FzfLua keymaps<cr>",                                  desc = "Key Mappings" },
            { "<leader>fc", "<cmd>FzfLua commands<cr>",                                 desc = "Commands" },
            { "<leader>:",  "<cmd>FzfLua command_history<cr>",                          desc = "Command History" },
            { "<leader>/",  "<cmd>FzfLua search_history<cr>",                           desc = "Search History" },
            { '<leader>"',  "<cmd>FzfLua registers<cr>",                                desc = "Registers" },
        },
    },
    {
        'folke/which-key.nvim',
        event = "VeryLazy",
        opts = {
            triggers = {
                { "<leader>", mode = { "n", "v" } },
                { "g",        mode = { "n" } },
                { "s",        mode = { "n" } },
                { "z",        mode = { "n" } },
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
