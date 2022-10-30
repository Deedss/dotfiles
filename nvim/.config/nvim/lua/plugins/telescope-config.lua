require('telescope').setup{}
require('telescope').load_extension('fzf')

local map_tele = function(key, action)
    local mode = "n"
    local rhs = string.format("<cmd>lua require('telescope.builtin').%s()<CR>", action)

    local map_options = {
        noremap = true,
        silent = true,
    }

    vim.api.nvim_set_keymap(mode, key, rhs, map_options)
end

-- Nvim
map_tele("<space>fb", "buffers")
map_tele("<space>fi", "find_files")
map_tele("<space>fg", "live_grep")
map_tele("<space>fh", "help_tags")
map_tele("<space>ff", "current_buffer_fuzzy_find")
map_tele("<space>gp", "grep_prompt")

-- Git
map_tele("<space>gs", "git_status")
map_tele("<space>gc", "git_commits")