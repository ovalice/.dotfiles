local on_lsp_attach = function(client, bufnr)
    local opts = { buffer = bufnr }

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-h>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>cc', function()
        vim.lsp.buf.format { async = true }
    end, opts)
end

return {
    {
        'j-hui/fidget.nvim',
        config = true,
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
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

            local ensure_installed = {
                'bashls',                   --
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
            }

            if vim.fn.has('win32') == 1 then
                table.insert(ensure_installed, 'powershell_es')
            end
    
            require('fidget').setup({})
            require('mason').setup()
            require('mason-lspconfig').setup({
                ensure_installed = ensure_installed,
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

                    ['powershell_es'] = function()
                        shell = 'powershell.exe'
                    end
                }
            })
    
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(args)
                    local bufnr = args.buf
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
    
                    on_lsp_attach(client, bufnr)
                end,
            })
        end
    },
    {
        -- Required to run :CSInstallRoslyn after. 
        -- Try https://github.com/jmederosalvarado/roslyn.nvim/issues/18#issuecomment-1864605065 if ':CSInstallRoslyn' doesn't work.
        'jmederosalvarado/roslyn.nvim',
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

            require('roslyn').setup({
                on_attach = on_lsp_attach,
                capabilities = capabilities
            })
        end
    }
}
