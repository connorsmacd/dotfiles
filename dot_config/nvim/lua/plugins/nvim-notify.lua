-- nvim-notify
-- https://github.com/rcarriga/nvim-notify

return {
  'rcarriga/nvim-notify',
  config = function()
    local notify = require 'notify'

    -- notify.setup {
    --   background_colour = '#cdd6f4',
    -- }

    vim.notify = notify
  end,
}
