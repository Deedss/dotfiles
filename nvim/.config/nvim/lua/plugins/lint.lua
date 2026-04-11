return {
    "mfussenegger/nvim-lint",
    event = {
        "BufWritePost", "BufReadPost", "InsertLeave"
    },
    config = function()
        require("lint").linters_by_ft = {
            c = { "clangtidy" },
            cpp = { "clangtidy" },
            cmake = { "cmakelint" },
            python = { "ruff" },
        }
    end,
}
