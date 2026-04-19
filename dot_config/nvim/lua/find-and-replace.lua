local map = vim.keymap.set

local parse_line = function(text)
  if text == nil or #text < 1 then
    return nil
  end

  local regex = [[(%d+):(%d+):(.*)]]

  local _, _, row_str, col_str, match = string.find(text, regex)

  local row_ok, row = pcall(tonumber, row_str)

  if not row_ok then
    return nil
  end

  local col_ok, col = pcall(tonumber, col_str)

  if not col_ok then
    return nil
  end

  local end_col = col + #match

  return {
    row = row - 1,
    col = col - 1,
    end_col = end_col - 1,
  }
end

local try_find_existing_extmark = function(buf, ns_id, match)
  local marks = vim.api.nvim_buf_get_extmarks(buf, ns_id, { match.row, match.col }, { match.row, match.end_col }, {})

  if #marks == 0 then
    return nil
  end

  return marks[1][1]
end

local do_find = function(pattern, buf, ns_id)
  local Job = require 'plenary.job'

  vim.api.nvim_buf_clear_namespace(buf, ns_id, 0, -1)

  Job:new({
    command = 'rg',
    args = {
      '--color=never',
      '--no-heading',
      '--line-number',
      '--column',
      '--only-matching',
      pattern,
      vim.api.nvim_buf_get_name(buf),
    },
    on_stdout = function(_, text)
      pcall(vim.schedule_wrap(function()
        local match = parse_line(text)

        if match == nil then
          return
        end

        vim.api.nvim_buf_set_extmark(buf, ns_id, match.row, match.col, {
          id = try_find_existing_extmark(buf, ns_id, match),
          end_row = match.row,
          end_col = match.end_col,
          hl_group = 'Replace',
        })
      end))
    end,
  }):sync()

  local ms = vim.api.nvim_buf_get_extmarks(buf, ns_id, 0, -1, {})

  vim.print(ms)
end

local Input = require 'nui.input'

local make_find_input = function(buf, ns_id)
  return Input({
    size = 20,
  }, {
    prompt = 'Find:    ',
    on_change = function(pattern)
      do_find(pattern, buf, ns_id)
    end,
    on_close = function()
      vim.api.nvim_buf_clear_namespace(buf, ns_id, 0, -1)
    end,
  })
end

map('n', '<leader>F', function()
  local Layout = require 'nui.layout'
  local Popup = require 'nui.popup'

  local event = require('nui.utils.autocmd').event

  local current_buf = vim.api.nvim_get_current_buf()
  local current_win = vim.api.nvim_get_current_win()

  local ns_id = vim.api.nvim_create_namespace 'find-and-replace'

  vim.api.nvim_buf_clear_namespace(current_buf, ns_id, 0, -1)
  vim.api.nvim_set_hl_ns(ns_id)
  vim.api.nvim_set_hl(ns_id, 'Replace', { bg = '#ffffff', strikethrough = true })

  local popup = Popup {
    anchor = 'NE',
    position = {
      row = 0,
      col = vim.api.nvim_win_get_width(current_win),
    },
    size = {
      width = 40,
      height = '20%',
    },
  }

  local find_input = make_find_input(current_buf, ns_id)

  local layout = Layout(
    popup,
    Layout.Box({
      Layout.Box(find_input, { size = '40%' }),
    }, { dir = 'col' })
  )

  layout:mount()

  find_input:on(event.BufWinLeave, function()
    vim.api.nvim_win_close(popup.winid, true)
    vim.api.nvim_set_current_buf(current_buf)
    vim.api.nvim_set_current_win(current_win)
  end)
end, { desc = '[F]ind & [R]eplace' })
