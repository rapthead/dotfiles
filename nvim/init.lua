vim.g.mapleader = " "

-- for programming {
vim.opt.number = true
vim.opt.wrap = false
vim.opt.signcolumn = 'number'
-- for programming }

vim.opt.ignorecase = true -- игнорим кейс при поиске
vim.opt.smartcase = true -- не игнорим кейс если в строке поиска есть апперкейс

-- indent
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.smarttab = true -- установка вставки пробелов в начало строки вместо символа 'tabstop'
vim.opt.shiftwidth = 4 -- установка размера таб-отступа
vim.opt.shiftround = true
vim.opt.autoindent = true -- автоматическая табуляция. если текущая строка начинается с TAB, то и следующая тоже

vim.opt.list = true
vim.opt.listchars = {
    tab = "> ",
    trail = "X",
    extends = ">",
    precedes = "<",
    nbsp = "+"
}

-- vim.opt.dir = os.getenv( "HOME" ) .. "/.cache/nvim/swaps"
-- vim.opt.undodir =  os.getenv( "HOME" ) .. "/.cache/nvim/undos"
vim.opt.laststatus = 3

-- default for neovim >= 0.8
-- https://gpanders.com/blog/whats-new-in-neovim-0-7#:~:text=Use%20only%20filetype.lua%20and%20do%20not%20load%20filetype.vim%20at%20all
-- vim.g.do_filetype_lua = 1
-- vim.g.did_load_filetypes = 0

vim.g.netrw_browse_split = 4
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 75
vim.g.netrw_altv = 1
vim.g.netrw_preview =1

require('plugins')
require('disable-mouse')
require('keymap')
