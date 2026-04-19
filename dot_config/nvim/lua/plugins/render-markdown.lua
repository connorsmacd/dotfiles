-- render-markdown.nvim
-- https://github.com/MeanderingProgrammer/render-markdown.nvim

return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },
  opts = {},
  keys = {
    {
      '<leader>m',
      function()
        require('render-markdown').toggle()
      end,
      mode = 'n',
      desc = '[M]arkdown Preview (Toggle)',
    },
  },
}
