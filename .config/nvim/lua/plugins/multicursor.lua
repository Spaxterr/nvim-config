return {
    {
        "jake-stewart/multicursor.nvim",
        branch = "1.0",
        event = "VeryLazy",
        config = function()
            local mc = require("multicursor-nvim")
            mc.setup()

            local map = vim.keymap.set

            -- Add cursors above/below with <C-Up>/<C-Down>
            map({ "n", "v" }, "<C-Up>",   function() mc.lineAddCursor(-1) end, { desc = "Add cursor above" })
            map({ "n", "v" }, "<C-Down>", function() mc.lineAddCursor(1)  end, { desc = "Add cursor below" })

            -- Add cursor at next/prev match of word under cursor
            map({ "n", "v" }, "<C-n>", function() mc.matchAddCursor(1)  end, { desc = "Add cursor at next match" })
            map({ "n", "v" }, "<C-p>", function() mc.matchAddCursor(-1) end, { desc = "Add cursor at prev match" })

            -- Skip current match and move to next/prev
            map({ "n", "v" }, "<C-s>", function() mc.matchSkipCursor(1)  end, { desc = "Skip match, next" })
            map({ "n", "v" }, "<C-S-s>", function() mc.matchSkipCursor(-1) end, { desc = "Skip match, prev" })

            -- Select all matches of word under cursor
            map({ "n", "v" }, "<leader>ma", mc.matchAllAddCursors, { desc = "Add cursors at all matches" })

            -- Rotate through cursors
            map({ "n", "v" }, "<left>",  mc.prevCursor, { desc = "Prev cursor" })
            map({ "n", "v" }, "<right>", mc.nextCursor, { desc = "Next cursor" })

            -- Delete the cursor under the main cursor
            map({ "n", "v" }, "<leader>mx", mc.deleteCursor, { desc = "Delete cursor" })

            -- Align cursors by column
            map("n", "<leader>ml", mc.alignCursors, { desc = "Align cursors" })

            -- Split visual selection into per-line cursors
            map("v", "<leader>ms", mc.splitCursors, { desc = "Split cursors per line" })

            -- Transpose character sequences at each cursor
            map("v", "<leader>mt", mc.transposeCursors, { desc = "Transpose cursors" })

            -- Esc clears cursors; if already one cursor, behaves normally
            map("n", "<esc>", function()
                if not mc.cursorsEnabled() then
                    mc.enableCursors()
                elseif mc.hasCursors() then
                    mc.clearCursors()
                else
                    vim.cmd("nohlsearch")
                end
            end)

            -- Customize cursor appearance
            mc.addKeymapLayer(function(layerSet)
                -- Re-enable C-n/p passthrough when no cursors active
                layerSet({ "n", "v" }, "<C-n>", function() mc.matchAddCursor(1)  end)
                layerSet({ "n", "v" }, "<C-p>", function() mc.matchAddCursor(-1) end)
            end)

            vim.api.nvim_set_hl(0, "MultiCursorCursor",  { link = "Cursor" })
            vim.api.nvim_set_hl(0, "MultiCursorVisual",  { link = "Visual" })
            vim.api.nvim_set_hl(0, "MultiCursorSign",    { link = "SignColumn" })
            vim.api.nvim_set_hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
            vim.api.nvim_set_hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
            vim.api.nvim_set_hl(0, "MultiCursorDisabledSign",   { link = "SignColumn" })
        end,
    },
}
