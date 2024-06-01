local my_group = vim.api.nvim_create_augroup('MyGroup', {})

-- Remove trailing whitespace on write
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    group = my_group,
    pattern = '*',
    command = [[%s/\s\+$//e]],
})
