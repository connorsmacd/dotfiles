-- lazygit.nvim
-- https://github.com/kdheepak/lazygit.nvim
--
-- Eager, matching the old spec's `lazy = false`. The telescope extension is registered in
-- plugin/telescope.lua, which is sourced after this file (telescope is not set up yet here).

require('pack').add {
  'nvim-lua/plenary.nvim',
  'kdheepak/lazygit.nvim',
}

vim.keymap.set('n', '<leader>lg', '<cmd>LazyGit<cr>', { desc = 'LazyGit' })
