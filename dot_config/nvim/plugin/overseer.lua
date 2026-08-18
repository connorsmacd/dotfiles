-- overseer.nvim
-- https://github.com/stevearc/overseer.nvim
--
-- Also added by plugin/cmake-tools.lua, which uses it as the CMake runner.

local pack = require 'pack'

pack.later(function()
  pack.add { 'stevearc/overseer.nvim' }
  require('overseer').setup {}
end)
