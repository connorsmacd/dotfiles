return {
  's1n7ax/nvim-window-picker',
  name = 'window-picker',
  event = 'VeryLazy',
  version = '2.*',
  config = function()
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

    vim.keymap.set('n', '<leader>w', function()
      local window_picker = require 'window-picker'

      local picked_window = window_picker.pick_window()

      if picked_window then
        vim.api.nvim_set_current_win(picked_window)
      end
    end, { desc = 'Pick [W]indow' })
  end,
}
