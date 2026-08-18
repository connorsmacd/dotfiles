-- zen-mode.nvim
-- https://github.com/folke/zen-mode.nvim
--
-- No keymap; invoked via :ZenMode.

local pack = require 'pack'

pack.later(function()
  pack.add { 'folke/zen-mode.nvim' }
  require('zen-mode').setup {}
end)
