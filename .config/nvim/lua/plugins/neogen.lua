return {
    {
        "danymat/neogen",
        config = true,
        event = "VeryLazy",
        opts = {
            enabled = true,
            input_after_comment = true,
            languages = {
                javascript = {
                    template = {
                        annotation_convention = "jsdoc"
                    }
                }
            }
        },
    }
}
