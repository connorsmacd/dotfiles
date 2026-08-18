-- neotest
-- https://github.com/nvim-neotest/neotest

local pack = require 'pack'

pack.add { 'antoinemadec/FixCursorHold.nvim', 'nvim-neotest/nvim-nio', 'nvim-neotest/neotest' }

pack.later(function()
  require('neotest').setup {
    adapters = {
      require 'rustaceanvim.neotest',
    },
  }
end)
