return {
    {
        "stevearc/conform.nvim",
        event = { "BufReadPre", "BufNewFile" },
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

            -- Use Biome when the project has a Biome config, otherwise fall back to Prettier.
            local function has_biome_config(bufnr)
                local dir = vim.api.nvim_buf_get_name(bufnr)
                dir = dir ~= "" and vim.fs.dirname(dir) or vim.fn.getcwd()
                return vim.fs.find({ "biome.json", "biome.jsonc" }, { path = dir, upward = true })[1] ~= nil
            end

            local function js_formatters(bufnr)
                if has_biome_config(bufnr) then
                    return { "biome", "biome-organize-imports" }
                end
                return { "prettier" }
            end

            conform.setup({
                formatters_by_ft = {
                    javascript = js_formatters,
                    typescript = js_formatters,
                    typescriptreact = js_formatters,
                    svelte = js_formatters,
                    json = js_formatters,
                    yaml = { "yamlfmt" },
                    html = { "prettier", stop_after_first = true },
                    python = { "ruff" },
                    cs = { "csharpier" },
                    lua = { "stylua" },
                    java = { "spotless_maven", "spotless_gradle" },
                    rust = { "rustfmt" },
                    go = { "golangci-lint" },
                },
                formatters = {
                    prettierd = {
                        env = {
                            PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.prettierrc"),
                        },
                    },
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
                    csharpier = {
                        command = "csharpier",
                        args = { "format", "--write-stdout" },
                    },
                },
                log_level = vim.log.levels.DEBUG,
            })

            -- Create "Format" command for range formatting
            vim.api.nvim_create_user_command("FormatRange", function(args)
                local range = nil
                if args.count ~= -1 then
                    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
                    range = {
                        start = { args.line1, 0 },
                        ["end"] = { args.line2, end_line:len() },
                    }
                end
                require("conform").format({ async = true, lsp_format = "fallback", range = range })
            end, { range = true })
        end,
    },
}
