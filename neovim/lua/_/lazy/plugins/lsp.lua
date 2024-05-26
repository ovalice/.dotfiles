return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/nvim-cmp',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        'j-hui/fidget.nvim',
    },

    -- NPM is required to install several LSPs
    --
    -- It's important that LSP plugins are set up in order:
    -- mason.vnim -> mason-lspconfig.nvim -> lspconfig
    config = function()
        local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
        lsp_capabilities.textDocument.completion.completionItem.snippetSupport = true

        local cmp = require('cmp')
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

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
            }, {
                { name = 'buffer' },
                { name = 'path' },
            }),
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                ['<C-space>'] = cmp.mapping.complete(), -- Mapping doesn't work on Windows because of this I think https://github.com/libuv/libuv/issues/1958 (otherwise use an nvim GUI client instead)
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
            }),
            completion = {
                completeopt = 'menu,menuone'
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
