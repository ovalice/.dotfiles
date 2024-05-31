return {
    {
        'rebelot/kanagawa.nvim',
        lazy = false,
        priority = 1000, -- Ensure it loads first
        config = function()
            vim.cmd('colorscheme kanagawa-dragon')
            vim.cmd('hi ColorColumn guibg=#101010')
        end
    },
}