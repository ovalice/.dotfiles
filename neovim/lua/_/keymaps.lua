vim.g.mapleader = ' '

-- Keep cursor on the center of the screen when hopping
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-f>', '<C-f>zz')
vim.keymap.set('n', '<C-b>', '<C-b>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- For inserting empty lines without entering insert mode
vim.keymap.set('n', '<leader>o', 'o<Esc>k')
vim.keymap.set('n', '<leader>O', 'O<Esc>j')

-- Copy to system clipboard
vim.keymap.set({'n', 'v'}, '<leader>y', [["+y]])

-- Delete to black hole register
vim.keymap.set({'n', 'v'}, '<leader>d', [["_d]])

-- Paste inline
vim.keymap.set('n', '<leader>p', 'pkJ')