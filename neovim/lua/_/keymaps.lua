vim.g.mapleader = ' '

vim.keymap.set('n', '-', ':Explore<CR>', { silent = true })

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-f>', '<C-f>zz')
vim.keymap.set('n', '<C-b>', '<C-b>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')