-- hardtime.nvim
-- https://github.com/m4xshen/hardtime.nvim

return {
  'm4xshen/hardtime.nvim',
  lazy = false,
  dependencies = { 'MunifTanjim/nui.nvim' },
  opts = {
    disable_mouse = false,
    disabled_keys = {
      ['<Up>'] = { 'n', 'x' },
      ['<Down>'] = { 'n', 'x' },
      ['<Left>'] = { 'n', 'x' },
      ['<Right>'] = { 'n', 'x' },
    },
  },
}
