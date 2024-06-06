return {
    -- {
    --     'rebelot/kanagawa.nvim',
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         vim.cmd('colorscheme kanagawa-dragon')
    --         vim.cmd('hi ColorColumn guibg=#101010')
    --     end
    -- },
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
        config = function()
            require('lualine').setup({
                options = {
                    icons_enabled = false,
                    section_separators = '',
                    component_separators = ''
                }
            })
        end
    },
}
