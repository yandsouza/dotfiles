 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#291418',
    base01 = '#452129',
    base02 = '#3e1e25',
    base03 = '#716265',
    base04 = '#b6afb0',
    base05 = '#f3f2f2',
    base06 = '#f3f2f2',
    base07 = '#f3f2f2',
    base08 = '#be6377',
    base09 = '#ccb666',
    base0A = '#d67d5c',
    base0B = '#e46783',
    base0C = '#e9d796',
    base0D = '#ec93a7',
    base0E = '#e9ac96',
    base0F = '#f4ccbe',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- telescope.nvim
  hi('TelescopeNormal',         { fg = '#f3f2f2',          bg = '#291418' })
  hi('TelescopeBorder',         { fg = '#716265',             bg = '#291418' })
  hi('TelescopePromptNormal',   { fg = '#f3f2f2',          bg = '#291418' })
  hi('TelescopePromptBorder',   { fg = '#716265',             bg = '#291418' })
  hi('TelescopePromptPrefix',   { fg = '#e46783',             bg = '#291418' })
  hi('TelescopePromptCounter',  { fg = '#b6afb0',  bg = '#291418' })
  hi('TelescopePromptTitle',    { fg = '#291418',             bg = '#e46783' })
  hi('TelescopePreviewTitle',   { fg = '#291418',             bg = '#d67d5c' })
  hi('TelescopeResultsTitle',   { fg = '#291418',             bg = '#ccb666' })
  hi('TelescopeSelection',      { fg = '#f3f2f2',          bg = '#3e1e25' })
  hi('TelescopeSelectionCaret', { fg = '#e46783',             bg = '#3e1e25' })
  hi('TelescopeMatching',       { fg = '#e46783',             bold = true })

  -- mini.pick
  hi('MiniPickNormal',         { fg = '#f3f2f2',          bg = '#291418' })
  hi('MiniPickBorder',         { fg = '#716265',             bg = '#291418' })
  hi('MiniPickPrompt',   { fg = '#f3f2f2',          bg = '#291418' })
  hi('MiniPickPromptPrefix',   { fg = '#e46783',             bg = '#291418' })
  hi('MiniPickBorderText',    { fg = '#291418',             bg = '#e46783' })
  hi('MiniPickMatchCurrent',      { fg = '#f3f2f2',          bg = '#3e1e25' })
  hi('MiniPickPromptCaret', { fg = '#e46783',             bg = '#3e1e25' })
  hi('MiniPickMatchRanges',       { fg = '#e46783',             bold = true })
end

-- Register a signal handler for SIGUSR1 (matugen updates).
-- The handler re-requires this module, which re-runs the code below, so the
-- previous handle is stopped first; otherwise handlers double on every signal.
if _G.__matugen_signal then
  _G.__matugen_signal:stop()
  _G.__matugen_signal:close()
end

local signal = vim.uv.new_signal()
_G.__matugen_signal = signal
signal:start(
  'sigusr1',
  vim.schedule_wrap(function()
    package.loaded['matugen'] = nil
    require('matugen').setup()
  end)
)

return M
