-- claudecode.nvim
-- https://github.com/coder/claudecode.nvim

local pack = require 'pack'

local load = pack.on_keys({
  { '<leader>ac', '<cmd>ClaudeCode<cr>', desc = 'Toggle Claude' },
  { '<leader>af', '<cmd>ClaudeCodeFocus<cr>', desc = 'Focus Claude' },
  { '<leader>ar', '<cmd>ClaudeCode --resume<cr>', desc = 'Resume Claude' },
  { '<leader>aC', '<cmd>ClaudeCode --continue<cr>', desc = 'Continue Claude' },
  { '<leader>am', '<cmd>ClaudeCodeSelectModel<cr>', desc = 'Select Claude model' },
  { '<leader>ab', '<cmd>ClaudeCodeAdd %<cr>', desc = 'Add current buffer' },
  { '<leader>as', '<cmd>ClaudeCodeSend<cr>', mode = 'v', desc = 'Send to Claude' },
  -- Diff management
  { '<leader>aa', '<cmd>ClaudeCodeDiffAccept<cr>', desc = 'Accept diff' },
  { '<leader>ad', '<cmd>ClaudeCodeDiffDeny<cr>', desc = 'Deny diff' },
}, function()
  pack.add {
    'folke/snacks.nvim',
    'coder/claudecode.nvim',
  }

  require('claudecode').setup {
    diff_opts = {
      open_in_new_tab = true,
    },
  }
end)

-- In file-tree buffers, normal-mode <leader>as adds the file under the cursor instead of sending
-- a selection. lazy.nvim expressed this as a `ft` field on the key spec.
--
-- Registered here rather than inside the loader so the mapping exists (with its description) from
-- startup, and so pressing it is itself a way to load the plugin.
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('claudecode-tree-add', { clear = true }),
  pattern = { 'NvimTree', 'neo-tree', 'oil', 'minifiles', 'netrw' },
  callback = function(ev)
    vim.keymap.set('n', '<leader>as', function()
      load()
      vim.cmd 'ClaudeCodeTreeAdd'
    end, { buffer = ev.buf, desc = 'Add file' })
  end,
})
