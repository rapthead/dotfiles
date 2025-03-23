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

local function lspAttach(args)
	-- Mappings.
	local opts = { noremap=true, silent=true, buffer = bufnr }

	local function inPrevWindowHandler(err, result, ctx, config)
		vim.api.nvim_command('wincmd p')
		vim.lsp.handlers[ctx.method](err, result, ctx, config)
	end

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	vim.keymap.set('n', 'grn', vim.lsp.buf.rename, opts)
	vim.keymap.set('n', 'grs', vim.lsp.buf.workspace_symbol, opts)
	vim.keymap.set('n', 'grh', vim.lsp.buf.typehierarchy, opts)
	vim.keymap.set('n', 'gra', vim.lsp.buf.code_action, opts)
	vim.keymap.set('n', 'grc', vim.diagnostic.setqflist, opts)
	vim.keymap.set('n', 'grI', vim.lsp.buf.incoming_calls, opts)
	vim.keymap.set('n', 'grO', vim.lsp.buf.outgoing_calls, opts)
	vim.keymap.set('n', 'grr', vim.lsp.buf.references, opts)
	vim.keymap.set('n', 'gri', vim.lsp.buf.implementation, opts)
	vim.keymap.set('n', 'gO', vim.lsp.buf.document_symbol, opts)
	vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, opts)

	vim.keymap.set('n', 'grD', vim.lsp.buf.declaration, opts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
	vim.keymap.set('n', 'gv', function()
		vim.lsp.buf_request(
			0,
			'textDocument/definition',
			vim.lsp.util.make_position_params(),
			inPrevWindowHandler
		)
	end, opts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
	vim.keymap.set('n', '<space>i', function()
		vim.lsp.buf.code_action({
			context = { only = { 'source.organizeImports' } },
			apply = true,
		})
	end, opts)
	vim.keymap.set('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, opts)
	vim.keymap.set('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
	vim.keymap.set('n', '<Leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
	vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
	vim.keymap.set('n', '<C-k>', vim.diagnostic.goto_prev, opts)
	vim.keymap.set('n', '<C-j>', vim.diagnostic.goto_next, opts)
end
vim.api.nvim_create_autocmd('LspAttach', {
	callback = lspAttach,
})
lspAttach()

vim.keymap.set('n', '<leader>t', function()
	vim.system({'bash', 'nterm', vim.fn.getcwd()})
end, { noremap=true, silent=true })
-- vim.keymap.set({'i', 'n'}, 'jk', '<esc>', {noremap = true})
-- vim.keymap.set({'i', 'n'}, '<esc>', '<nop>', {noremap = true})
