-- cmake-tools.nvim
-- https://github.com/Civitasv/cmake-tools.nvim
--
-- toggleterm is listed because cmake-tools requires it for its toggleterm executor/runner;
-- under lazy.nvim it happened to be on the runtimepath already.

local pack = require 'pack'

pack.later(function()
  pack.add {
    -- cmake-tools requires plenary.path at load time without declaring it.
    'nvim-lua/plenary.nvim',
    'stevearc/overseer.nvim',
    { src = 'akinsho/toggleterm.nvim', version = vim.version.range '*' },
    -- cmake-tools' `register_dap_function` does `pcall(require, 'dap')` at setup time and
    -- silently skips :CMakeDebug/:CMakeQuickDebug/:CMakeDebugCurrentFile if dap is absent.
    'nvim-neotest/nvim-nio',
    'mfussenegger/nvim-dap',
    'Civitasv/cmake-tools.nvim',
  }

  require('cmake-tools').setup {
    cmake_executor = {
      name = 'quickfix',
    },
    cmake_runner = {
      name = 'overseer',
    },
  }

  local map = function(letter, command_suffix, desc_suffix)
    if desc_suffix == nil then
      desc_suffix = '[' .. string.sub(command_suffix, 1, 1) .. ']' .. string.sub(command_suffix, 2, -1)
    end

    vim.keymap.set('n', '<leader>c' .. letter, function()
      local api = vim.api

      if #api.nvim_buf_get_name(0) ~= 0 and vim.bo.buflisted and vim.bo.modified then
        require('conform').format { lsp_format = 'fallback' }
        vim.cmd 'silent w'
        vim.notify('Saved ' .. api.nvim_buf_get_name(0) .. ' at ' .. os.date '%H:%M:%S')
      end

      vim.cmd('CMake' .. command_suffix)
    end, { desc = '[C]Make ' .. desc_suffix })
  end

  map('b', 'Build')
  map('c', 'Clean')
  map('d', 'Debug')
  map('g', 'Generate')
  map('s', 'Settings')
  map('t', 'SelectBuildTarget', 'Select Build [T]arget')
  map('p', 'SelectConfigurePreset', 'Select Configure [P]reset')
end)
