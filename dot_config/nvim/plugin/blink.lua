-- blink.cmp
-- https://github.com/Saghen/blink.cmp
--
-- Loaded eagerly: `plugin/nvim-lspconfig.lua` calls
-- `require('blink.cmp').get_lsp_capabilities()` while configuring servers.

local pack = require 'pack'

pack.add {
  -- Snippet engine. The `install_jsregexp` build step (see the PackChanged hook in init.lua)
  -- is only needed for regex support in snippets.
  { src = 'L3MON4D3/LuaSnip', version = vim.version.range '2.*' },
  -- `friendly-snippets` contains a variety of premade snippets.
  --    See the README about individual language/framework/plugin snippets:
  --    https://github.com/rafamadriz/friendly-snippets
  -- 'rafamadriz/friendly-snippets',
  'folke/lazydev.nvim',
  'fang2hou/blink-copilot',
  { src = 'saghen/blink.cmp', version = vim.version.range '1.*' },
}

require('luasnip').setup {}

--- @module 'blink.cmp'
--- @type blink.cmp.Config
require('blink.cmp').setup {
  keymap = {
    -- 'default' (recommended) for mappings similar to built-in completions
    --   <c-y> to accept ([y]es) the completion.
    --    This will auto-import if your LSP supports it.
    --    This will expand snippets if the LSP sent a snippet.
    -- 'super-tab' for tab to accept
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- <tab>/<s-tab>: move to right/left of your snippet expansion
    -- <c-space>: Open menu or open docs if already open
    -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
    -- <c-e>: Hide menu
    -- <c-k>: Toggle signature help
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    preset = 'default',

    -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
    --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
  },

  appearance = {
    -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    -- Adjusts spacing to ensure icons are aligned
    nerd_font_variant = 'mono',
  },

  completion = {
    ghost_text = {
      enabled = true,
    },
    -- By default, you may press `<c-space>` to show the documentation.
    -- Optionally, set `auto_show = true` to show the documentation after a delay.
    documentation = { auto_show = false, auto_show_delay_ms = 500 },
  },

  sources = {
    default = { 'copilot', 'lsp', 'path', 'snippets', 'lazydev' },
    providers = {
      copilot = { module = 'blink-copilot', score_offset = 100, async = true },
      lazydev = { module = 'lazydev.integrations.blink', score_offset = 101 },
    },
  },

  snippets = { preset = 'luasnip' },

  -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
  -- which automatically downloads a prebuilt binary when enabled.
  --
  -- By default, we use the Lua implementation instead, but you may enable
  -- the rust implementation via `'prefer_rust_with_warning'`
  --
  -- See :h blink-cmp-config-fuzzy for more information
  fuzzy = { implementation = 'lua' },

  -- Shows a signature help window while you type arguments for a function
  signature = { enabled = true },
}
