-- nvim-dap
-- https://github.com/mfussenegger/nvim-dap

return {
  'mfussenegger/nvim-dap',
  event = 'VeryLazy',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'rcarriga/nvim-dap-ui',
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'theHamsta/nvim-dap-virtual-text',
  },
  config = function()
    local dap = require 'dap'

    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = '[D]ebugger Toggle [B]reakpoint' })
    vim.keymap.set('n', '<leader>dc', dap.continue, { desc = '[D]ebugger [C]ontinue' })
    vim.keymap.set('n', '<leader>dr', dap.run_to_cursor, { desc = '[D]ebugger [R]un to Cursor' })
    vim.keymap.set('n', '<leader>ds', dap.step_over, { desc = '[D]ebugger [S]tep Over' })
    vim.keymap.set('n', '<leader>di', dap.step_into, { desc = '[D]ebugger Step [I]nto' })
    vim.keymap.set('n', '<leader>do', dap.step_out, { desc = '[D]ebugger Step [O]ut' })
    vim.keymap.set('n', '<leader>dR', dap.restart, { desc = '[D]ebugger [R]estart' })
    vim.keymap.set('n', '<leader>dC', dap.close, { desc = '[D]ebugger [C]lose' })
    vim.keymap.set('n', '<leader>de', function()
      require('dap').set_exception_breakpoints { 'uncaughted' }
    end, { desc = '[D]ebugger Break on Uncaught [E]xceptions' })
    vim.keymap.set('n', '<leader>dj', dap.down, { desc = '[D]ebugger Down' })
    vim.keymap.set('n', '<leader>dk', dap.up, { desc = '[D]ebugger Up' })
    vim.keymap.set('n', '<leader>dp', dap.pause, { desc = '[D]ebugger [P]ause' })

    dap.configurations = {
      c = {
        {
          name = 'Launch file',
          type = 'codelldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopAtEntry = true,
          MIMode = 'lldb',
        },
      },
    }

    require('nvim-dap-virtual-text').setup {}

    local ui = require 'dapui'

    ui.setup()

    vim.keymap.set('n', '<leader>dq', function()
      require('dap').terminate()
      require('dapui').close()
      require('nvim-dap-virtual-text').toggle()
    end, { desc = '[D]ebugger [Q]uit' })

    local sign = vim.fn.sign_define

    sign('DapBreakpoint', { text = '●', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
    sign('DapBreakpointCondition', { text = '●', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' })
    sign('DapLogPoint', { text = '◆', texthl = 'DapLogPoint', linehl = '', numhl = '' })
    sign('DapStopped', { text = '', texthl = 'CustomDapStopped', linehl = '', numhl = '' })

    dap.listeners.before.attach.dapui_config = function()
      ui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      ui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      ui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      ui.close()
    end
  end,
}
