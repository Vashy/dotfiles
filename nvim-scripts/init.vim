" File location for nvim: ~/.config/nvim/init.vim

syntax on

set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab       " replaces tabs with spaces
set autoindent      " ENTER to put the cursor at the same level at the previous line
set smartindent     " as above, but respects current programming language
set ignorecase      " ignore case in searches
set hlsearch        " highlights searches
set incsearch       " incremental search
set nu              " show line numbers
set relativenumber  " show relative line numbers
set autoread        " autoreloads non written files 
set list            " visible whitespaces/tabs

call plug#begin('~/.local/share/nvim/site/plugged')

Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'shaunsingh/solarized.nvim'
Plug 'folke/tokyonight.nvim'
Plug 'vim-airline/vim-airline'
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'junegunn/goyo.vim'

call plug#end()

" Map <leader> to <SPACE>
nnoremap <SPACE> <Nop>
let mapleader = " "

""""""""""""
" NerdTREE "
""""""""""""

" Open NerdTREE with Ctrl+N
" nnoremap <C-n> :NERDTree<CR>

" Toggle NerdTREE and active window with Ctrl+T (overrides tagging)
nnoremap <C-t> :NERDTreeToggle<CR>

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif

"""""""
" FZF/Telescope "
"""""""

" filename_first doesn't work - needs to switch to lua maybe or switch to
" master branch https://github.com/nvim-telescope/telescope.nvim/issues/2014
nnoremap <C-n> <cmd>lua require('telescope.builtin').find_files({ no_ignore=true, prompt_title="Find Files (including .gitignore)" })<CR>
nnoremap <leader>n <cmd>Telescope find_files<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>

" Requires ripgrep: `sudo apt install ripgrep`
nnoremap <leader>f <cmd>Telescope live_grep<cr>

" Strict search (no 'smart' character skips with -F flag)
nnoremap <leader>F <cmd>lua require('telescope.builtin').live_grep({ additional_args = function() return { "-F" } end, prompt_title="Live Grep (strict)"})<cr>

nnoremap <leader>e <cmd>Telescope oldfiles<cr>

""""""""
" Misc "
""""""""

" \p pastes copied text into _ (without overriding paste buffer)
" xnoremap <leader>p "_dP

nnoremap <leader>a ggVG

" Adds zz movement to page up/down movements
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap <C-f> <C-f>zz
nnoremap <C-b> <C-b>zz

" Copy and paste
vnoremap <leader>c "+y
nnoremap <leader>c "+yy
vnoremap <leader>y "+y
nnoremap <leader>p "+p
vnoremap <leader>p "+p

nnoremap n nzz
nnoremap N Nzz

colorscheme tokyonight

" breaks linter so it's at the bottom

lua << EOF
require('telescope').setup({
  defaults = {
    path_display = { "truncate" } -- Ensures file names stay visible
  }
})
EOF
