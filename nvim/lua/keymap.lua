vim.opt.keymap = 'russian-jcukenwin'
vim.opt.iminsert = 0
vim.opt.imsearch = -1

-- local function changeKeymap()
--     if vim.o.iminsert == 0 then
--         vim.opt_local.iminsert = 1
--     else
--         vim.opt_local.iminsert = 0
--     end
-- end
-- vim.keymap.set({'n', 'v', 'i'}, '<F7>', '<C-^>')
-- vim.keymap.set('i', '<ESC>', '<ESC>:set iminsert=0<CR>', { noremap = true, silent = true })
vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = "*",
    callback = function(args)
        vim.opt_local.iminsert = 0
    end,
})
