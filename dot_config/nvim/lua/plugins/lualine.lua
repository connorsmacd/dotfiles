return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup {
      options = {
        theme = 'tokyonight',
      },
      sections = {
        lualine_z = {
          {
            require('opencode').statusline,
          },
        },
      },
    }
  end,
}
