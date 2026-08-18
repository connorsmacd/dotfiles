--- Thin conveniences over `vim.pack` (Neovim 0.12+).
---
--- `vim.pack.add` is immediate and idempotent, so every `plugin/*.lua` file lists its own
--- dependencies rather than relying on the alphabetical order in which Neovim sources them.
---
--- See :help vim.pack

local M = {}

--- @alias pack.Spec string|{ src: string, version: string|vim.VersionRange, name: string?, data: table? }

--- Expand 'author/repo' shorthand into a full GitHub URL.
--- @param spec pack.Spec
--- @return vim.pack.Spec
local function expand(spec)
  if type(spec) == 'string' then
    spec = { src = spec }
  end
  if not spec.src:match '^%a+://' then
    spec.src = 'https://github.com/' .. spec.src
  end
  return spec
end

--- Install (if needed) and load plugins immediately.
--- Dependencies must be listed before their dependents.
--- @param specs pack.Spec[]
function M.add(specs)
  vim.pack.add(vim.tbl_map(expand, specs))
end

--- Run `fn` once control returns to the event loop. Equivalent to lazy.nvim's `VeryLazy`.
--- @param fn fun()
function M.later(fn)
  vim.schedule(fn)
end

--- Run `fn` the first time any of `events` fires. Equivalent to lazy.nvim's `event`/`ft`.
--- @param events string|string[]
--- @param fn fun(args: table)
--- @param opts? table extra options for nvim_create_autocmd (e.g. `pattern`)
function M.on_event(events, fn, opts)
  opts = vim.tbl_extend('force', opts or {}, { once = true, callback = fn })
  vim.api.nvim_create_autocmd(events, opts)
end

--- Load a plugin the first time any of `keymaps` is pressed, then apply the real mappings and
--- replay the key. Equivalent to lazy.nvim's `keys`.
---
--- Each entry is a `vim.keymap.set` call spelled as a table: `{ lhs, rhs, mode = ..., ... }`,
--- where `mode` defaults to `'n'` and any remaining keys are passed through as options.
---
---     pack.on_keys({
---       { '<leader>x', '<cmd>Foo<cr>', desc = 'Do the thing' },
---     }, function()
---       pack.add { 'author/foo' }
---       require('foo').setup {}
---     end)
---
--- Declaring `rhs` here rather than inside `fn` is deliberate: the stub mappings are registered
--- from the same table, so they cannot drift from the real ones. In particular they carry `desc`,
--- without which which-key renders a blank hint until the plugin happens to be loaded.
---
--- Returns a function that forces the load, for callers that need another way in (see
--- plugin/claudecode.lua). It is a no-op once loaded, and replays `lhs` only if given one.
---
--- @param keymaps table[]
--- @param fn fun()
--- @return fun(lhs: string?)
function M.on_keys(keymaps, fn)
  --- @param spec table
  --- @return string[]
  local function modes_of(spec)
    local mode = spec.mode or 'n'
    if type(mode) == 'string' then
      return { mode }
    end
    return mode
  end

  local loaded = false

  local function load(lhs)
    if not loaded then
      loaded = true

      -- Drop every stub before `fn` runs, so the real mappings are not shadowed and a replayed
      -- key lands on them instead of re-entering the stub.
      for _, spec in ipairs(keymaps) do
        for _, mode in ipairs(modes_of(spec)) do
          pcall(vim.keymap.del, mode, spec[1])
        end
      end

      fn()

      for _, spec in ipairs(keymaps) do
        local opts = {}
        for k, v in pairs(spec) do
          if k ~= 1 and k ~= 2 and k ~= 'mode' then
            opts[k] = v
          end
        end
        vim.keymap.set(spec.mode or 'n', spec[1], spec[2], opts)
      end
    end

    if lhs then
      -- 'm' remaps, so the key resolves against the mapping just installed.
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(lhs, true, false, true), 'm', false)
    end
  end

  for _, spec in ipairs(keymaps) do
    -- Only `desc` is copied onto the stub. It is all which-key needs, and forwarding options
    -- like `expr` would change how the stub's own return value is interpreted.
    vim.keymap.set(spec.mode or 'n', spec[1], function()
      load(spec[1])
    end, { desc = spec.desc })
  end

  return load
end

return M
