return {
    {
        "mfussenegger/nvim-lint",
        event = "BufEnter",
        config = function()
            local lint = require("lint")

            lint.linters_by_ft = {
                lua = { "lua_language_server", },
                javascript = { "eslint", },
                typescript = { "eslint", },
                typescriptreact = { "eslint", },
                python = { "ruff", },
                java = { "checkstyle", },
                go = { "golangcilint", },
            }

            -- Custom ruff configuration
            lint.linters.ruff.args = {
                "check",
                "--config",
                "./pyproject.toml",
                "--output-format",
                "json",
                "--stdin-filename",
                function() return vim.api.nvim_buf_get_name(0) end,
                "-",
            }

            -- Custom checkstyle configuration for Java
            if lint.linters.checkstyle then
                lint.linters.checkstyle.args = {
                    "-c",
                    "checkstyle.xml",
                    "-f",
                    "json",
                }
            end

            -- Disable linting for specific patterns
            local function should_lint()
                local bufname = vim.api.nvim_buf_get_name(0)
                local ignored_patterns = {
                    "%.git/",
                    "node_modules/",
                    "%.min%.js$",
                }

                for _, pattern in ipairs(ignored_patterns) do
                    if bufname:match(pattern) then
                        return false
                    end
                end

                -- Check file size (1MB limit)
                local max_filesize = 1000000
                local ok, stats = pcall(vim.loop.fs_stat, bufname)
                if ok and stats and stats.size > max_filesize then
                    return false
                end

                return true
            end

            local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
            vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
                group = lint_augroup,
                callback = function()
                    if should_lint() and vim.bo.modifiable then
                        lint.try_lint()
                        lint.try_lint('cspell')
                    end
                end,
            })
        end
    }
}
