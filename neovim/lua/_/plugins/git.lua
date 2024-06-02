return {
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            local gitsigns = require('gitsigns')

            gitsigns.setup({
                current_line_blame = true,
                current_line_blame_opts = {
                    delay = 200,
                }
            })

            vim.keymap.set('n', '<leader>gs', gitsigns.stage_hunk)
            vim.keymap.set('n', '<leader>gr', gitsigns.reset_hunk)
            vim.keymap.set('v', '<leader>gs', function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
            vim.keymap.set('v', '<leader>gr', function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
            vim.keymap.set('n', '<leader>gS', gitsigns.stage_buffer)
            vim.keymap.set('n', '<leader>gR', gitsigns.reset_buffer)
        end
    },
    {
        'sindrets/diffview.nvim',
        config = function()
            require('diffview').setup({
                use_icons = false,
                signs = {
                    fold_open = '▼',
                    fold_closed = '►'
                },
                default = {
                    layout = 'diff2_horizontal'
                },
                merge_tool = {
                    layout = 'diff3_horizontal'
                },
                file_history = {
                    layout = 'diff2_horizontal'
                }
                -- keymaps = {
                --     view = {
                --         { "n", "[x",          actions.prev_conflict,                  { desc = "In the merge-tool: jump to the previous conflict" } },
                --         { "n", "]x",          actions.next_conflict,                  { desc = "In the merge-tool: jump to the next conflict" } },
                --         { "n", "<leader>co",  actions.conflict_choose("ours"),        { desc = "Choose the OURS version of a conflict" } },
                --         { "n", "<leader>ct",  actions.conflict_choose("theirs"),      { desc = "Choose the THEIRS version of a conflict" } },
                --         { "n", "<leader>cb",  actions.conflict_choose("base"),        { desc = "Choose the BASE version of a conflict" } },
                --         { "n", "<leader>ca",  actions.conflict_choose("all"),         { desc = "Choose all the versions of a conflict" } },
                --         { "n", "dx",          actions.conflict_choose("none"),        { desc = "Delete the conflict region" } }
                --     },
                --     diff4 = {
                --         { { "n", "x" }, "1do",  actions.diffget("base"),            { desc = "Obtain the diff hunk from the BASE version of the file" } },
                --         { { "n", "x" }, "2do",  actions.diffget("ours"),            { desc = "Obtain the diff hunk from the OURS version of the file" } },
                --         { { "n", "x" }, "3do",  actions.diffget("theirs"),          { desc = "Obtain the diff hunk from the THEIRS version of the file" } },
                --         { "n",          "g?",   actions.help({ "view", "diff4" }),  { desc = "Open the help panel" } },
                --     },
                --     file_panel = {
                --         { "n", "-",              actions.toggle_stage_entry,             { desc = "Stage / unstage the selected entry" } },
                --         { "n", "s",              actions.toggle_stage_entry,             { desc = "Stage / unstage the selected entry" } },
                --         { "n", "S",              actions.stage_all,                      { desc = "Stage all entries" } },
                --         { "n", "U",              actions.unstage_all,                    { desc = "Unstage all entries" } },
                --     }
                -- }
            })

            vim.keymap.set('n', '<leader>gdt', function()
                if vim.bo.ft == 'DiffviewFiles' then
                    vim.cmd('DiffviewClose')
                else
                    vim.cmd('DiffviewOpen')
                end
            end)

            vim.keymap.set('n', '<leader>gdr', function()
                if vim.bo.ft == 'DiffviewFiles' then
                    vim.cmd('DiffviewClose')
                end

                local rev = vim.fn.input('Revision > ')
                vim.cmd('DiffviewOpen ' .. rev)
            end)

            vim.keymap.set('n', '<leader>gfh', function()
                if vim.bo.ft == 'DiffviewFileHistory' then
                    vim.cmd('DiffviewClose')
                else
                    vim.cmd('DiffviewFileHistory')
                end
            end)
        end
    }
}