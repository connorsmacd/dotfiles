return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  branch = 'main',
  lazy = true,
  config = function()
    require('nvim-treesitter-textobjects').setup {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ['aa'] = { query = '@parameter.outer', desc = 'Select outer part of a parameter/argument' },
          ['ia'] = { query = '@parameter.inner', desc = 'Select inner part of a parameter/argument' },

          ['af'] = { query = '@call.outer', desc = 'Select outer part of a function call' },
          ['if'] = { query = '@call.inner', desc = 'Select inner part of a function call' },

          ['am'] = { query = '@function.outer', desc = 'Select outer part of a function/method' },
          ['im'] = { query = '@function.inner', desc = 'Select inner part of a function/method' },

          ['ai'] = { query = '@conditional.outer', desc = 'Select outer part of a conditional' },
          ['ii'] = { query = '@conditional.inner', desc = 'Select inner part of a conditional' },

          ['al'] = { query = '@loop.outer', desc = 'Select outer part of a [l]oop' },
          ['il'] = { query = '@loop.inner', desc = 'Select inner part of a [l]oop' },

          ['ar'] = { query = '@return.outer', desc = 'Select outer part of a return' },
          ['ir'] = { query = '@return.inner', desc = 'Select inner part of a return' },

          ['at'] = { query = '@class.outer', desc = 'Select outer part of a class [t]ype' },
          ['it'] = { query = '@class.inner', desc = 'Select inner part of a class [t]ype' },

          ['a='] = { query = '@assignment.outer', desc = 'Select outer part of an assignment' },
          ['i='] = { query = '@assignment.inner', desc = 'Select inner part of an assignment' },
          ['h='] = { query = '@assignment.lhs', desc = 'Select LHS of an assignment' },
          ['l='] = { query = '@assignment.rhs', desc = 'Select RHS of an assignment' },

          ['a/'] = { query = '@comment.outer', desc = 'Select the outer part of a comment' },
          ['i/'] = { query = '@comment.inner', desc = 'Select the inner part of a comment' },
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          [']a'] = { query = '@parameter.outer', desc = 'Next function [a]rgument/parameter start' },
          [']f'] = { query = '@call.outer', desc = 'Next function/method call start' },
          [']m'] = { query = '@function.outer', desc = 'Next function start' },
          [']t'] = { query = '@class.outer', desc = 'Next class [t]ype start' },
        },
        goto_next_end = {
          [']A'] = { query = '@parameter.outer', desc = 'Next function [a]rgument/parameter end' },
          [']F'] = { query = '@call.outer', desc = 'Next function call end' },
          [']M'] = { query = '@function.outer', desc = 'Next function end' },
          [']T'] = { query = '@class.outer', desc = 'Next class [t]ype end' },
        },
        goto_previous_start = {
          ['[a'] = { query = '@parameter.outer', desc = 'Previous function [a]rgument/parameter start' },
          ['[f'] = { query = '@call.outer', desc = 'Previous function call start' },
          ['[m'] = { query = '@function.outer', desc = 'Previous function start' },
          ['[t'] = { query = '@class.outer', desc = 'Previous class [t]ype start' },
        },
        goto_previous_end = {
          ['[A'] = { query = '@parameter.outer', desc = 'Previous function [a]rgument/parameter end' },
          ['[F'] = { query = '@call.outer', desc = 'Previous function call start' },
          ['[M'] = { query = '@function.outer', desc = 'Previous function start' },
          ['[T'] = { query = '@class.outer', desc = 'Previous class [t]ype start' },
        },
      },
    }

    local ts_repeat_move = require 'nvim-treesitter-textobjects.repeatable_move'

    vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move)
    vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_opposite)

    vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f_expr, { expr = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F_expr, { expr = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t_expr, { expr = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T_expr, { expr = true })
  end,
}
