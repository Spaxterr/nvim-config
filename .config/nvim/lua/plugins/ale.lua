return {
    {
        "dense-analysis/ale",
        lazy = false,
        config = function()
            local g = vim.g

            g.ale_cursor_detail = 1
            g.ale_list_window_size = 5
            g.ale_detail_to_floating_preview = 1
            g.ale_floating_window_border = {}
            g.ale_set_balloons = 1
            g.ale_floating_window_preview = 1
            g.ale_hover_delay = 100
            g.ale_virtualtext_cursor = 1

            g.ale_warn_about_trailing_whitespace = 1
            g.ale_echo_msg_format = "[%linter%] %s (%code%)"
            g.ale_window_msg_format = "[%linter%] %s (%code%)"
            g.ale_disable_lsp = 1
            g.ale_use_neovim_diagnostics_api = 1

            g.ale_linters = {
                lua = { "lua_language_server" },
                javascript = { "eslint" },
                typescript = { "eslint" },
            }
        end,
    },
}
