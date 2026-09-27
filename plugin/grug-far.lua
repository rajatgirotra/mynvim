-- ~/.config/nvim/plugin/grug-far.lua

vim.pack.add({
  -- { src = 'https://github.com/MagicDuck/grug-far.nvim' },
  -- to pin to the latest release tag instead of the default branch:
  { src = 'https://github.com/MagicDuck/grug-far.nvim', version = vim.version.range('*') },
})

require('grug-far').setup({
  engine = 'ripgrep',
  engines = {
    ripgrep = {
      -- always-on flags; keep this short, put per-search flags in the Flags field
      extraArgs = '--hidden --glob=!.git/',
    },
  },
  windowCreationCommand = 'vsplit',  -- default; 'tabnew' if you like your tab workflow
  startInInsertMode = true,
  maxSearchMatches = 5000,           -- default 2000, low for a big C++ tree
  folding = { enabled = true, foldlevel = 1 },  -- start with files collapsed
})

local function grug(opts)
  return function() require('grug-far').open(opts) end
end

vim.keymap.set('n', '<leader>rr', grug(), { desc = 'G[r]ug-far: [r]eplace in project' })
vim.keymap.set('n', '<leader>rw', function()
  require('grug-far').open({ prefills = { search = vim.fn.expand('<cword>') } })
end, { desc = 'G[r]ug-far: current [w]ord' })
vim.keymap.set('n', '<leader>rf', function()
  require('grug-far').open({ prefills = { paths = vim.fn.expand('%') } })
end, { desc = 'G[r]ug-far: current [f]ile only' })
vim.keymap.set('x', '<leader>r', function()
  require('grug-far').with_visual_selection()
end, { desc = 'G[r]ug-far: visual selection' })
