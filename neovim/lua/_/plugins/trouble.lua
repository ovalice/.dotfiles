return {
    'folke/trouble.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        local trouble = require('trouble')
        
        vim.keymap.set('n', '<leader>xd', function()
            trouble.toggle('diagnostics')
        end)

        vim.keymap.set('n', '<leader>xq', function()
            trouble.toggle('quickfix')
        end)
    end
}