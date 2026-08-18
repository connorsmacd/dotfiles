-- nvim-spectre
-- https://github.com/nvim-pack/nvim-spectre
--
-- No setup() call, matching the old config: the plugin's own plugin/spectre.lua creates the
-- :Spectre command and requires the module on first use.

require('pack').add {
  'nvim-lua/plenary.nvim',
  'nvim-pack/nvim-spectre',
}
