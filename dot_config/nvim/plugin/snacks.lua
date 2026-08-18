-- snacks.nvim
-- https://github.com/folke/snacks.nvim

require('pack').add { 'folke/snacks.nvim' }

-- The snacks dashboard's `startup` section does a bare `require('lazy.stats')`, which is the one
-- place in snacks that assumes lazy.nvim without guarding for it. Pre-populating `lazy_stats`
-- with the equivalent vim.pack numbers short-circuits that require (it only falls back when
-- `startuptime` is absent or zero) and keeps the footer working.
--
-- Registered before `snacks.setup`, which installs its own UIEnter handler: same event, so
-- registration order decides who runs first.
--
-- `vim.g.init_start_time` is stamped at the top of init.lua; nothing sourced later can measure
-- startup from the beginning.
vim.api.nvim_create_autocmd('UIEnter', {
  group = vim.api.nvim_create_augroup('dashboard-pack-stats', { clear = true }),
  desc = 'Feed vim.pack stats to the snacks dashboard',
  callback = function()
    local plugins = vim.pack.get()
    local loaded = 0
    for _, p in ipairs(plugins) do
      loaded = loaded + (p.active and 1 or 0)
    end
    require('snacks.dashboard').lazy_stats = {
      startuptime = (vim.uv.hrtime() - vim.g.init_start_time) / 1e6,
      loaded = loaded,
      count = #plugins,
    }
  end,
})

---@type snacks.Config
require('snacks').setup {
  bigfile = { enabled = true },
  dashboard = { enabled = true },
  explorer = { enabled = true },
  gh = { enabled = false },
  indent = { enabled = true },
  input = { enabled = true },
  picker = { enabled = true },
  notifier = { enabled = true },
  quickfile = { enabled = true },
  scope = { enabled = true },
  scroll = { enabled = false },
  statuscolumn = { enabled = true },
  words = { enabled = true },
}
