return { -- LSP Configuration & Plugins
    -- "neovim/nvim-lspconfig",
    -- dependencies = {
    --     -- Useful status updates for LSP.
    --     -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    --     { "j-hui/fidget.nvim", opts = {} },
    -- },
    -- config = function()
    --     vim.api.nvim_create_autocmd("LspAttach", {
    --         group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
    --         callback = function(event)
    --             local map = function(mode, keys, func, desc)
    --                 vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    --             end

    --             --  This is where a variable was first declared, or where a function is defined, etc.
    --             --  To jump back, press <C-T>.
    --             map("n", "gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

    --             -- Find references for the word under your cursor.
    --             map("n", "gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

    --             -- Jump to the implementation of the word under your cursor.
    --             --  Useful when your language has ways of declaring types without an actual implementation.
    --             map("n", "gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

    --             -- Jump to the type of the word under your cursor.
    --             --  Useful when you're not sure what type a variable is and you want to see
    --             --  the definition of its *type*, not where it was *defined*.
    --             map("n", "gy", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

    --             -- Fuzzy find all the symbols in your current document.
    --             --  Symbols are things like variables, functions, types, etc.
    --             map("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

    --             -- Fuzzy find all the symbols in your current workspace
    --             --  Similar to document symbols, except searches over your whole project.
    --             map("n", "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols,
    --                 "[W]orkspace [S]ymbols")

    --             -- Rename the variable under your cursor
    --             --  Most Language Servers support renaming across files, etc.
    --             map("n", "cd", vim.lsp.buf.rename, "[C]hange [D]efinition")

    --             -- Execute a code action, usually your cursor needs to be on top of an error
    --             -- or a suggestion from your LSP for this to activate.
    --             map({ "n", "v" }, "g.", vim.lsp.buf.code_action, "[C]ode [A]ction")

    --             -- Run codelens
    --             map({ "n", "v" }, "gl", vim.lsp.codelens.run, "[C]ode [L]ens")

    --             -- Opens a popup that        -- Show the signature of the function you're currently completing.
    --             map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

    --             -- WARN: This is not Goto Definition, this is Goto Declaration.
    --             --  For example, in C this would take you to the header
    --             map("n", "gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

    --             map("n", "<leader>fd", function()
    --                 vim.lsp.buf.format({ async = true })
    --             end, "[F]ormat")

    --             -- The following two autocommands are used to highlight references of the
    --             -- word under your cursor when your cursor rests there for a little while.
    --             --    See `:help CursorHold` for information about when this is executed
    --             --
    --             -- When you move your cursor, the highlights will be cleared (the second autocommand).
    --             local client = vim.lsp.get_client_by_id(event.buf)
    --             if client and client.server_capabilities.documentHighlightProvider then
    --                 vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    --                     buffer = event.buf,
    --                     callback = vim.lsp.buf.document_highlight,
    --                 })

    --                 vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
    --                     buffer = event.buf,
    --                     callback = vim.lsp.buf.clear_references,
    --                 })
    --             end
    --         end,
    --     })

    --     -- LSP servers and clients are able to communicate to each other what features they support.
    --     --  By default, Neovim doesn't support everything that is in the LSP Specification.
    --     --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
    --     --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
    --     local capabilities = vim.lsp.protocol.make_client_capabilities()
    --     capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

    --     local servers = {
    --         clangd = {},
    --         cmake = {},
    --         pylsp = {},
    --         rust_analyzer = {},
    --         lua_ls = {
    --             settings = {
    --                 Lua = {
    --                     runtime = { version = "LuaJIT" },
    --                     workspace = {
    --                         checkThirdParty = false,
    --                         -- Tells lua_ls where to find all the Lua files that you have loaded
    --                         -- for your neovim configuration.
    --                         library = { vim.env.VIMRUNTIME },
    --                     },
    --                     defaultConfig = {
    --                         indent_style = "space",
    --                         indent_size = "2",
    --                     }
    --                 },
    --             },
    --         },
    --     }

    --     -- Ensure the servers and tools above are installed
    --     for server_name, server in pairs(servers) do
    --         require("lspconfig")[server_name].setup({
    --             cmd = server.cmd,
    --             settings = server.settings,
    --             filetypes = server.filetypes,
    --             -- This handles overriding only values explicitly passed
    --             -- by the server configuration above. Useful when disabling
    --             -- certain features of an LSP (for example, turning off formatting for tsserver)
    --             capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {}),
    --         })
    --     end
    -- end,
}