-- lazydev.nvim
-- https://github.com/folke/lazydev.nvim
--
-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
-- used for completion, annotations and signatures of Neovim apis.
--
-- Was `ft = 'lua'` under lazy.nvim, but it is also a dependency of blink.cmp (which uses its
-- `lazydev.integrations.blink` completion source), so lazy loaded it eagerly in practice.
-- Setting it up here unconditionally keeps that behaviour and guarantees it is in place before
-- lua_ls attaches. The plugin itself does nothing outside Lua buffers.
--
-- Added to the runtimepath by plugin/blink.lua.

require('lazydev').setup {
  library = {
    -- Load luvit types when the `vim.uv` word is found
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
  },
}
