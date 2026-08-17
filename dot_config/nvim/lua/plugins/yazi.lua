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
    {
      '<leader>yc',
      mode = { 'n', 'v' },
      function()
        require('yazi').yazi({
          ---@diagnostic disable-next-line: missing-fields
          hooks = {
            on_yazi_ready = function(_, _, process_api)
              process_api:emit_to_yazi { 'plugin', 'vcs-files' }
            end,
          },
        }, vim.fn.getcwd())
      end,
      desc = '[Y]azi View [C]hanged Files',
    },
  },
  opts = {},
}
