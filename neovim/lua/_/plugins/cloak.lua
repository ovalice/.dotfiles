return {
    'laytan/cloak.nvim',
    config = function()
        require('cloak').setup({
            patterns = {
                {
                    file_pattern = { '.env', },
                    cloak_pattern = '=.+',
                },
                {
                    file_pattern = { 'secrets.json' },
                    cloak_pattern = ':.+'
                }
            }
        })
    end
}