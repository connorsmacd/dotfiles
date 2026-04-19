return {
  'mikavilpas/yazi.nvim',
  version = '*',
  event = 'VeryLazy',
  dependencies = {
    { 'nvim-lua/plenary.nvim', lazy = true },
  },
  keys = {
    {
      '<leader>yf',
      mode = { 'n', 'v' },
      '<cmd>Yazi<cr>',
      desc = '[Y]azi Open Current [F]ile',
    },
    {
      '<leader>yd',
      mode = { 'n', 'v' },
      '<cmd>Yazi cwd<cr>',
      desc = '[Y]azi Open Working [D]irectory',
    },
    {
      '<leader>yt',
      mode = { 'n', 'v' },
      '<cmd>Yazi toggle<cr>',
      desc = '[Y]azi [T]oggle',
    },
  },
  opts = {},
}
