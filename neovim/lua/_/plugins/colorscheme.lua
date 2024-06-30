return {
    {
        'dasupradyumna/midnight.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd('colorscheme midnight')
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
        config = true,
    },
}
