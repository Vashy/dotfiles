-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

local functions = require 'config.functions'

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Pastes copied text into _ (without overriding paste buffer)
vim.keymap.set('x', '<leader>p', '"_dP', { desc = 'Paste without overriding buffer' })
vim.keymap.set('n', '<leader>d', '"_dP', { desc = 'Paste without overriding buffer' })
vim.keymap.set('v', '<leader>d', '"_dP', { desc = 'Paste without overriding buffer' })

-- System clipboard
vim.keymap.set('n', '<leader>y', '"+y', { desc = 'Copy to system clipboard' })
vim.keymap.set('v', '<leader>y', '"+y', { desc = 'Copy to system clipboard' })
vim.keymap.set('n', '<leader>Y', '"+Y', { desc = 'Copy line to system clipboard' })

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move lines down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move lines up' })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- vim.keymap.set('n', '<leader>e', vim.cmd.Ex, { desc = 'File Explorer' }) -- default vim explorer
vim.keymap.set('n', '<leader>e', '<CMD>Oil --float<CR>', { desc = 'File Explorer (oil)' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
-- vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
-- vim.keymap.set('n', '<A-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<A-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<A-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<A-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- Note that I lose (-) decrease height and (|) max out width
vim.keymap.set('n', '<C-w>-', '<C-w>s', { desc = 'Split horizontal', remap = false })
vim.keymap.set('n', '<C-w>|', '<C-w>v', { desc = 'Split vertical', remap = false })

-- Handled by gx.nvim
vim.keymap.del({ 'n', 'x' }, 'gx')

-- Handled by todofloat.lua
vim.keymap.set('n', '<leader>T', ':TdNotes<CR>', { desc = 'Open global Todo', silent = true })

-- Sum
vim.keymap.set('n', '<leader>C', functions.math.calculate_register, { desc = 'Sum values in register " (\\n separated)' })
vim.keymap.set('v', '<leader>C', functions.math.calculate_visual, { desc = 'Sum values in visual selection (\\n separated)' })
