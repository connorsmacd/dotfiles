-- neoscroll.nvim
-- https://github.com/karb94/neoscroll.nvim

local pack = require 'pack'

pack.later(function()
  pack.add { 'karb94/neoscroll.nvim' }
  require('neoscroll').setup {
    duration_multiplier = 0.25,
  }
end)
