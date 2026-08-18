-- hardtime.nvim
-- https://github.com/m4xshen/hardtime.nvim

local pack = require 'pack'

pack.later(function()
  pack.add {
    'MunifTanjim/nui.nvim',
    'm4xshen/hardtime.nvim',
  }

  require('hardtime').setup {
    disable_mouse = false,
    disabled_keys = {
      ['<Up>'] = false,
      ['<Down>'] = false,
      ['<Left>'] = false,
      ['<Right>'] = false,
    },
  }
end)
