local my_group = vim.api.nvim_create_augroup('MyGroup', {})
local yank_group = vim.api.nvim_create_augroup('HighlightYank', {})

-- Remove trailing whitespace on write
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    group = my_group,
    pattern = '*',
    command = [[%s/\s\+$//e]],
})

vim.api.nvim_create_autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function ()
       vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 200
        })
    end
})
