-- ============================================================
-- SECTION 1: OPTIONS
-- Core Neovim settings and options.
-- ============================================================
do

  -- Make line numbers default
  local o = vim.opt
  o.number = true
  o.relativenumber = true
  -- You can also add relative line numbers, to help with jumping.
  --  Experiment for yourself to see if you like it!

  -- Enable mouse mode, can be useful for resizing splits for example!
  o.mouse = 'a'

  -- Don't show the mode, since it's already in the status line
  o.showmode = false

  -- Sync clipboard between OS and Neovim.
  --  Schedule the setting after `UiEnter` because it can increase startup-time.
  --  Remove this option if you want your OS clipboard to remain independent.
  --  See `:help 'clipboard'`
  vim.schedule(function() o.clipboard = 'unnamedplus' end)

  -- Enable break indent
  o.breakindent = true

  -- Enable undo/redo changes even after closing and reopening a file
  o.undofile = true

  -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
  o.ignorecase = true
  o.smartcase = true

  -- Keep signcolumn on by default
  o.signcolumn = 'yes'

  -- Decrease update time (update swap file after 250 milliseconds of inactivity)
  o.updatetime = 250

  -- Decrease mapped sequence wait time (used by which-key plugin)
  o.timeoutlen = 300

  -- Configure how new splits should be opened
  o.splitright = true
  o.splitbelow = true

  -- enable 24 bit RGB i.e. true color support in terminal base instances.
  o.termguicolors = true

  -- indendation related options
  --o.expandtab = true
  --o.shiftwidth = 4
  --o.tabstop = 4
  --o.smartindent = true

  -- Sets how neovim will display certain whitespace characters in the editor.
  --  See `:help 'list'`
  --  and `:help 'listchars'`
  --
  --  Notice listchars is set using `vim.opt` instead of `vim.o`.
  --  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
  --   See `:help lua-options`
  --   and `:help lua-guide-options`
  o.list = true
  o.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

  -- Preview substitutions live, as you type!
  o.inccommand = 'split'

  -- Show which line your cursor is on
  o.cursorline = true

  -- Minimal number of screen lines to keep above and below the cursor.
  o.scrolloff = 10

  -- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
  -- instead raise a dialog asking if you wish to save the current file(s)
  -- See `:help 'confirm'`
  o.confirm = true
end
