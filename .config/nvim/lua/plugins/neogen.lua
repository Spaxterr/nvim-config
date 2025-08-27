return {
    {
        "danymat/neogen",
        config = true,
        event = "LspAttach",
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
