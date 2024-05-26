return {
    {
        'olimorris/onedarkpro.nvim',
        priority = 1000, -- Ensure it loads first
        config = function()
            vim.cmd.colorscheme('onedark_dark')
            vim.cmd('hi ColorColumn guibg=#101010')
        end
    }
}