vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'nvim-treesitter' and kind == 'update' then
      if not ev.data.active then vim.cmd.packadd 'nvim-treesitter' end
      vim.cmd 'TSUpdate'
    end
  end,
})

vim.pack.add {
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
}

require('nvim-treesitter').install 'all'

local installed = require('nvim-treesitter').get_installed()

vim.api.nvim_create_autocmd('FileType', {
  pattern = installed,

  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    local lang = vim.treesitter.language.get_lang(ft)
    if lang == nil then return end

    if vim.treesitter.language.add(lang) then
      -- start treesitter highlighting
      vim.treesitter.start(args.buf, lang)
      -- the following two statements will enable treesitter folding
      -- vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      -- vim.wo[0][0].foldmethod = 'expr'
      -- enable treesitter-based indentation
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
