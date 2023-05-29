-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use 'nvim-treesitter/nvim-treesitter'
    use 'nanotee/zoxide.vim'
    use {
        'takac/vim-hardtime',
        config = function()
            -- vim.g.hardtime_default_on = 1
        end
    }
    use {
        'ggandor/leap.nvim',
        config = function()
            require('leap').add_default_mappings()
        end
    }
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            {'nvim-lua/plenary.nvim'},
            {'BurntSushi/ripgrep'},
            -- {'jvgrootveld/telescope-zoxide'},
            {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
        },
        config = function()
            require('telescope').setup()
            require('telescope').load_extension('fzf')

            -- require('telescope').load_extension('zoxide')
            -- require('telescope._extensions.zoxide.config').setup({
            --     mappings = {
            --         default = {
            --             action = function(selection)
            --                 vim.cmd("tcd " .. selection.path)
            --             end,
            --         },
            --     }
            -- })

            -- vim.keymap.set('n', '<Leader>cd', function() require'telescope'.extensions.zoxide.list() end, { noremap = true, silent = true })

            vim.keymap.set('n', '<C-P>', function() require('telescope.builtin').git_files() end, { noremap = true, silent = true })
            vim.keymap.set('n', '<C-B>', function() require('telescope.builtin').buffers() end, { noremap = true, silent = true })
            vim.keymap.set('n', '<Leader>h', function() require('telescope.builtin').command_history() end, { noremap = true, silent = true })
            vim.keymap.set('n', '<Leader>d', function() require('telescope.builtin').lsp_definitions() end, { noremap = true, silent = true })
        end
    }

    use 'wsdjeg/vim-fetch'
    use 'tpope/vim-abolish' -- cases modifications
    -- use 'lukas-reineke/indent-blankline.nvim'

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    use {
        'ellisonleao/gruvbox.nvim',
        config = function()
            vim.cmd[[colorscheme gruvbox]]
        end
    }

    use {
        'folke/trouble.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            require('trouble').setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }

    use {
		'nvim-lualine/lualine.nvim',
		requires = {'kyazdani42/nvim-web-devicons', opt = true},
		config = function()
			local section_separators, component_separators
			if true then
				section_separators = {left = '', right = ''}
				component_separators = {left = '', right = ''}
			else
				section_separators = {left = '', right = ''}
				component_separators = {left = '', right = ''}
			end
            require('lualine').setup {
                options = {
                    theme = 'gruvbox',
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
    }

    use {
        'neovim/nvim-lspconfig',
        version = 'v0.1.3',
        requires = 'nvim-lua/lsp-status.nvim',
        config = function()
            local nvim_lsp = require('lspconfig')
			local lsp_status = require('lsp-status')

			-- vim.lsp.handlers['textDocument/publishDiagnostics'] = local function location_handler(_, result, ctx, _)


            -- Use an on_attach function to only map the following keys
            -- after the language server attaches to the current buffer
            local on_attach = function(client, bufnr)
				lsp_status.on_attach(client, bufnr)

                --Enable completion triggered by <c-x><c-o>
				vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

                -- Mappings.
                local opts = { noremap=true, silent=true, buffer = bufnr }

				local function inPrevWindowHandler(err, result, ctx, config)
					vim.api.nvim_command('wincmd p')
					vim.lsp.handlers[ctx.method](err, result, ctx, config)
				end

                -- See `:help vim.lsp.*` for documentation on any of the below functions
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
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
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
                vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
                vim.keymap.set('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
                vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
                vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
                vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                vim.keymap.set('n', '<C-k>', vim.diagnostic.goto_prev, opts)
                vim.keymap.set('n', '<C-j>', vim.diagnostic.goto_next, opts)
                vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, opts)
                -- vim.keymap.set('n', '<space>e', vim.lsp.diagnostic.show_line_diagnostics, opts)
                -- vim.keymap.set('n', '<space>q', vim.lsp.diagnostic.set_loclist, opts)
                -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
            end

            -- Use a loop to conveniently call 'setup' on multiple servers and
            -- map buffer local keybindings when the language server attaches
            local servers = { 'gopls', 'tsserver' }
            for _, lsp in ipairs(servers) do
                nvim_lsp[lsp].setup {
                    on_attach = on_attach,
					capabilities = lsp_status.capabilities,
                    flags = {
                        debounce_text_changes = 150,
                    }
                }
            end

            -- following example solution from github issue:
            --   https://github.com/neovim/nvim-lspconfig/issues/115
            function goimports(wait_ms)
                local params = vim.lsp.util.make_range_params()
                params.context = {only = {'source.organizeImports'}}
                local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params, wait_ms)
                for _, res in pairs(result or {}) do
                    for _, r in pairs(res.result or {}) do
                        if r.edit then
                            -- note: text encoding param is required
                            vim.lsp.util.apply_workspace_edit(r.edit, 'utf-16')
                        else
                            vim.lsp.buf.execute_command(r.command)
                        end
                    end
                end
            end

            vim.cmd [[
                augroup GO_LSP
                autocmd!
                autocmd BufWritePre *.go :silent! lua vim.lsp.buf.formatting()
                augroup END
            ]]
        end
    }

    use {
        'hrsh7th/nvim-cmp',
        requires = {
            -- { 'neovim/nvim-lspconfig' },
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
    }

	use {
		'phaazon/hop.nvim',
		branch = 'v1', -- optional but strongly recommended
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
		end
	}

    -- -- Simple plugins can be specified as strings
    -- use '9mm/vim-closer'

    -- -- Lazy loading:
    -- -- Load on specific commands
    -- use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}

    -- -- Load on an autocommand event
    -- use {'andymass/vim-matchup', event = 'VimEnter'}

    -- -- Load on a combination of conditions: specific filetypes or commands
    -- -- Also run code after load (see the 'config' key)
    -- use {
    --   'w0rp/ale',
    --   ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex'},
    --   cmd = 'ALEEnable',
    --   config = 'vim.cmd[[ALEEnable]]'
    -- }

    -- -- Plugins can have dependencies on other plugins
    -- use {
    --   'haorenW1025/completion-nvim',
    --   opt = true,
    --   requires = {{'hrsh7th/vim-vsnip', opt = true}, {'hrsh7th/vim-vsnip-integ', opt = true}}
    -- }

    -- -- Plugins can also depend on rocks from luarocks.org:
    -- use {
    --   'my/supercoolplugin',
    --   rocks = {'lpeg', {'lua-cjson', version = '2.1.0'}}
    -- }

    -- -- You can specify rocks in isolation
    -- use_rocks 'penlight'
    -- use_rocks {'lua-resty-http', 'lpeg'}

    -- -- Local plugins can be included
    -- use '~/projects/personal/hover.nvim'

    -- -- Plugins can have post-install/update hooks
    -- use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}

    -- -- Post-install/update hook with neovim command
    -- use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    -- -- Post-install/update hook with call of vimscript function with argument
    -- use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }

    -- -- Use specific branch, dependency and run lua file after load
    -- use {
    --   'glepnir/galaxyline.nvim', branch = 'main', config = function() require'statusline' end,
    --   requires = {'kyazdani42/nvim-web-devicons'}
    -- }

    -- -- Use dependency and run lua function after load
    -- use {
    --   'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
    --   config = function() require('gitsigns').setup() end
    -- }

    -- -- You can specify multiple plugins in a single call
    -- use {'tjdevries/colorbuddy.vim', {'nvim-treesitter/nvim-treesitter', opt = true}}

    -- -- You can alias plugin names
    -- use {'dracula/vim', as = 'dracula'}
end)
