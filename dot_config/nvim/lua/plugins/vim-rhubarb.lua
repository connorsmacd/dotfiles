return {
  'tpope/vim-rhubarb',
  keys = {
    { '<leader>g', nil, desc = 'GitHub' },
    { '<leader>gl', ':.GBrowse<CR>', desc = 'Open current line on GitHub' },
    { '<leader>gl', ":'<,'>GBrowse<CR>", mode = 'v', desc = 'Open selected lines on GitHub' },
  },
}
