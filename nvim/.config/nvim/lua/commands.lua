local cmd = vim.cmd     		-- execute Vim commands
local exec = vim.api.nvim_exec 

cmd [[filetype plugin on]]

cmd [[set iskeyword+=-]]        -- treat dash separated words as a word text object"
cmd [[set shortmess+=c]]        -- Don't pass messages to |ins-completion-menu|.
cmd [[set inccommand=split]]    -- Make substitution work in realtime

cmd [[set whichwrap+=<,>,[,],h,l]]

-- remove whitespace on save
cmd [[au BufWritePre * :%s/\s\+$//e]]

-- highlight on yank
exec([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
  augroup end
]], false)