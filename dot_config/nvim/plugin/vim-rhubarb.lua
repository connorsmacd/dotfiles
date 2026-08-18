-- vim-rhubarb
-- https://github.com/tpope/vim-rhubarb
--
-- Provides :GBrowse for GitHub; the command itself comes from fugitive, which the old spec
-- relied on being present without declaring it.
--
-- Loaded eagerly rather than on `<leader>gl`: both plugins are small vimscript and define their
-- commands from plugin/ files, so deferring buys nothing.

require('pack').add {
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
}

vim.keymap.set('n', '<leader>gl', ':.GBrowse<CR>', { desc = 'Open current line on GitHub' })
vim.keymap.set('v', '<leader>gl', ":'<,'>GBrowse<CR>", { desc = 'Open selected lines on GitHub' })
