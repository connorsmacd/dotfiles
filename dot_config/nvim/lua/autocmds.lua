local api = vim.api
local autocmd = api.nvim_create_autocmd
local group = api.nvim_create_augroup

autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = group('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

autocmd({ 'InsertLeave', 'TextChanged' }, {
  pattern = '*',
  group = group('autosave', { clear = true }),
  callback = function()
    if #api.nvim_buf_get_name(0) ~= 0 and vim.bo.buflisted then
      vim.cmd 'silent w'
      vim.notify('Saved at ' .. os.date '%H:%M:%S')
    end
  end,
})

local number_toggle_group = group('number-toggle', { clear = true })

autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave', 'WinEnter' }, {
  group = number_toggle_group,
  pattern = '*',
  callback = function()
    if vim.wo.number and vim.fn.mode() ~= 'i' then
      vim.wo.relativenumber = true
    end
  end,
})

autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter', 'WinLeave' }, {
  group = number_toggle_group,
  pattern = '*',
  callback = function()
    if vim.wo.number then
      vim.wo.relativenumber = false
    end
  end,
})
