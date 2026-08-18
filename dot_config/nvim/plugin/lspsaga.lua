-- lspsaga.nvim
-- https://github.com/nvimdev/lspsaga.nvim

local pack = require 'pack'

pack.later(function()
  pack.add {
    { src = 'nvim-treesitter/nvim-treesitter', version = 'main' },
    'nvim-tree/nvim-web-devicons',
    'nvimdev/lspsaga.nvim',
  }

  require('lspsaga').setup {}
end)
