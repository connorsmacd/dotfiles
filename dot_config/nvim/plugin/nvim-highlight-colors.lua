-- nvim-highlight-colors
-- https://github.com/brenoprata10/nvim-highlight-colors

local pack = require 'pack'

pack.later(function()
  pack.add { 'brenoprata10/nvim-highlight-colors' }
  require('nvim-highlight-colors').setup {}
end)
