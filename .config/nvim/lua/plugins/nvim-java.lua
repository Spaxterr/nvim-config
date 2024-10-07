return {
    "nvim-java/nvim-java",
    settings = {
        java = {
            configuration = {
                runtimes = {
                    {
                        name = "Java-11",
                        path = "/usr/bin/java",
                        default = true,
                    }
                }
            }
        }
    }
}
