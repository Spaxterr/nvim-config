return {
    {
        "stevearc/conform.nvim",
        event = "LspAttach",
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

            local function get_prettier_config()
                local cwd = vim.fn.getcwd()

                for _, filename in ipairs(prettier_files) do
                    local full_path = cwd .. "/" .. filename
                    if vim.uv.fs_stat(full_path) then
                        return full_path
                    end
                end

                vim.notify("ℹ️ No Prettier config found in the current directory", vim.log.levels.WARN)
                return nil
            end

            conform.setup({
                formatters_by_ft = {
                    javascript = { "prettierd", "prettier", stop_after_first = true },
                    typescript = { "prettierd", "prettier", stop_after_first = true },
                    svelte = { "prettierd", "prettier", stop_after_first = true },
                    json = { "prettierd", "prettier", stop_after_first = true },
                    html = { "prettierd", "prettier", stop_after_first = true },
                    python = { "black" },
                    lua = { "stylua" },
                    java = { "clang-format" },
                    rust = { "rustfmt" },
                    go = { "golangci-lint" },
                },
                formatters = {
                    prettier = {
                        prepend_args = function()
                            local config = get_prettier_config()
                            return config and { "--config", config } or {}
                        end,
                    },
                    clang_format = {
                        args = { "--assume-filename=.java", "--style=file" },
                        stdin = true,
                    },
                    black = {
                        command = "python3",
                        args = { "-m", "black", "-" },
                    },
                },
                log_level = vim.log.levels.DEBUG,
            })
        end,
    },
}
