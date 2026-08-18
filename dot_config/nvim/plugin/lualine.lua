-- lualine.nvim
-- https://github.com/nvim-lualine/lualine.nvim
--
-- opencode.nvim is listed explicitly: the statusline section below calls into it, and the old
-- spec relied on lazy.nvim having loaded it first without declaring the dependency.

require('pack').add {
  'nvim-tree/nvim-web-devicons',
  { src = 'nickjvandyke/opencode.nvim', version = vim.version.range '*' },
  'nvim-lualine/lualine.nvim',
}

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
