vim.pack.add {
  { src = 'https://github.com/goolord/alpha-nvim' },
}

require('alpha').setup(require('alpha.themes.theta').config)

vim.pack.add {
  'https://github.com/sphamba/smear-cursor.nvim',
}

require('smear_cursor').setup {
  stiffness = 0.8,
  trailing_stiffness = 0.6,
  stiffness_insert_mode = 0.7,
  trailing_stiffness_insert_mode = 0.7,
  damping = 0.95,
  damping_insert_mode = 0.95,
  distance_stop_animating = 0.5,
}

vim.pack.add {
  'https://github.com/catgoose/nvim-colorizer.lua',
}
require('colorizer').setup()

vim.pack.add {
  'https://github.com/karb94/neoscroll.nvim',
}

require('neoscroll').setup {
  mappings = { -- Keys to be mapped to their corresponding default scrolling animation
    '<C-u>',
    '<C-d>',
    '<C-b>',
    '<C-f>',
    '<C-y>',
    '<C-e>',
    'zt',
    'zz',
    'zb',
  },
  hide_cursor = true, -- Hide cursor while scrolling
  stop_eof = true, -- Stop at <EOF> when scrolling downwards
  respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
  cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
  duration_multiplier = 1.0, -- Global duration multiplier
  easing = 'linear', -- Default easing function
  pre_hook = nil, -- Function to run before the scrolling animation starts
  post_hook = nil, -- Function to run after the scrolling animation ends
  performance_mode = false, -- Disable "Performance Mode" on all buffers.
  ignored_events = { -- Events ignored while scrolling
    'WinScrolled',
    'CursorMoved',
  },
}
