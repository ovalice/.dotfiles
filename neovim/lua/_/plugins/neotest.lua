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
            icons = {
                failed = 'X',
                passed = 'OK',
                skipped = '>>',
                unknown = '?',
                watching = '@',
                running = '/',
                notify = 'N',
            },
        })

        vim.keymap.set('n', '<leader>tn',  function() neotest.run.run()                        end, { desc = '[T]est [N]earest'         })
        vim.keymap.set('n', '<leader>td',  function() neotest.run.run(vim.fn.expand('%'))      end, { desc = '[T]est [D]ocument'        })
        vim.keymap.set('n', '<leader>ts',  function() neotest.run.stop()                       end, { desc = '[T]est [S]top'            })
        vim.keymap.set('n', '<leader>ttw', function() neotest.summary.toggle()                 end, { desc = '[T]oggle [T]est [W]indow' })
        vim.keymap.set('n', '<leader>tw',  function() neotest.run.toggle()                     end, { desc = '[T]est [W]atch'           })
        vim.keymap.set('n', '<leader>tfw', function() neotest.watch.toggle(vim.fn.expand("%")) end, { desc = '[T]est [F]ile [W]atch'    })
        
        vim.keymap.set('n', '<leader>ta', function() 
            neotest.run.run({ suite = true })
            neotest.summary.open()
        end,   { desc = '[T]est [A]ll' })
    end
}
