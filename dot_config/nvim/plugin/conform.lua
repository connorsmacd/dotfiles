-- conform.nvim
-- https://github.com/stevearc/conform.nvim
--
-- Loaded eagerly rather than on `BufWritePre`: the `autoformat` autocmd in lua/autocmds.lua
-- requires it on every write, so deferring only moves the cost around.

require('pack').add { 'stevearc/conform.nvim' }

require('conform').setup {
  notify_on_error = false,
  format_on_save = function(bufnr)
    -- Disable "format_on_save lsp_fallback" for languages that don't
    -- have a well standardized coding style. You can add additional
    -- languages here or re-enable it for the disabled ones.
    local disable_filetypes = { c = true, cpp = true }
    if disable_filetypes[vim.bo[bufnr].filetype] then
      return nil
    else
      return {
        timeout_ms = 500,
        lsp_format = 'fallback',
      }
    end
  end,
  formatters_by_ft = {
    lua = { 'stylua' },
    json = { 'jq' },
    rust = { 'rustfmt', lsp_format = 'fallback' },
    c = { 'clang_format' },
    cpp = { 'clang_format' },
  },
  formatters = {
    clang_format = {
      -- Prefer the project-local clang-format installed via uv (.venv/bin/clang-format)
      -- so the version matches what CI enforces via uv.lock.
      command = function(_, ctx)
        local found = vim.fs.find('.venv/bin/clang-format', {
          upward = true,
          path = vim.fs.dirname(ctx.filename),
          type = 'file',
        })
        return found[1] or 'clang-format'
      end,
    },
  },
}

vim.keymap.set('', '<leader>f', function()
  require('conform').format { async = true, lsp_format = 'fallback' }
end, { desc = '[F]ormat buffer' })
