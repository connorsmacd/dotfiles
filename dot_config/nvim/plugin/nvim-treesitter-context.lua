-- nvim-treesitter-context
-- https://github.com/nvim-treesitter/nvim-treesitter-context
--
-- No setup() call, matching the old config: the plugin's own plugin/treesitter-context.lua
-- enables it with defaults and defines :TSContext*.

local pack = require 'pack'

pack.later(function()
  pack.add {
    { src = 'nvim-treesitter/nvim-treesitter', version = 'main' },
    'nvim-treesitter/nvim-treesitter-context',
  }
end)
