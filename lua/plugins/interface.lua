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
            words = { enabled = true },
        },
        keys = {
        },
    },
    {
        "ibhagwan/fzf-lua",
        event = "VeryLazy",
        dependencies = { "echasnovski/mini.icons" },
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
