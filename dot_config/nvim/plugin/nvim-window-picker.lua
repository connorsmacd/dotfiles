-- nvim-window-picker
-- https://github.com/s1n7ax/nvim-window-picker
--
-- The old spec renamed the install directory to `window-picker`; that only mattered for the
-- lazy.nvim lockfile key. The Lua module is `window-picker` either way.

local pack = require 'pack'

pack.later(function()
  pack.add { { src = 's1n7ax/nvim-window-picker', version = vim.version.range '2.*' } }

  require('window-picker').setup {
    hint = 'floating-big-letter',
    filter_rules = {
      include_current_win = false,
      autoselect_one = true,
      bo = {
        filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },
        buftype = {},
      },
    },
  }
end)

vim.keymap.set('n', '<leader>w', function()
  local picked_window = require('window-picker').pick_window()

  if picked_window then
    vim.api.nvim_set_current_win(picked_window)
  end
end, { desc = 'Pick [W]indow' })
