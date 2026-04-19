-- auto-session
-- https://github.com/rmagatti/auto-session

return {
  'rmagatti/auto-session',
  lazy = false,
  config = function()
    require('auto-session').setup {}

    vim.keymap.set('n', '<leader>o', function()
      vim.cmd 'AutoSession search'
    end, { desc = '[O]pen Session' })
  end,
}
