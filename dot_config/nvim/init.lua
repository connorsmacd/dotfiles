require 'options'

require 'autocmds'
require 'keymaps'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require('lazy').setup({
  require 'plugins.autopairs',
  require 'plugins.blink',
  require 'plugins.catppuccin',
  require 'plugins.cmake-tools',
  require 'plugins.conform',
  require 'plugins.gitsigns',
  require 'plugins.indent-blankline',
  require 'plugins.lazydev',
  require 'plugins.mini',
  -- require 'plugins.neoscroll',
  require 'plugins.nvim-lint',
  require 'plugins.nvim-lspconfig',
  require 'plugins.nvim-spectre',
  require 'plugins.nvim-tree',
  require 'plugins.nvim-treesitter',
  require 'plugins.oxocarbon',
  require 'plugins.sleuth',
  require 'plugins.telescope',
  require 'plugins.telescope-frecency',
  require 'plugins.todo-comments',
  require 'plugins.which-key',
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

vim.opt.background = 'light'
vim.cmd.colorscheme 'oxocarbon'
