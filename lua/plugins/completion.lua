----------------------------------------
-- Completion Plugins
----------------------------------------
local has_words_before = function()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  if col == 0 then
    return false
  end
  local line = vim.api.nvim_get_current_line()
  return line:sub(col, col):match("%s") == nil
end

return {
  {
    "saghen/blink.cmp",
    -- optional: provides snippets for the snippet source
    dependencies = { "rafamadriz/friendly-snippets" },

    -- use a release tag to download pre-built binaries
    version = "1.*",
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = {
        preset = "none",
        -- If completion hasn't been triggered yet, insert the first suggestion; if it has, cycle to the next suggestion.
        ["<Tab>"] = {
          function(cmp)
            if has_words_before() then
              return cmp.insert_next()
            end
          end,
          "fallback",
        },
        -- Navigate to the previous suggestion or cancel completion if currently on the first one.
        ["<S-Tab>"] = { "insert_prev" },
        -- The remainder of the mappings are taken from the default preset.
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide" },
        ["<C-y>"] = { "select_and_accept" },
        ["<CR>"] = { "select_and_accept", "fallback" },
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
        ["<C-n>"] = { "select_next", "fallback_to_mappings" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = { documentation = { auto_show = false } },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = {
        implementation = "prefer_rust_with_warning",
        sorts = {
          "exact",
          "score",
          "sort_text",
        },
      },
    },
    opts_extend = { "sources.default" },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },
  -- { "mason-org/mason.nvim", version = "^1.0.0" },
  -- { "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
}
-- vim: et ts=2 sts=2
