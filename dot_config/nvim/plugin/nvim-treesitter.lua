-- nvim-treesitter (and nvim-treesitter-textobjects)
-- https://github.com/nvim-treesitter/nvim-treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
--
-- Highlight, edit, and navigate code.
--
-- Both are pinned to the `main` branch, whose API is very different from `master`:
-- `setup()` takes only `install_dir`, and enabling features is the config's job.
--   * highlighting  -> `vim.treesitter.start()` per buffer
--   * indentation   -> `vim.bo.indentexpr`
--   * textobjects   -> keymaps calling `select`/`move` directly; `setup()` makes none
--   * `ensure_installed` / `auto_install` -> `install()`, called explicitly below
--
-- Folding is configured in init.lua via `vim.treesitter.foldexpr()`.

local pack = require 'pack'

pack.add {
  { src = 'nvim-treesitter/nvim-treesitter-textobjects', version = 'main' },
  { src = 'nvim-treesitter/nvim-treesitter', version = 'main' },
}

local ts = require 'nvim-treesitter'

-- Default install_dir is `stdpath('data')/site`, which is what we want.
ts.setup {}

-- Extra language aliases. Injected languages (markdown code fence info strings, for instance) are
-- resolved with `vim.treesitter.language.get_lang()`, which only knows the canonical names plus
-- whatever is registered here, so ```rs fences go unhighlighted without this.
vim.treesitter.language.register('rust', 'rs')

local ensure_installed = {
  'bash',
  'c',
  'cmake',
  'cpp',
  'diff',
  'html',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'query',
  'rust',
  'vim',
  'vimdoc',
}

do
  local installed = {}
  for _, lang in ipairs(ts.get_installed 'parsers') do
    installed[lang] = true
  end
  local missing = vim.tbl_filter(function(lang)
    return not installed[lang]
  end, ensure_installed)
  if #missing > 0 then
    ts.install(missing)
  end
end

--- Start treesitter highlighting and indentation for the current buffer, installing the parser
--- first if it is missing. Replaces the `master` branch's `auto_install = true`.
local function enable_treesitter(buf)
  local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)
  if not lang then
    return
  end

  local function start()
    if not vim.api.nvim_buf_is_valid(buf) then
      return
    end
    -- `pcall`: a parser can be installed yet fail to load (ABI mismatch after a Neovim upgrade).
    if pcall(vim.treesitter.start, buf, lang) then
      -- Deferred: runtime ftplugins set `indentexpr` on FileType as well (lua gets
      -- `GetLuaIndent()`, for instance), and would otherwise clobber this.
      vim.schedule(function()
        if vim.api.nvim_buf_is_valid(buf) and vim.treesitter.highlighter.active[buf] then
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end)
    end
  end

  if vim.list_contains(ts.get_installed 'parsers', lang) then
    start()
  elseif vim.list_contains(ts.get_available(), lang) then
    ts.install({ lang }):await(function(err)
      if err then
        return
      end
      start()
    end)
  end
end

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('treesitter-enable', { clear = true }),
  desc = 'Enable treesitter highlighting and indentation',
  callback = function(ev)
    enable_treesitter(ev.buf)
  end,
})

-- FileType has already fired for any buffer opened before this file was sourced.
enable_treesitter(vim.api.nvim_get_current_buf())

require('nvim-treesitter-textobjects').setup {
  select = {
    lookahead = true,
  },
  move = {
    set_jumps = true,
  },
}

local select = require 'nvim-treesitter-textobjects.select'
local move = require 'nvim-treesitter-textobjects.move'

-- Selection textobjects. On the `main` branch these must be mapped by hand.
-- stylua: ignore
local select_keymaps = {
  ['aa'] = { '@parameter.outer', 'Select outer part of a parameter/argument' },
  ['ia'] = { '@parameter.inner', 'Select inner part of a parameter/argument' },

  ['af'] = { '@call.outer', 'Select outer part of a function call' },
  ['if'] = { '@call.inner', 'Select inner part of a function call' },

  ['am'] = { '@function.outer', 'Select outer part of a function/method' },
  ['im'] = { '@function.inner', 'Select inner part of a function/method' },

  ['ai'] = { '@conditional.outer', 'Select outer part of a conditional' },
  ['ii'] = { '@conditional.inner', 'Select inner part of a conditional' },

  ['al'] = { '@loop.outer', 'Select outer part of a [l]oop' },
  ['il'] = { '@loop.inner', 'Select inner part of a [l]oop' },

  ['ar'] = { '@return.outer', 'Select outer part of a return' },
  ['ir'] = { '@return.inner', 'Select inner part of a return' },

  ['at'] = { '@class.outer', 'Select outer part of a class [t]ype' },
  ['it'] = { '@class.inner', 'Select inner part of a class [t]ype' },

  ['a='] = { '@assignment.outer', 'Select outer part of an assignment' },
  ['i='] = { '@assignment.inner', 'Select inner part of an assignment' },
  ['h='] = { '@assignment.lhs', 'Select LHS of an assignment' },
  ['l='] = { '@assignment.rhs', 'Select RHS of an assignment' },

  ['a/'] = { '@comment.outer', 'Select the outer part of a comment' },
  ['i/'] = { '@comment.inner', 'Select the inner part of a comment' },
}

for lhs, spec in pairs(select_keymaps) do
  local query, desc = spec[1], spec[2]
  vim.keymap.set({ 'x', 'o' }, lhs, function()
    select.select_textobject(query, 'textobjects')
  end, { desc = desc })
end

-- Movement. These are already repeat-aware via `make_repeatable_move`, so `;` and `,` below
-- repeat the most recent one.
-- stylua: ignore
local move_keymaps = {
  [move.goto_next_start] = {
    [']a'] = { '@parameter.outer', 'Next function [a]rgument/parameter start' },
    [']f'] = { '@call.outer', 'Next function/method call start' },
    [']m'] = { '@function.outer', 'Next function start' },
    [']t'] = { '@class.outer', 'Next class [t]ype start' },
  },
  [move.goto_next_end] = {
    [']A'] = { '@parameter.outer', 'Next function [a]rgument/parameter end' },
    [']F'] = { '@call.outer', 'Next function call end' },
    [']M'] = { '@function.outer', 'Next function end' },
    [']T'] = { '@class.outer', 'Next class [t]ype end' },
  },
  [move.goto_previous_start] = {
    ['[a'] = { '@parameter.outer', 'Previous function [a]rgument/parameter start' },
    ['[f'] = { '@call.outer', 'Previous function call start' },
    ['[m'] = { '@function.outer', 'Previous function start' },
    ['[t'] = { '@class.outer', 'Previous class [t]ype start' },
  },
  [move.goto_previous_end] = {
    ['[A'] = { '@parameter.outer', 'Previous function [a]rgument/parameter end' },
    ['[F'] = { '@call.outer', 'Previous function call end' },
    ['[M'] = { '@function.outer', 'Previous function end' },
    ['[T'] = { '@class.outer', 'Previous class [t]ype end' },
  },
}

for goto_fn, keymaps in pairs(move_keymaps) do
  for lhs, spec in pairs(keymaps) do
    local query, desc = spec[1], spec[2]
    vim.keymap.set({ 'n', 'x', 'o' }, lhs, function()
      goto_fn(query, 'textobjects')
    end, { desc = desc })
  end
end

local ts_repeat_move = require 'nvim-treesitter-textobjects.repeatable_move'

vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move, { desc = 'Repeat last move' })
vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_opposite, { desc = 'Repeat last move, opposite direction' })

-- Make the builtin f, F, t, T also repeatable with ; and ,
vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f_expr, { expr = true })
vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F_expr, { expr = true })
vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t_expr, { expr = true })
vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T_expr, { expr = true })
