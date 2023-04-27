-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])
-- local packer_user_config_group = vim.api.nvim_create_augroup('packer_user_config', { clear = false })
-- vim.api.nvim_create_autocmd(
--   'BufWritePost',
--   {
--     group = packer_user_config_group,
--     pattern = 'plugins.lua',
--     command = 'source | PackerCompile'
--   }
-- )

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
    -- use {
    --     'ggandor/leap.nvim',
    --     config = function()
    --         require('leap').add_default_mappings()
    --     end
    -- }
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            {'nvim-lua/plenary.nvim'},
            {'BurntSushi/ripgrep'},
            {'jvgrootveld/telescope-zoxide'},
            {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},
        },
        config = function()
            local z_utils = require("telescope._extensions.zoxide.utils")
            require('telescope').setup{
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
            require("telescope").load_extension('zoxide')
            require('telescope').load_extension('fzf')

            -- require('telescope._extensions.zoxide.config').setup({
            --     mappings = {
            --         default = {
            --             action = function(selection)
            --                 vim.cmd("tcd " .. selection.path)
            --             end,
            --         },
            --     }
            -- })

            vim.keymap.set('n', '<Leader>cd', require("telescope").extensions.zoxide.list, { noremap = true, silent = false })

            vim.keymap.set('n', '<C-P>', require('telescope.builtin').git_files, { noremap = true, silent = true })
            vim.keymap.set('n', '<C-B>', require('telescope.builtin').buffers, { noremap = true, silent = true })
            vim.keymap.set('n', '<Leader>h', require('telescope.builtin').command_history, { noremap = true, silent = true })
            vim.keymap.set('n', '<Leader>d', require('telescope.builtin').lsp_definitions, { noremap = true, silent = true })
        end
    }

    use {
        'ahmedkhalf/project.nvim',
        requires = {
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
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
                scope_chdir = 'tab',
            }
            require('telescope').load_extension('projects')
            vim.keymap.set('n', '<Leader>p', require("telescope").extensions.projects.projects, { noremap = true, silent = false })
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
            vim.cmd.colorscheme('gruvbox')
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
            if false then
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
        -- version = 'v0.1.3',
        requires = 'nvim-lua/lsp-status.nvim',
        config = function()
            lspconfig = require "lspconfig"
            util = require "lspconfig/util"

            lspconfig.gopls.setup {
                cmd = {"gopls", "serve"},
                filetypes = {"go", "gomod"},
                root_dir = util.root_pattern("go.work", "go.mod", ".git"),
                settings = {
                    gopls = {
                        analyses = {
                            unusedparams = true,
                        },
                        staticcheck = true,
                    },
                },
            }

            local au_go_lsp_group = vim.api.nvim_create_augroup('GO_LSP', {
                clear = false
            })
            vim.api.nvim_create_autocmd('BufWritePre', {
                pattern = '*.go',
                group = au_go_lsp_group,
                callback = function()
                    vim.lsp.buf.format({ async = false })
                    -- vim.lsp.buf.code_action({
                    --     context = { only = { 'source.organizeImports' } },
                    --     apply = true,
                    -- })
                end,
            })
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

end)
