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
            local ts = require('telescope')

            ts.setup({});

            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})

            ts.load_extension('fzf')
        end
    }
}
