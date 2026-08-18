-- octo.nvim
-- https://github.com/pwntester/octo.nvim

local pack = require 'pack'

pack.later(function()
  pack.add {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'nvim-tree/nvim-web-devicons',
    'pwntester/octo.nvim',
  }

  require('octo').setup {
    -- or "fzf-lua" or "snacks" or "default"
    picker = 'telescope',
    -- bare Octo command opens picker of commands
    enable_builtin = true,
  }
end)

vim.keymap.set('n', '<leader>oi', '<CMD>Octo issue list<CR>', { desc = 'List GitHub Issues' })
vim.keymap.set('n', '<leader>op', '<CMD>Octo pr list<CR>', { desc = 'List GitHub PullRequests' })
vim.keymap.set('n', '<leader>od', '<CMD>Octo discussion list<CR>', { desc = 'List GitHub Discussions' })
vim.keymap.set('n', '<leader>on', '<CMD>Octo notification list<CR>', { desc = 'List GitHub Notifications' })
vim.keymap.set('n', '<leader>os', function()
  require('octo.utils').create_base_search_command { include_current_repo = true }
end, { desc = 'Search GitHub' })
