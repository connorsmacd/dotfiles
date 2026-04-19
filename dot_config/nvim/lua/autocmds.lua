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

autocmd({ 'BufWritePre' }, {
  pattern = '*',
  group = group('autoformat', { clear = true }),
  desc = 'autoformat',
  callback = function()
    vim.notify('Formatting ' .. api.nvim_buf_get_name(0))
    require('conform').format { lsp_format = 'fallback' }
  end,
})

autocmd({ 'BufLeave', 'FocusLost' }, {
  pattern = '*',
  group = group('autosave', { clear = true }),
  desc = 'autosave',
  callback = function(args)
    local buf = args.buf
    local buf_name = api.nvim_buf_get_name(buf)

    if #buf_name ~= 0 and vim.bo.buflisted and vim.bo.modified then
      if vim.api.nvim_win_get_config(0).relative ~= '' then
        return
      end

      vim.schedule(function()
        api.nvim_buf_call(buf, function()
          vim.cmd 'silent w'
          vim.notify('saved ' .. buf_name .. ' at ' .. os.date '%h:%m:%s')
        end)
      end)
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

autocmd({ 'Colorscheme' }, {
  group = group('set-background', { clear = true }),
  desc = 'set background',
  callback = function()
    local hl_groups = {
      'Normal',
      'NormalFloat',
      'NormalNC',
      'NotifyERRORBody',
      'NotifyWARNBody',
      'NotifyINFOBody',
      'NotifyDEBUGBody',
      'NotifyTRACEBody',
      'NotifyERRORBorder',
      'NotifyWARNBorder',
      'NotifyINFOBorder',
      'NotifyDEBUGBorder',
      'NotifyTRACEBorder',
      'TelescopeBorder',
      'TelescopeNormal',
      'TelescopePromptBorder',
      'WhichKeyNormal',
      'ZenBg',
    }

    for _, g in ipairs(hl_groups) do
      vim.cmd('highlight ' .. g .. ' guibg=NONE ctermbg=NONE')
    end
  end,
})
