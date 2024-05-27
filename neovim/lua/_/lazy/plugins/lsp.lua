return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'j-hui/fidget.nvim',
    },
    -- NPM is required to install several LSPs
    --
    -- It's important that LSP plugins are set up in order:
    -- mason.vnim -> mason-lspconfig.nvim -> lspconfig
    config = function()
        local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
        lsp_capabilities.textDocument.completion.completionItem.snippetSupport = true


        local cmp_lsp = require('cmp_nvim_lsp')
        local cmp_capabilities = cmp_lsp.default_capabilities()

        local capabilities = vim.tbl_deep_extend(
            'force',
            {},
            lsp_capabilities,
            cmp_capabilities)

        require('fidget').setup({})
        require('mason').setup()
        require('mason-lspconfig').setup({
            ensure_installed = {
                'bashls',                   --
                'csharp_ls',                -- Requires dotnet-sdk
                'cssls',                    --
                'dockerls',                 --
                'eslint',                   --
                'html',                     --
                'jsonls',                   --
                'lua_ls',                   --
                'marksman',                 --
                'svelte',                   -- Requires typescript-svelte-plugin (see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#svelte)
                'tsserver',                 -- Requires "npm i -g typescript"
                'yamlls'                    --
            },
            handlers = {
                function (server_name)
                    require('lspconfig')[server_name].setup({
                        capabilities = capabilities,
                    })
                end,

                ['lua_ls'] = function ()
                    require('lspconfig').lua_ls.setup({
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { 'vim', 'require' },
                                }
                            }
                        }
                    })
                end,
            }
        })

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
                local opts = { buffer = ev.buf }
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                vim.keymap.set('n', '<C-h>', vim.lsp.buf.signature_help, opts)
                vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
                vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                vim.keymap.set('n', '<space>f', function()
                    vim.lsp.buf.format { async = true }
                end, opts)
            end,
          })
    end
}
