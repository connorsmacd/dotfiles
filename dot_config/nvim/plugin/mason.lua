-- mason.nvim
-- https://github.com/mason-org/mason.nvim
--
-- Also added (and set up) by plugin/nvim-lspconfig.lua, which must have Mason available before
-- it configures servers. `vim.pack.add` and `mason.setup` are both idempotent, so having this
-- file as well is harmless and keeps the one-file-per-plugin convention.

require('pack').add { 'mason-org/mason.nvim' }

require('mason').setup {}
