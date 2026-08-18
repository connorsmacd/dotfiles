-- nvim-autopairs
-- https://github.com/windwp/nvim-autopairs

local pack = require 'pack'

pack.on_event('InsertEnter', function()
  pack.add { 'windwp/nvim-autopairs' }
  require('nvim-autopairs').setup {}
end)
