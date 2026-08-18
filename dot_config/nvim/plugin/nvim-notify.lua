-- nvim-notify
-- https://github.com/rcarriga/nvim-notify
--
-- Eager, so that `vim.notify` is replaced before anything notifies during startup.
-- noice.nvim also uses it and will take over the routing when it loads.

require('pack').add { 'rcarriga/nvim-notify' }

local notify = require 'notify'

-- setup() is what registers :Notifications and :NotificationsClear. The old config never called
-- it explicitly and relied on the first vim.notify() during startup doing so, which stops
-- happening once noice takes over vim.notify.
notify.setup {}

vim.notify = notify
