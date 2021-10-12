" This will be the default setup for using VIM keybindings in other IDE's when
" NeoVim can't be used.

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
" Avoid side effects when it was already reset.
if &compatible
  set nocompatible
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Common settings -------------------------
set backspace=indent,eol,start
set ruler
set relativenumber
set title
set textwidth=0
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab autoindent
set ignorecase 
set incsearch
set magic
set showmatch mat=2
set visualbell
set hlsearch
set lazyredraw
set showcmd

set cmdheight=2

set updatetime=300

" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable 
" Enable 256 colors palette in Gnome Terminal
set termguicolors
" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Mappings   
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Map leader to , ---------------------
"let mapleader="\<space>"

"" Quick quit and write
"nnoremap <leader>q :q!<cr>
"nnoremap <leader>z :wq<cr>
"nnoremap <leader>w :w<cr>
"nnoremap <silent> <esc> :noh<cr><esc>

"" Easy select all of file
"nnoremap <leader>sa :ggVG$

"" Make Y yank to end of the line
nnoremap Y y$

"" Make visual yanks place the cursor back where started
"vnoremap y ygv<Esc>

"" switch buffers in Normal mode
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
""leader key twice to cycle between last two open buffers
"nnoremap <leader><leader> <c-^>

"" Remap VIM 0 to first non-blank character
"map 0 ^

"" Move a line of text using ALT+[jk] or Command+[jk] on mac
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"" Moving around the windows
"nnoremap <silent> <C-h> <C-W>h
"nnoremap <silent> <C-j> <C-W>j
"nnoremap <silent> <C-k> <C-W>k
"nnoremap <silent> <C-l> <C-W>l

"" Useful mappings for managing tabs
"nnoremap <leader>te  :tabedit<Space>
"nnoremap <leader>tm  :tabm<Space>
"nnoremap <leader>td  :tabclose<CR>
"nnoremap <leader>tl  :tabnext<CR>
"nnoremap <leader>th  :tabprev<CR>
"nnoremap <leader>tn  :tabnew<space>

"" For long, wrapped lines
nnoremap k gk
nnoremap j gj

"" Easier indenting control in visual mode
vnoremap <silent> > >gv
vnoremap <silent> < <gv

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c
