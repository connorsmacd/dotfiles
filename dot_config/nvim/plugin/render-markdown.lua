-- render-markdown.nvim
-- https://github.com/MeanderingProgrammer/render-markdown.nvim

local pack = require 'pack'

pack.on_keys({
  {
    '<leader>m',
    function()
      require('render-markdown').toggle()
    end,
    desc = '[M]arkdown Preview (Toggle)',
  },
}, function()
  pack.add {
    { src = 'nvim-treesitter/nvim-treesitter', version = 'main' },
    'nvim-mini/mini.icons',
    'MeanderingProgrammer/render-markdown.nvim',
  }

  require('render-markdown').setup {}
end)
