return {
    {
        'ibhagwan/fzf-lua',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            local fzf = require('fzf-lua')

            fzf.setup({
                files = {
                    formatter = 'path.filename_first',
                }
            })

            vim.keymap.set('n', '<leader>ff', function() fzf.files() end)
            vim.keymap.set('n', '<leader>fc', function() fzf.grep_cword() end)
            vim.keymap.set('n', '<leader>fw', function() fzf.live_grep_native() end)
            vim.keymap.set('n', '<leader>fr', function() fzf.resume() end)
            vim.keymap.set('n', '<leader>fs', function() fzf.lsp_document_symbols() end)
            vim.keymap.set('n', '<leader>fsw', function() fzf.lsp_live_workspace_symbols() end)
        end
    }
}
