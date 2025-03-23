local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- {
	-- 	"ray-x/go.nvim",
	-- 	dependencies = {  -- optional packages
	-- 		"ray-x/guihua.lua",
	-- 		"neovim/nvim-lspconfig",
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 	},
	-- 	config = function()
	-- 		require("go").setup()
	-- 	end,
	-- 	event = {"CmdlineEnter"},
	-- 	ft = {"go", 'gomod'},
	-- 	build = function() require("go.install").update_all_sync() end
	-- },

	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function() vim.fn["mkdp#util#install"]() end,
	},
	{
		'nvim-treesitter/nvim-treesitter',
		config = function()
			require'nvim-treesitter.configs'.setup {
				-- A list of parser names, or "all" (the five listed parsers should always be installed)
				ensure_installed = {
					"arduino",
					"bash",
					"c",
					"css",
					"csv",
					"dockerfile",
					"go",
					"html",
					"jq",
					"lua",
					"make",
					"markdown",
					"proto",
					"query",
					"regex",
					"sql",
					-- "textproto",
					"typescript",
					"vim",
					"vimdoc",
					"yaml",
				},


				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,

				-- Automatically install missing parsers when entering buffer
				-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
				auto_install = false,

				-- List of parsers to ignore installing (or "all")
				-- ignore_install = { "javascript" },

				---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
				-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

				highlight = {
					enable = true,

					-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
					-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
					-- the name of the parser)
					-- list of language that will be disabled
					-- disable = { "c", "rust" },

					-- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
					disable = function(lang, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,

					-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
					-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
					-- Using this option may slow down your editor, and you may see some duplicate highlights.
					-- Instead of true it can also be a list of languages
					additional_vim_regex_highlighting = false,
				},

				indent = {
					enable = true
				},
			}
		end
	},
	'nanotee/zoxide.vim',
	{
		'takac/vim-hardtime',
		enabled = false,
	},
	{
		'nmac427/guess-indent.nvim',
		config = function() require('guess-indent').setup {} end,
	},
	{
		'nvim-telescope/telescope.nvim',
		dependencies = {
			{'nvim-lua/plenary.nvim'},
			{'BurntSushi/ripgrep'},
			{'jvgrootveld/telescope-zoxide'},
			{'nvim-telescope/telescope-fzf-native.nvim', build = 'make'},
		},
		config = function()
			local z_utils = require("telescope._extensions.zoxide.utils")
			local m = require('telescope')
			local mb = require('telescope.builtin')
			m.setup{
				extensions = {
					zoxide = {
						prompt_title = "[ set the directory for the current tab ]",
						mappings = {
							default = {
								after_action = function(selection)
									vim.cmd.tcd(selection.path)
								end
							},
							-- ["<C-s>"] = {
							--     before_action = function(selection) print("before C-s") end,
							--     action = function(selection)
							--         vim.cmd.edit(selection.path)
							--     end
							-- },
							-- ["<C-q>"] = { action = z_utils.create_basic_command("split") },
						},
					}
				}
			}
			m.load_extension('zoxide')
			m.load_extension('fzf')

			-- require('telescope._extensions.zoxide.config').setup({
			--     mappings = {
			--         default = {
			--             action = function(selection)
			--                 vim.cmd("tcd " .. selection.path)
			--             end,
			--         },
			--     }
			-- })

			vim.keymap.set('n', '<Leader>cd', m.extensions.zoxide.list, { noremap = true, silent = false })
			vim.keymap.set('n', '<C-P>',     mb.find_files, { noremap = true, silent = true })
			vim.keymap.set('n', '<C-B>',     mb.buffers, { noremap = true, silent = true })
			vim.keymap.set('n', '<Leader>h', mb.command_history, { noremap = true, silent = true })
			vim.keymap.set('n', '<Leader>b', mb.diagnostics, { noremap = true, silent = true })
			vim.keymap.set('n', '<Leader>d', mb.lsp_definitions, { noremap = true, silent = true })
			vim.keymap.set('n', '<Leader>s', mb.lsp_dynamic_workspace_symbols, { noremap = true, silent = true })
		end
	},
	{
		'ahmedkhalf/project.nvim',
		dependencies = {
			{'nvim-telescope/telescope.nvim'},
			{'nvim-tree/nvim-tree.lua'},
		},
		config = function()
			require("nvim-tree").setup({
				sync_root_with_cwd = true,
				respect_buf_cwd = true,
				update_focused_file = {
					enable = true,
					update_root = true
				},
			})
			require("project_nvim").setup {
				scope_chdir = 'tab',
				silent_chdir = false,
			}
			require('telescope').load_extension('projects')
			vim.keymap.set('n', '<Leader>p', require("telescope").extensions.projects.projects, { noremap = true, silent = false })
		end
	},
	{
		'akinsho/toggleterm.nvim',
		version = "*",
		config = function()
			require("toggleterm").setup({
				-- open_mapping = [[<leader>t]],
			})
		end
	},
	'wsdjeg/vim-fetch', -- открытие файла на определенной строке и колонке ex: `:e file.txt:54:43`
	'tpope/vim-abolish', -- cases modifications
	{
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end
	},
	{
		'ahmedkhalf/project.nvim',
		dependencies = {
			{'nvim-telescope/telescope.nvim'},
			{'nvim-tree/nvim-tree.lua'},
		},
		config = function()
			require("nvim-tree").setup({
				sync_root_with_cwd = true,
				respect_buf_cwd = true,
				update_focused_file = {
					enable = true,
					update_root = true
				},
			})
			require("project_nvim").setup {
				scope_chdir = 'tab',
			}
			require('telescope').load_extension('projects')
			vim.keymap.set('n', '<Leader>p', require("telescope").extensions.projects.projects, { noremap = true, silent = false })
		end
	},
	{
		'folke/trouble.nvim',
		dependencies = {
			'kyazdani42/nvim-web-devicons',
		},
		config = function()
			require('trouble').setup({})
		end
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = {'kyazdani42/nvim-web-devicons', opt = true},
		config = function()
			local section_separators, component_separators
			if false then
				section_separators = {left = '', right = ''}
				component_separators = {left = '', right = ''}
			else
				section_separators = {left = '', right = ''}
				component_separators = {left = '', right = ''}
			end
			require('lualine').setup {
				options = {
					theme = 'gruvbox-material',
					section_separators = section_separators,
					component_separators = component_separators,
					globalstatus = true,
				},
				extensions = {'quickfix'},
				sections = {
					lualine_c = {
						{'filename', path = 1},
						-- {lsp_status.status},
						-- {'require'lsp-status'.status()'},
					},
				},
			}
		end
	},
	{
		'neovim/nvim-lspconfig',
		-- version = 'v0.1.3',
		dependencies = 'nvim-lua/lsp-status.nvim',
		config = function()
			lspconfig = require("lspconfig")
			util = require("lspconfig/util")

			vim.keymap.set('n', '<C-P>', require('telescope.builtin').git_files, { noremap = true, silent = true })
			vim.keymap.set('n', '<C-B>', require('telescope.builtin').buffers, { noremap = true, silent = true })
			vim.keymap.set('n', '<Leader>h', require('telescope.builtin').command_history, { noremap = true, silent = true })
			vim.keymap.set('n', '<Leader>d', require('telescope.builtin').lsp_definitions, { noremap = true, silent = true })

			lspconfig.gopls.setup({
				cmd = {"gopls", "serve"},
				filetypes = {"go", "gomod"},
				root_dir = util.root_pattern("go.work", "go.mod", ".git"),
				settings = {
					gopls = {
						buildFlags =  {"-tags=integration,e2e,local"},
						analyses = {
							unusedparams = true,
						},
						staticcheck = true,
						gofumpt = true,
						["ui.verboseOutput"] = true,
					},
				},
			})

			local au_go_lsp_group = vim.api.nvim_create_augroup('GO_LSP', {
				clear = false
			})
			vim.api.nvim_create_autocmd('BufWritePre', {
				pattern = '*.go',
				group = au_go_lsp_group,
				callback = function()
					local params = vim.lsp.util.make_range_params()
					params.context = {only = {"source.organizeImports"}}
					-- buf_request_sync defaults to a 1000ms timeout. Depending on your
					-- machine and codebase, you may want longer. Add an additional
					-- argument after params if you find that you have to write the file
					-- twice for changes to be saved.
					-- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
					local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
					for cid, res in pairs(result or {}) do
						for _, r in pairs(res.result or {}) do
							if r.edit then
								local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
								vim.lsp.util.apply_workspace_edit(r.edit, enc)
							end
						end
					end
					vim.lsp.buf.format({ async = false })
					-- vim.lsp.buf.code_action({
					--     context = { only = { 'source.organizeImports' } },
					--     apply = true,
					-- })
				end,
			})

			vim.lsp.handlers["textDocument/diagnostic"] = vim.lsp.with(
				vim.lsp.diagnostic.on_diagnostic, {
					update_in_insert = true,
				}
			)
		end
	},

	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'hrsh7th/cmp-buffer' },
			{ 'hrsh7th/cmp-path' },
			{ 'hrsh7th/cmp-cmdline' },
			{ 'hrsh7th/nvim-cmp' },

			{ 'hrsh7th/cmp-vsnip' },
			{ 'hrsh7th/vim-vsnip' }
		},
		config = function()
			local cmp = require'cmp'

			cmp.setup({
				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						vim.fn['vsnip#anonymous'](args.body) -- For `vsnip` users.
						-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
						-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
						-- vim.fn['UltiSnips#Anon'](args.body) -- For `ultisnips` users.
					end,
				},
				window = {
					-- completion = cmp.config.window.bordered(),
					-- documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					{ name = 'vsnip' }, -- For vsnip users.
					-- { name = 'luasnip' }, -- For luasnip users.
					-- { name = 'ultisnips' }, -- For ultisnips users.
					-- { name = 'snippy' }, -- For snippy users.
				}, {
						{ name = 'buffer' },
					})
			})

			-- Set configuration for specific filetype.
			cmp.setup.filetype('gitcommit', {
				sources = cmp.config.sources({
					{ name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
				}, {
						{ name = 'buffer' },
					})
			})

			-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline('/', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = 'buffer' }
				}
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(':', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = 'path' }
				}, {
						{ name = 'cmdline' }
					})
			})

		end,
	},
	{
		'sainnhe/gruvbox-material',
		config = function()
			vim.g.gruvbox_material_background = 'soft'
			vim.g.gruvbox_material_better_performance = 1
			vim.cmd.colorscheme('gruvbox-material')
		end
	},
})
