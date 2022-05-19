vim.o.tabstop = 4
vim.o.list = true
vim.o.listchars = {
    tab = "> ",
    trail = "-",
    extends = ">",
    precedes "<",
    nbsp = "+",
}

lua require('plugins')
lua require('disable-mouse')
