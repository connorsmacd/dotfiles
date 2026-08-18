-- Neovim configuration using the built-in plugin manager, `vim.pack` (Neovim 0.12+).
--
-- Plugins live one-per-file in `plugin/`, which Neovim sources alphabetically *after* this file.
-- Each of those files calls `require('pack').add{...}` for itself and its dependencies, then
-- configures the plugin. See `lua/pack.lua` and `:help vim.pack`.
--
-- Stamped here because nothing sourced later can measure startup from the beginning;
-- plugin/snacks.lua reads it for the dashboard's startuptime footer.
vim.g.init_start_time = vim.uv.hrtime()

require 'options'

require 'keymaps'

-- Build hooks (lazy.nvim's `build`). These MUST be registered before the first `vim.pack.add`,
-- or the install that triggers them will have already happened.
vim.api.nvim_create_autocmd('PackChanged', {
  group = vim.api.nvim_create_augroup('pack-build', { clear = true }),
  desc = 'Post-install/update build steps',
  callback = function(ev)
    local spec, kind, path = ev.data.spec, ev.data.kind, ev.data.path
    if kind ~= 'install' and kind ~= 'update' then
      return
    end

    local function make(...)
      if vim.fn.executable 'make' ~= 1 then
        return vim.notify(('`make` not found; skipping build for %s'):format(spec.name), vim.log.levels.WARN)
      end
      local args = { 'make', ... }
      local out = vim.system(args, { cwd = path }):wait()
      if out.code ~= 0 then
        vim.notify(('%s: %s failed\n%s'):format(spec.name, table.concat(args, ' '), out.stderr or ''), vim.log.levels.ERROR)
      end
    end

    if spec.name == 'nvim-treesitter' then
      -- Parsers are compiled by the plugin itself, so it has to be loaded to run TSUpdate.
      if not ev.data.active then
        vim.cmd.packadd 'nvim-treesitter'
      end
      vim.cmd 'TSUpdate'
    elseif spec.name == 'telescope-fzf-native.nvim' then
      make()
    elseif spec.name == 'LuaSnip' then
      -- Optional; only enables the regex-transform features of snippets.
      make 'install_jsregexp'
    end
  end,
})

-- Autocmds are registered before the colorscheme is applied on purpose: `autocmds.lua` has a
-- ColorScheme handler that clears backgrounds, and it needs to see this first `colorscheme`.
require 'autocmds'

-- Loaded here rather than in `plugin/` so it applies before anything drawn by a plugin file,
-- and so the ColorScheme handler registered just above sees it (lazy.nvim's `priority = 1000`).
local pack = require 'pack'

pack.add { 'folke/tokyonight.nvim' }
require('tokyonight').setup {
  styles = {
    comments = { italic = true },
    conditionals = { italic = true },
    loops = { italic = true },
    functions = { bold = true },
    keywords = { bold = true },
    strings = { bold = true },
    variables = {},
    numbers = { bold = true },
    booleans = { bold = true },
    properties = {},
    types = { bold = true },
    operators = { bold = true },
  },
}
vim.cmd.colorscheme 'tokyonight'

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.o.foldlevelstart = 99

-- Show [noeol] in the statusline when the file lacks a trailing newline.
vim.opt.statusline:append '%{&eol ? "" : "[noeol] "}'
