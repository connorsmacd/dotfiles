local map = vim.keymap.set

-- Clear highlights on search when pressing <Esc> in normal mode
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

map('n', '<leader>R', function()
  vim.cmd 'silent wa'
  vim.cmd 'silent so'
end, { desc = '[R]eload Config' })
