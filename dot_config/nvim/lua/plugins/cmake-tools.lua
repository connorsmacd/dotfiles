-- cmake-tools.nvim
-- https://github.com/Civitasv/cmake-tools.nvim

return {
  'Civitasv/cmake-tools.nvim',
  dependencies = {
    'stevearc/overseer.nvim',
  },
  config = function()
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
  end,
}
