return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        config = function()
            require('telescope').setup {
                pickers = {
                },
                defaults = {
                    preview = {
                        filesize_limit = 0.2
                    },
                    vimgrep_arguments = {
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                        "--trim"
                    }
                },
                extensions = {
                    fzy_native = {
                        override_generic_sorter = true,
                        override_file_sorter = true,
                    }
                }
            }
            -- Load extensions
            require('telescope').load_extension('fzy_native')
        end,
        lazy = true ,
    }
}
