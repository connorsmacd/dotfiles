-- nvim-notify
-- https://github.com/rcarriga/nvim-notify

return {
  'rcarriga/nvim-notify',
  config = function()
    local notify = require 'notify'
    vim.notify = notify
  end,
}
