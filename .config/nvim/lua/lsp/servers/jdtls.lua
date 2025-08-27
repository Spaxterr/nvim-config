return {
    settings = {
        java = {
            configuration = {
                updateBuildConfiguration = "automatic",
            },
            import = {
                gradle = {
                    enabled = true,
                },
                maven = {
                    enabled = true,
                },
            },
            format = {
                enabled = true,
            },
            completion = {
                enabled = true,
                favoriteStaticMembers = {},
            },
            signatureHelp = {
                enabled = true,
            },
            autobuild = {
                enabled = false,
            },
            progressReport = {
                enabled = true,
            },
            trace = {
                server = "off",
                client = "off",
            },
            project = {
                referencedLibraries = {
                    "lib/**/*.jar",
                },
            },
        },
    },
}
