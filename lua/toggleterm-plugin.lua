local gh = require('helpers').gh

vim.pack.add {
  { src = gh 'akinsho/toggleterm.nvim',  version = vim.version.range '*' },
  { src = gh 'akinsho/bufferline.nvim',  version = vim.version.range '*' },
}

require('toggleterm').setup { size = 15, open_mapping = [[<C-\>]], direction = 'horizontal' }
require('bufferline').setup { options = { mode = 'tabs', numbers = 'ordinal', diagnostics = 'nvim_lsp' } }

