-- rustaceanvim
-- https://github.com/mrcjkb/rustaceanvim

require('pack').add {
  {
    src = 'mrcjkb/rustaceanvim',
    -- To avoid being surprised by breaking changes,
    -- I recommend you set a version range
    version = vim.version.range '^9',
  },
}
