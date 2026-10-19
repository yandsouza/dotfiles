-- Linting

vim.pack.add { 'https://github.com/mfussenegger/nvim-lint' }

local lint = require 'lint'
lint.linters_by_ft = {
  markdown = { 'markdownlint' },
  python = { 'mypy', 'flake8' },
}

lint.linters.mypy = function()
  return {
    cmd = 'mypy',
    stdin = false,
    append_fname = true,
    args = {
      '--show-column-numbers',
      '--hide-error-context',
      '--no-color-output',
      '--no-error-summary',
      '--strict',
    },
    stream = 'stdout',
    ignore_exitcode = true,
    parser = require('lint.parser').from_pattern(
      '([^:]+):(%d+):?(%d*):%s+([^:]+):%s+(.*)',
      { 'file', 'lnum', 'col', 'severity', 'message' },
      {
        ['error'] = vim.diagnostic.severity.ERROR,
        ['note'] = vim.diagnostic.severity.INFO,
      },
      { source = 'mypy' },
      { lnum_offset = 0, col_offset = 0 }
    ),
  }
end
-- Create autocommand which carries out the actual linting
-- on the specified events.
local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  group = lint_augroup,
  callback = function()
    -- Only run the linter in buffers that you can modify in order to
    -- avoid superfluous noise, notably within the handy LSP pop-ups that
    -- describe the hovered symbol using Markdown.
    if vim.bo.modifiable then lint.try_lint() end
  end,
})
