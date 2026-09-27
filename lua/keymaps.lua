-- ============================================================
-- SECTION 2: KEYMAPS & AUTOCMDS
-- basic keymaps, basic autocmds
-- ============================================================
do
  -- [[ Basic Keymaps ]]
  --  See `:help vim.keymap.set()`

  -- Clear highlights on search when pressing <Esc> in normal mode
  --  See `:help hlsearch`
  vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

  -- Diagnostic Config & Keymaps
  --  See `:help vim.diagnostic.Opts`
  vim.diagnostic.config {
    update_in_insert = false,
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = { severity = { min = vim.diagnostic.severity.WARN } },

    -- Can switch between these as you prefer
    virtual_text = true, -- Text shows up at the end of the line
    virtual_lines = false, -- Text shows up underneath the line, with virtual lines

    -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
    jump = {
      on_jump = function(_, bufnr)
        vim.diagnostic.open_float {
          bufnr = bufnr,
          scope = 'cursor',
          focus = false,
        }
      end,
    },
  }

  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

  -- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
  -- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
  -- is not what someone will guess without a bit more experience.
  --
  -- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
  -- or just use <C-\><C-n> to exit terminal mode
  vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

  -- TIP: Disable arrow keys in normal mode
  -- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
  -- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
  -- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
  -- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

  -- Keybinds to make split navigation easier.
  --  Use CTRL+<hjkl> to switch between windows
  --
  --  See `:help wincmd` for a list of all window commands
  vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
  vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
  vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
  vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

  -- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
  -- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
  -- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
  -- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
  -- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

  -- Tabs
  for i = 1, 9 do
    vim.keymap.set('n', '<A-' .. i .. '>', i .. 'gt', { desc = 'Go to tab ' .. i })
  end
  vim.keymap.set('n', '<A-l>', 'gt', { desc = 'Next tab' })
  vim.keymap.set('n', '<A-h>', 'gT', { desc = 'Prev tab' })

  -- Splits
  vim.keymap.set('n', '<leader>v', '<C-w>v', { desc = 'Split right' })
  vim.keymap.set('n', '<leader>T', '<C-w>T', { desc = 'Move window to new tab' })

  -- Close
  vim.keymap.set('n', '<leader>x', '<cmd>confirm q<CR>', { desc = 'Close window/tab' })
  vim.keymap.set('n', '<leader>X', '<cmd>confirm bdelete<CR>', { desc = 'Close buffer' })

  -- [[ Basic Autocommands ]]
  --  See `:help lua-guide-autocommands`

  -- Highlight when yanking (copying) text
  --  Try it with `yap` in normal mode
  --  See `:help vim.hl.on_yank()`
  vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function() vim.hl.on_yank() end,
  })
end

local function tab_to_split(dir, vertical)
  if vim.fn.tabpagenr('$') == 1 then
    return vim.notify('only one tab', vim.log.levels.WARN)
  end
  local buf  = vim.api.nvim_get_current_buf()
  local view = vim.fn.winsaveview()
  local n    = vim.fn.tabpagenr()
  local target = (dir == 'prev') and math.max(n - 1, 1) or n

  vim.cmd('tabclose')
  vim.cmd(target .. 'tabnext')
  vim.cmd(vertical and 'vsplit' or 'split')
  vim.api.nvim_win_set_buf(0, buf)
  vim.fn.winrestview(view)
end

vim.api.nvim_create_user_command('TabToPrev', function() tab_to_split('prev', false) end, {})
vim.api.nvim_create_user_command('TabToNext', function() tab_to_split('next', false) end, {})

vim.keymap.set('n', '<leader>wp', '<cmd>TabToPrev<cr>', { desc = 'Tab -> split in prev tab' })
vim.keymap.set('n', '<leader>wn', '<cmd>TabToNext<cr>', { desc = 'Tab -> split in next tab' })
