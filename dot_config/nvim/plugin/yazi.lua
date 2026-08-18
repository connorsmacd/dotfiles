-- yazi.nvim
-- https://github.com/mikavilpas/yazi.nvim
--
-- Deferred with vim.schedule rather than on first keypress (the old spec had both
-- `event = 'VeryLazy'` and `keys`), so that :Yazi, :Yazi cwd and :Yazi toggle exist for direct
-- use as they did before.

local pack = require 'pack'

pack.later(function()
  pack.add {
    'nvim-lua/plenary.nvim',
    { src = 'mikavilpas/yazi.nvim', version = vim.version.range '*' },
  }

  require('yazi').setup {}
end)

local mode = { 'n', 'v' }
vim.keymap.set(mode, '<leader>yf', '<cmd>Yazi<cr>', { desc = '[Y]azi Open Current [F]ile' })
vim.keymap.set(mode, '<leader>yd', '<cmd>Yazi cwd<cr>', { desc = '[Y]azi Open Working [D]irectory' })
vim.keymap.set(mode, '<leader>yt', '<cmd>Yazi toggle<cr>', { desc = '[Y]azi [T]oggle' })
vim.keymap.set(mode, '<leader>yc', function()
  require('yazi').yazi({
    ---@diagnostic disable-next-line: missing-fields
    hooks = {
      on_yazi_ready = function(_, _, process_api)
        process_api:emit_to_yazi { 'plugin', 'vcs-files' }
      end,
    },
  }, vim.fn.getcwd())
end, { desc = '[Y]azi View [C]hanged Files' })
