-- todo-comments.nvim
-- https://github.com/folke/todo-comments.nvim

local pack = require 'pack'

pack.later(function()
  pack.add {
    'nvim-lua/plenary.nvim',
    'folke/todo-comments.nvim',
  }
  require('todo-comments').setup { signs = false }
end)
