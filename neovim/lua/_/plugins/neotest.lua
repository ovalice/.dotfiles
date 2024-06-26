-- TODO: Make it possible to re-run failed tests only
return {
    'nvim-neotest/neotest',
    dependencies = {
        'nvim-neotest/nvim-nio',
        'nvim-lua/plenary.nvim',
        'antoinemadec/FixCursorHold.nvim',
        'nvim-treesitter/nvim-treesitter',
        'Issafalcon/neotest-dotnet',
    },
    config = function()
        local neotest = require('neotest')
        
        neotest.setup({
            adapters = {
                require('neotest-dotnet')({
                    discovery_root = 'solution'
                })
            },
            summary = {
                mappings = {
                    run = 'r',
                    output = 'o',
                }
            },
        })

        vim.keymap.set('n', '<leader>tn',  function() neotest.run.run()                        end)
        vim.keymap.set('n', '<leader>td',  function() neotest.run.run(vim.fn.expand('%'))      end)
        vim.keymap.set('n', '<leader>ts',  function() neotest.run.stop()                       end)
        vim.keymap.set('n', '<leader>tt',  function() neotest.summary.toggle()                 end)
        vim.keymap.set('n', '<leader>tw',  function() neotest.watch.toggle()                   end)
        vim.keymap.set('n', '<leader>tfw', function() neotest.watch.toggle(vim.fn.expand("%")) end)
        
        vim.keymap.set('n', '<leader>ta', function() 
            neotest.run.run({ suite = true })
            neotest.summary.open()
        end)
    end
}
