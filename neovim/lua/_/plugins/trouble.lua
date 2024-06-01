return {
    'folke/trouble.nvim',
    config = function()
        local trouble = require('trouble')
        
        vim.keymap.set('n', '<leader>xw', function()
            trouble.toggle('diagnostics')
        end)

        vim.keymap.set('n', '<leader>xd', function()
            trouble.toggle()
        end)
    end
}