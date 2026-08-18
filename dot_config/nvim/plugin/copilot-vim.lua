-- copilot.vim
-- https://github.com/github/copilot.vim
--
-- Runs alongside copilot.lua (plugin/copilot.lua). Its inline suggestions are suppressed:
-- `copilot_no_maps` removes the default <Tab> mapping, and the plugin is driven manually
-- through copilot#OnFileType/copilot#OnBufUnload.

local pack = require 'pack'

-- Must be set before the plugin is sourced (this was lazy.nvim's `init`).
vim.g.copilot_no_maps = true

pack.on_event('InsertEnter', function()
  pack.add { 'github/copilot.vim' }

  -- Block the normal Copilot suggestions
  vim.api.nvim_create_augroup('github_copilot', { clear = true })
  vim.api.nvim_create_autocmd({ 'FileType', 'BufUnload' }, {
    group = 'github_copilot',
    callback = function(args)
      vim.fn['copilot#On' .. args.event]()
    end,
  })
  vim.fn['copilot#OnFileType']()
end)
