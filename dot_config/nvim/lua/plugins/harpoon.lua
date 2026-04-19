-- harpoon
-- https://github.com/ThePrimeagen/harpoon

return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local harpoon = require 'harpoon'

    harpoon:setup()

    vim.keymap.set('n', '\\a', function()
      harpoon:list():add()
    end, { desc = 'Harpoon [A]dd' })
    vim.keymap.set('n', '\\l', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Harpoon [L]ist' })
    vim.keymap.set('n', '\\c', function()
      harpoon:list():clear()
    end, { desc = 'Harpoon [C]lear' })
  end,
}
