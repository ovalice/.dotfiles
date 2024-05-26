return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
        require('nvim-treesitter.configs').setup({
            ensure_installed = {
                'bash',
                'css',
                'dockerfile',
                'html',
                'javascript', 
                'jsdoc',
                'json',
                'lua',
                'sql',
                'svelte',
                'tsx',
                'typescript',
                'yaml'
            },

            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- Automatically install missing parsers when entering buffer
            auto_install = true,

            -- Indentation based on treesitter for the = operator. NOTE: This is an experimental feature
            indent = {
                enable = true
            },

            -- Consistent syntax highlighting
            highlight = {
                enable = true,

                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on "syntax" being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = { "markdown" },
            }
        })
    end
}