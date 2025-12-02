-- enable syntax highlighting
vim.cmd("syntax on")

-- basic settings
vim.opt.errorbells = false

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.ignorecase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.number = true           -- same as :set nu
vim.opt.relativenumber = true   -- same as :set relativenumber

vim.opt.autoread = true

-- vim-plug setup
vim.cmd [[
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
]]

-- Map <leader> to SPACE
vim.keymap.set("n", "<SPACE>", "<Nop>")
vim.g.mapleader = " "

--------------
-- NerdTREE --
--------------

-- Open NerdTREE with Ctrl+N
-- nnoremap <C-n> :NERDTree<CR>

-- Toggle NerdTREE and active window with Ctrl+T (overrides tagging)
vim.keymap.set("n", "<C-t>", ":NERDTreeToggle<CR>", { silent = true })

-- Auto-close Neovim if NERDTree is the only remaining window
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        if vim.fn.tabpagenr("$") == 1
            and vim.fn.winnr("$") == 1
            and vim.b.NERDTree
            and vim.b.NERDTree.isTabTree then

            vim.api.nvim_feedkeys(":quit\n:\b", "n", false)
        end
    end
})


-------------------
-- FZF/Telescope --
-------------------

local builtin = require("telescope.builtin")

-- find files (custom)
vim.keymap.set("n", "<C-n>", function()
    builtin.find_files({
        no_ignore = true,
        prompt_title = "Find Files (including .gitignore)"
    })
end, { silent = true })
vim.keymap.set("n", "<leader>n", "<cmd>Telescope find_files<cr>", { silent = true })
vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<cr>", { silent = true })

-- Requires ripgrep: `sudo apt install ripgrep`
vim.keymap.set("n", "<leader>f", "<cmd>Telescope live_grep<cr>", { silent = true })

-- Strict search (no 'smart' character skips with -F flag)
vim.keymap.set("n", "<leader>F", function()
    builtin.live_grep({
        additional_args = function()
            return { "-F" }
        end,
        prompt_title = "Live Grep (strict)"
    })
end, { silent = true })

vim.keymap.set("n", "<leader>e", "<cmd>Telescope oldfiles<cr>", { silent = true })

require('telescope').setup({
    defaults = {
        path_display = { "truncate" }, -- keep filenames readable
    }
})

----------
-- Misc --
----------

-- \p pastes copied text into _ (without overriding paste buffer)
vim.keymap.set("x", "<leader>p", [["_dP]])

-- select entire file
vim.keymap.set("n", "<leader>a", "ggVG")

-- keep cursor centered
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-f>", "<C-f>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")

-- Visual copy to system clipboard
vim.keymap.set("v", "<leader>c", [["+y]])
-- Normal mode paste
vim.keymap.set("n", "<leader>p", [["+p]])
-- Visual mode paste
vim.keymap.set("v", "<leader>p", [["+p]])

-- keep search result centered
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

vim.cmd("colorscheme tokyonight")
