-- indent-blankline.nvim
-- https://github.com/lukas-reineke/indent-blankline.nvim
--
-- Add indentation guides even on blank lines.
-- The Lua module is `ibl`, not the repo name (lazy.nvim's `main = 'ibl'`). See `:help ibl`.

local pack = require 'pack'

pack.later(function()
  pack.add { 'lukas-reineke/indent-blankline.nvim' }
  require('ibl').setup {}
end)
