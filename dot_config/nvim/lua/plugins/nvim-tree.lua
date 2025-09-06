-- nvim-tree.lua
-- https://github.com/nvim-tree/nvim-tree.lua

return {
  'nvim-tree/nvim-tree.lua',
  config = function()
    require('nvim-tree').setup {
      view = {
        preserve_window_proportions = true,
      },
    }

    vim.keymap.set('n', '<leader>ee', function()
      vim.cmd 'NvimTreeFocus'
    end, { desc = '[E]xplorer' })
    vim.keymap.set('n', '<leader>et', function()
      vim.cmd 'NvimTreeToggle'
    end, { desc = '[E]xplorer [T]oggle' })
    vim.keymap.set('n', '<leader>ef', function()
      vim.cmd 'NvimTreeFindFile'
    end, { desc = '[E]xplorer [F]ind' })
    vim.keymap.set('n', '<leader>ec', function()
      vim.cmd 'NvimTreeCollapse'
    end, { desc = '[E]xplorer [C]ollapse' })
  end,
}
