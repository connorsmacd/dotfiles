-- catppuccin
-- https://github.com/catppuccin/nvim

return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  config = function()
    require('catppuccin').setup {
      flavour = 'auto',
      background = {
        light = 'latte',
        dark = 'mocha',
      },
      float = {
        transparent = true,
        solid = true,
      },
    }
  end,
}
