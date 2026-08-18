-- toggleterm.nvim
-- https://github.com/akinsho/toggleterm.nvim
--
-- No setup() call, matching the old config. cmake-tools drives it directly via
-- `require('toggleterm')`; note that :ToggleTerm and friends are only created by setup(), so
-- they do not exist here (nor did they under lazy.nvim).

require('pack').add { { src = 'akinsho/toggleterm.nvim', version = vim.version.range '*' } }
