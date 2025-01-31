return {
    {
        "dense-analysis/ale",
        lazy = false,
        config = function()
            local g = vim.g

            g.ale_cursor_detail = 1 -- Show a preview when hovering over an erroring line
            g.ale_floating_preview = 1
            g.ale_close_preview_on_insert = 1
            g.ale_lint_on_text_changed = 'never'
            g.ale_open_list = 0
            g.ale_set_highlights = 1
            g.ale_virtualtext_cursor = 'disabled'
            g.ale_floating_window_border = {'│', '─', '╭', '╮', '╯', '╰', '│', '─'}

            g.ale_echo_msg_format = "[%linter%] %s (%code%)"
            g.ale_window_msg_format = "[%linter%] %s (%code%)"
            g.ale_disable_lsp = 1 -- Disable ALE since coc is present
            g.ale_use_neovim_diagnostics_api = 1

            g.python_flake8_options = "--config ./tox.ini --verbose"

            g.ale_java_checkstyle_options = "-c checkstyle.xml"

            g.ale_linters = {
                lua = { "lua_language_server", "cspell" },
                javascript = { "eslint", "cspell" },
                typescript = { "eslint", "cspell" },
                python = { "flake8", "cspell" },
            }
        end,
    },
}
