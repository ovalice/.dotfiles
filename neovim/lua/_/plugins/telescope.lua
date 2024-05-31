return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.7',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make'
            }
        },
        config = function()
            require('telescope').load_extension('fzf')

            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        end
    }
}
