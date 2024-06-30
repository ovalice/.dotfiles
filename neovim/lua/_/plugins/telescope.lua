return {

    'nvim-telescope/telescope.nvim',
    tag = '0.1.7',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make'
        }
    },
    config = function()
        require('telescope').setup({
            defaults = {
                path_display = {
                    'filename_first',
                }
            }
        })
        require('telescope').load_extension('fzf')

        local builtin = require('telescope.builtin')

        vim.keymap.set('n', '<leader>ff', builtin.find_files)
        vim.keymap.set('n', '<leader>fF', function() builtin.find_files { hidden = true, no_ignore = true } end)
        vim.keymap.set('n', '<leader>fc', builtin.grep_string)
        vim.keymap.set('n', '<leader>fw', builtin.live_grep)
        vim.keymap.set('n', '<leader>fr', builtin.resume)
        vim.keymap.set('n', '<leader>fds', builtin.lsp_document_symbols)
        vim.keymap.set('n', '<leader>fs', builtin.lsp_dynamic_workspace_symbols)
    end
}
