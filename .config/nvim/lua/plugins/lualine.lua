return {
    {
        'nvim-lualine/lualine.nvim',
        lazy = false,
        config = function()
            require('lualine').setup {
                options = {
                    theme = 'auto',
                    component_separators = { left = '\u{e0b5}', right = '\u{e0b7}' },
                    section_separators = { left = '\u{e0b4}', right = '\u{E0B6}' },
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch', 'diff', 'diagnostics' },
                    lualine_c = { 'filename', },
                    lualine_x = { 'filesize', 'g:coc_status' },
                    lualine_y = { 'filetype' },
                    lualine_z = { 'location' },
                },
                globalstatus = true,
            }
        end,
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    }
}
