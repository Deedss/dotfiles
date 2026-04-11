return {
    "mfussenegger/nvim-lint",
    event = {
        "BufWritePost", "BufReadPost", "InsertLeave"
    },
    config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
            c = { "clangtidy" },
            cpp = { "clangtidy" },
            cmake = { "cmakelint" },
            python = { "ruff" },
        }
    end,
}
