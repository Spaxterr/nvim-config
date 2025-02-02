return {
    {
        "stevearc/conform.nvim",
        config = function()
            local conform = require("conform")

            -- List of possible Prettier config file names.
            local prettier_files = {
                ".prettierrc",
                ".prettierrc.json",
                ".prettierrc.js",
                ".prettierrc.cjs",
                ".prettierrc.yaml",
                ".prettierrc.yml",
                "prettier.config.js",
                "prettier.config.cjs",
            }

            local function find_config_in_path(path)
                for _, filename in ipairs(prettier_files) do
                    local results = vim.fs.find(filename, {
                        path = path,
                        upward = false, -- Only search in the given directory.
                        type = "file",
                        hidden = true, -- Include hidden files in the search.
                    })
                    if results then
                        for _, file in ipairs(results) do
                            -- Ignore any file that is in a node_modules directory.
                            if not file:find("node_modules") then
                                return file
                            end
                        end
                    end
                end
                return nil
            end

            local function get_prettier_config()
                local cwd = vim.fn.getcwd()

                -- Check only the local (current) directory.
                local local_config = find_config_in_path(cwd)
                if local_config then
                    print("Formatting file using", local_config)
                    return local_config
                end

                -- Fallback: check for a global config in your home directory.
                local home = vim.fn.expand("~")
                local global_config = find_config_in_path(home)
                if global_config then
                    print("Formatting file using", global_config)
                    return global_config
                end

                vim.notify("No prettier config found", vim.log.levels.WARN)
                return nil
            end

            conform.setup({
                formatters_by_ft = {
                    javascript = { "prettier" },
                    typescript = { "prettier" },
                    svelte = { "prettier" },
                    json = { "prettier" },
                    html = { "prettier" },
                    lua = { "stylua" },
                    java = { "clang-format" },
                },
                formatters = {
                    prettier = {
                        prepend_args = function()
                            local config = get_prettier_config()
                            if config then
                                return { "--config", config }
                            end
                            return {}
                        end,
                    },
                },
                log_level = vim.log.levels.DEBUG,
            })
        end,
    },
}
