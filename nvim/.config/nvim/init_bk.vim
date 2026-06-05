" fix E303
set directory^=~/.cache/nvim/swap//
set showmode
set scrolloff=5
set incsearch
set relativenumber
set number
set clipboard+=unnamed

nnoremap L $
nnoremap H ^
vnoremap L $
vnoremap H ^


set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent

syntax on

au TextYankPost * silent! lua vim.highlight.on_yank()

if (has("autocmd") && !has("gui_running"))
    augroup colorset
       autocmd!
       let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
       autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " `bg` will not be styled since there is no `bg` setting
    augroup END
endif

colorscheme onedark


