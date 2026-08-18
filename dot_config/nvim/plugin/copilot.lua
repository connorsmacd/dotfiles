-- copilot.lua
-- https://github.com/zbirenbaum/copilot.lua
--
-- Suggestions and panel are off: completions come through blink.cmp's `copilot` source
-- (blink-copilot), configured in plugin/blink.lua.

local pack = require 'pack'

pack.on_event('InsertEnter', function()
  pack.add { 'zbirenbaum/copilot.lua' }

  require('copilot').setup {
    suggestion = { enabled = false },
    panel = { enabled = false },
    filetypes = {
      markdown = true,
      help = true,
    },
  }
end)
