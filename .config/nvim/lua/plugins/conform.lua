return {
    {
        "stevearc/conform.nvim",
        config = function()
            local conform = require("conform")

            local function get_prettier_config()
                local ctx_dirname = vim.fn.getcwd()
                local local_prettier_config = vim.fs.find(".prettierrc", {
                    upward = true,
                    path = ctx_dirname,
                    type = "file",
                })[1]
                local global_prettier_config = vim.fs.find(".prettierrc", {
                    path = vim.fn.expand("~/"),
                    type = "file",
                })[1]

                if local_prettier_config then
                    return local_prettier_config
                elseif global_prettier_config then
                    return global_prettier_config
                end
                return nil
            end

            conform.setup({
                formatters_by_ft = {
                    javascript = { "prettier" },
                    typescript = { "prettier" },
                    svelte = { "prettier" },
                    json = { "prettier" },
                    lua = { "stylua" },
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
