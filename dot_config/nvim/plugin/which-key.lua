-- which-key.nvim
-- https://github.com/folke/which-key.nvim
--
-- Useful plugin to show you pending keybinds.
--
-- Eager, so the group labels are registered before any of them can be pressed.

require('pack').add { 'folke/which-key.nvim' }

require('which-key').setup {
  -- delay between pressing a key and opening which-key (milliseconds)
  -- this setting is independent of vim.o.timeoutlen
  delay = 0,
  icons = {
    -- set icon mappings to true if you have a Nerd Font
    mappings = vim.g.have_nerd_font,
    -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
    -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
    keys = vim.g.have_nerd_font and {} or {
      Up = '<Up> ',
      Down = '<Down> ',
      Left = '<Left> ',
      Right = '<Right> ',
      C = '<C-…> ',
      M = '<M-…> ',
      D = '<D-…> ',
      S = '<S-…> ',
      CR = '<CR> ',
      Esc = '<Esc> ',
      ScrollWheelDown = '<ScrollWheelDown> ',
      ScrollWheelUp = '<ScrollWheelUp> ',
      NL = '<NL> ',
      BS = '<BS> ',
      Space = '<Space> ',
      Tab = '<Tab> ',
      F1 = '<F1>',
      F2 = '<F2>',
      F3 = '<F3>',
      F4 = '<F4>',
      F5 = '<F5>',
      F6 = '<F6>',
      F7 = '<F7>',
      F8 = '<F8>',
      F9 = '<F9>',
      F10 = '<F10>',
      F11 = '<F11>',
      F12 = '<F12>',
    },
  },

  -- Document existing key chains.
  -- `<leader>a` and `<leader>g` were previously declared as keyless entries in the claudecode
  -- and vim-rhubarb `keys` specs; lazy.nvim forwarded those to which-key as groups.
  spec = {
    { '<leader>a', group = 'AI/Claude Code' },
    { '<leader>c', group = '[C]Make' },
    { '<leader>d', group = '[D]ebug' },
    { '<leader>g', group = 'GitHub' },
    { '<leader>h', group = 'Git [H]unk' },
    { '<leader>s', group = '[S]earch' },
    { '<leader>t', group = '[T]oggle' },
    { '<leader>y', group = '[Y]azi' },
  },
}
