-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/noname/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/noname/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/noname/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/noname/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/noname/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0" },
    loaded = true,
    path = "/home/noname/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/noname/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/home/noname/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/noname/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/noname/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-vsnip"] = {
    loaded = true,
    path = "/home/noname/.local/share/nvim/site/pack/packer/start/cmp-vsnip",
    url = "https://github.com/hrsh7th/cmp-vsnip"
  },
  ["gruvbox.nvim"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\24colorscheme gruvbox\bcmd\bvim\0" },
    loaded = true,
    path = "/home/noname/.local/share/nvim/site/pack/packer/start/gruvbox.nvim",
    url = "https://github.com/ellisonleao/gruvbox.nvim"
  },
  ["hop.nvim"] = {
    config = { "\27LJ\2\nU\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\tkeys\28etovxqpdygfblzhckisuran\nsetup\bhop\frequire\0" },
    loaded = true,
    path = "/home/noname/.local/share/nvim/site/pack/packer/start/hop.nvim",
    url = "https://github.com/phaazon/hop.nvim"
  },
  ["indent-blankline.nvim"] = {
    loaded = true,
    path = "/home/noname/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["lsp-status.nvim"] = {
    loaded = true,
    path = "/home/noname/.local/share/nvim/site/pack/packer/start/lsp-status.nvim",
    url = "https://github.com/nvim-lua/lsp-status.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n±\2\0\0\6\0\16\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\b\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\3=\3\t\0025\3\n\0=\3\v\0025\3\r\0004\4\3\0005\5\f\0>\5\1\4=\4\14\3=\3\15\2B\0\2\1K\0\1\0\rsections\14lualine_c\1\0\0\1\2\1\0\rfilename\tpath\3\1\15extensions\1\2\0\0\rquickfix\foptions\1\0\0\25component_separators\1\0\2\nright\bî‚·\tleft\bî‚µ\23section_separators\1\0\2\nright\bî‚¶\tleft\bî‚´\1\0\2\ntheme\fgruvbox\17globalstatus\2\nsetup\flualine\frequire\0" },
    loaded = true,
    path = "/home/noname/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\n;\0\1\4\0\4\0\0066\1\0\0009\1\1\0019\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\20vsnip#anonymous\afn\bvimê\5\1\0\n\0)\0g6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\6\0005\4\4\0003\5\3\0=\5\5\4=\4\a\0034\4\0\0=\4\b\0039\4\t\0009\4\n\0049\4\v\0045\6\r\0009\a\t\0009\a\f\a)\tüÿB\a\2\2=\a\14\0069\a\t\0009\a\f\a)\t\4\0B\a\2\2=\a\15\0069\a\t\0009\a\16\aB\a\1\2=\a\17\0069\a\t\0009\a\18\aB\a\1\2=\a\19\0069\a\t\0009\a\20\a5\t\21\0B\a\2\2=\a\22\6B\4\2\2=\4\t\0039\4\23\0009\4\24\0044\6\3\0005\a\25\0>\a\1\0065\a\26\0>\a\2\0064\a\3\0005\b\27\0>\b\1\aB\4\3\2=\4\24\3B\1\2\0019\1\2\0009\1\28\1'\3\29\0005\4 \0009\5\23\0009\5\24\0054\a\3\0005\b\30\0>\b\1\a4\b\3\0005\t\31\0>\t\1\bB\5\3\2=\5\24\4B\1\3\0019\1\2\0009\1!\1'\3\"\0005\4#\0009\5\t\0009\5\n\0059\5!\5B\5\1\2=\5\t\0044\5\3\0005\6$\0>\6\1\5=\5\24\4B\1\3\0019\1\2\0009\1!\1'\3%\0005\4&\0009\5\t\0009\5\n\0059\5!\5B\5\1\2=\5\t\0049\5\23\0009\5\24\0054\a\3\0005\b'\0>\b\1\a4\b\3\0005\t(\0>\t\1\bB\5\3\2=\5\24\4B\1\3\1K\0\1\0\1\0\1\tname\fcmdline\1\0\1\tname\tpath\1\0\0\6:\1\0\1\tname\vbuffer\1\0\0\6/\fcmdline\1\0\0\1\0\1\tname\vbuffer\1\0\1\tname\fcmp_git\14gitcommit\rfiletype\1\0\1\tname\vbuffer\1\0\1\tname\nvsnip\1\0\1\tname\rnvim_lsp\fsources\vconfig\t<CR>\1\0\1\vselect\2\fconfirm\n<C-e>\nabort\14<C-Space>\rcomplete\n<C-f>\n<C-b>\1\0\0\16scroll_docs\vinsert\vpreset\fmapping\vwindow\fsnippet\1\0\0\vexpand\1\0\0\0\nsetup\bcmp\frequire\0" },
    loaded = true,
    path = "/home/noname/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\ny\0\4\n\0\a\0\0166\4\0\0009\4\1\0049\4\2\4'\6\3\0B\4\2\0016\4\0\0009\4\4\0049\4\5\0049\5\6\0028\4\5\4\18\6\0\0\18\a\1\0\18\b\2\0\18\t\3\0B\4\5\1K\0\1\0\vmethod\rhandlers\blsp\rwincmd p\17nvim_command\bapi\bvimƒ\1\0\0\6\1\6\0\r6\0\0\0009\0\1\0009\0\2\0)\2\0\0'\3\3\0006\4\0\0009\4\1\0049\4\4\0049\4\5\4B\4\1\2-\5\0\0B\0\5\1K\0\1\0\3À\25make_position_params\tutil\28textDocument/definition\16buf_request\blsp\bvimd\0\0\6\0\6\0\v6\0\0\0006\2\1\0009\2\2\0026\4\1\0009\4\3\0049\4\4\0049\4\5\4B\4\1\0A\2\0\0A\0\0\1K\0\1\0\27list_workspace_folders\bbuf\blsp\finspect\bvim\nprintÙ\t\1\2\n\0011\0Ä\1-\2\0\0009\2\0\2\18\4\0\0\18\5\1\0B\2\3\0016\2\1\0009\2\2\0029\2\3\2\18\4\1\0'\5\4\0'\6\5\0B\2\4\0015\2\6\0=\1\a\0023\3\b\0006\4\1\0009\4\t\0049\4\n\4'\6\v\0'\a\f\0006\b\1\0009\b\r\b9\b\14\b9\b\15\b\18\t\2\0B\4\5\0016\4\1\0009\4\t\0049\4\n\4'\6\v\0'\a\16\0006\b\1\0009\b\r\b9\b\14\b9\b\17\b\18\t\2\0B\4\5\0016\4\1\0009\4\t\0049\4\n\4'\6\v\0'\a\18\0003\b\19\0\18\t\2\0B\4\5\0016\4\1\0009\4\t\0049\4\n\4'\6\v\0'\a\20\0006\b\1\0009\b\r\b9\b\14\b9\b\21\b\18\t\2\0B\4\5\0016\4\1\0009\4\t\0049\4\n\4'\6\v\0'\a\22\0006\b\1\0009\b\r\b9\b\14\b9\b\23\b\18\t\2\0B\4\5\0016\4\1\0009\4\t\0049\4\n\4'\6\v\0'\a\24\0006\b\1\0009\b\r\b9\b\14\b9\b\25\b\18\t\2\0B\4\5\0016\4\1\0009\4\t\0049\4\n\4'\6\v\0'\a\26\0006\b\1\0009\b\r\b9\b\14\b9\b\27\b\18\t\2\0B\4\5\0016\4\1\0009\4\t\0049\4\n\4'\6\v\0'\a\28\0003\b\29\0\18\t\2\0B\4\5\0016\4\1\0009\4\t\0049\4\n\4'\6\v\0'\a\30\0006\b\1\0009\b\r\b9\b\14\b9\b\31\b\18\t\2\0B\4\5\0016\4\1\0009\4\t\0049\4\n\4'\6\v\0'\a \0006\b\1\0009\b\r\b9\b\14\b9\b!\b\18\t\2\0B\4\5\0016\4\1\0009\4\t\0049\4\n\4'\6\v\0'\a\"\0006\b\1\0009\b\r\b9\b\14\b9\b#\b\18\t\2\0B\4\5\0016\4\1\0009\4\t\0049\4\n\4'\6\v\0'\a$\0006\b\1\0009\b\r\b9\b\14\b9\b%\b\18\t\2\0B\4\5\0016\4\1\0009\4\t\0049\4\n\4'\6\v\0'\a&\0006\b\1\0009\b\r\b9\b'\b9\b(\b\18\t\2\0B\4\5\0016\4\1\0009\4\t\0049\4\n\4'\6\v\0'\a)\0006\b\1\0009\b'\b9\b*\b\18\t\2\0B\4\5\0016\4\1\0009\4\t\0049\4\n\4'\6\v\0'\a+\0006\b\1\0009\b'\b9\b,\b\18\t\2\0B\4\5\0016\4\1\0009\4\t\0049\4\n\4'\6\v\0'\a-\0006\b\1\0009\b\r\b9\b'\b9\b.\b\18\t\2\0B\4\5\0016\4\1\0009\4\t\0049\4\n\4'\6\v\0'\a/\0006\b\1\0009\b\r\b9\b\14\b9\b0\b\18\t\2\0B\4\5\0012\0\0€K\0\1\0\1À\15formatting\r<space>f\16set_loclist\r<space>q\14goto_next\n<C-j>\14goto_prev\n<C-k>\26show_line_diagnostics\15diagnostic\r<space>e\15references\agr\16code_action\14<space>ca\vrename\14<space>rn\20type_definition\r<space>D\0\14<space>wl\28remove_workspace_folder\14<space>wr\25add_workspace_folder\14<space>wa\19implementation\agi\nhover\6K\0\agv\15definition\agd\16declaration\bbuf\blsp\agD\6n\bset\vkeymap\0\vbuffer\1\0\2\vsilent\2\fnoremap\2\27v:lua.vim.lsp.omnifunc\romnifunc\24nvim_buf_set_option\bapi\bvim\14on_attach”\3\0\1\17\0\18\00046\1\0\0009\1\1\0019\1\2\0019\1\3\1B\1\1\0025\2\6\0005\3\5\0=\3\a\2=\2\4\0016\2\0\0009\2\1\0029\2\b\2)\4\0\0'\5\t\0\18\6\1\0\18\a\0\0B\2\5\0026\3\n\0\f\5\2\0X\5\1€4\5\0\0B\3\2\4H\6\26€6\b\n\0009\n\v\a\14\0\n\0X\v\1€4\n\0\0B\b\2\4H\v\17€9\r\f\f\15\0\r\0X\14\b€6\r\0\0009\r\1\r9\r\2\r9\r\r\r9\15\f\f'\16\14\0B\r\3\1X\r\6€6\r\0\0009\r\1\r9\r\15\r9\r\16\r9\15\17\fB\r\2\1F\v\3\3R\víF\6\3\3R\6äK\0\1\0\fcommand\20execute_command\bbuf\vutf-16\25apply_workspace_edit\tedit\vresult\npairs\28textDocument/codeAction\21buf_request_sync\tonly\1\0\0\1\2\0\0\27source.organizeImports\fcontext\22make_range_params\tutil\blsp\bvimÁ\3\1\0\r\0\17\0\0316\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0023\2\3\0005\3\4\0006\4\5\0\18\6\3\0B\4\2\4X\a\t€8\t\b\0009\t\6\t5\v\a\0=\2\b\v9\f\t\1=\f\t\v5\f\n\0=\f\v\vB\t\2\1E\a\3\3R\aõ3\4\f\0007\4\r\0006\4\14\0009\4\15\4'\6\16\0B\4\2\0012\0\0€K\0\1\0´\1                augroup GO_LSP\n                autocmd!\n                autocmd BufWritePre *.go :silent! lua vim.lsp.buf.formatting()\n                augroup END\n            \bcmd\bvim\14goimports\0\nflags\1\0\1\26debounce_text_changes\3–\1\17capabilities\14on_attach\1\0\0\nsetup\vipairs\1\3\0\0\ngopls\rtsserver\0\15lsp-status\14lspconfig\frequire\0" },
    loaded = true,
    path = "/home/noname/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/noname/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/noname/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/noname/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/noname/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ripgrep = {
    loaded = true,
    path = "/home/noname/.local/share/nvim/site/pack/packer/start/ripgrep",
    url = "https://github.com/BurntSushi/ripgrep"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/home/noname/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\nC\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\14git_files\22telescope.builtin\frequireA\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\fbuffers\22telescope.builtin\frequireI\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\20command_history\22telescope.builtin\frequireI\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\20lsp_definitions\22telescope.builtin\frequireç\2\1\0\6\0\21\0,6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\1\0B\0\2\0029\0\3\0'\2\4\0B\0\2\0016\0\5\0009\0\6\0009\0\a\0'\2\b\0'\3\t\0003\4\n\0005\5\v\0B\0\5\0016\0\5\0009\0\6\0009\0\a\0'\2\b\0'\3\f\0003\4\r\0005\5\14\0B\0\5\0016\0\5\0009\0\6\0009\0\a\0'\2\b\0'\3\15\0003\4\16\0005\5\17\0B\0\5\0016\0\5\0009\0\6\0009\0\a\0'\2\b\0'\3\18\0003\4\19\0005\5\20\0B\0\5\1K\0\1\0\1\0\2\vsilent\2\fnoremap\2\0\14<Leader>d\1\0\2\vsilent\2\fnoremap\2\0\14<Leader>h\1\0\2\vsilent\2\fnoremap\2\0\n<C-B>\1\0\2\vsilent\2\fnoremap\2\0\n<C-P>\6n\bset\vkeymap\bvim\bfzf\19load_extension\nsetup\14telescope\frequire\0" },
    loaded = true,
    path = "/home/noname/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["trouble.nvim"] = {
    config = { "\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\ftrouble\frequire\0" },
    loaded = true,
    path = "/home/noname/.local/share/nvim/site/pack/packer/start/trouble.nvim",
    url = "https://github.com/folke/trouble.nvim"
  },
  ["vim-abolish"] = {
    loaded = true,
    path = "/home/noname/.local/share/nvim/site/pack/packer/start/vim-abolish",
    url = "https://github.com/tpope/vim-abolish"
  },
  ["vim-fetch"] = {
    loaded = true,
    path = "/home/noname/.local/share/nvim/site/pack/packer/start/vim-fetch",
    url = "https://github.com/wsdjeg/vim-fetch"
  },
  ["vim-vsnip"] = {
    loaded = true,
    path = "/home/noname/.local/share/nvim/site/pack/packer/start/vim-vsnip",
    url = "https://github.com/hrsh7th/vim-vsnip"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\n±\2\0\0\6\0\16\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\b\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\3=\3\t\0025\3\n\0=\3\v\0025\3\r\0004\4\3\0005\5\f\0>\5\1\4=\4\14\3=\3\15\2B\0\2\1K\0\1\0\rsections\14lualine_c\1\0\0\1\2\1\0\rfilename\tpath\3\1\15extensions\1\2\0\0\rquickfix\foptions\1\0\0\25component_separators\1\0\2\nright\bî‚·\tleft\bî‚µ\23section_separators\1\0\2\nright\bî‚¶\tleft\bî‚´\1\0\2\ntheme\fgruvbox\17globalstatus\2\nsetup\flualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: hop.nvim
time([[Config for hop.nvim]], true)
try_loadstring("\27LJ\2\nU\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\tkeys\28etovxqpdygfblzhckisuran\nsetup\bhop\frequire\0", "config", "hop.nvim")
time([[Config for hop.nvim]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
try_loadstring("\27LJ\2\ny\0\4\n\0\a\0\0166\4\0\0009\4\1\0049\4\2\4'\6\3\0B\4\2\0016\4\0\0009\4\4\0049\4\5\0049\5\6\0028\4\5\4\18\6\0\0\18\a\1\0\18\b\2\0\18\t\3\0B\4\5\1K\0\1\0\vmethod\rhandlers\blsp\rwincmd p\17nvim_command\bapi\bvimƒ\1\0\0\6\1\6\0\r6\0\0\0009\0\1\0009\0\2\0)\2\0\0'\3\3\0006\4\0\0009\4\1\0049\4\4\0049\4\5\4B\4\1\2-\5\0\0B\0\5\1K\0\1\0\3À\25make_position_params\tutil\28textDocument/definition\16buf_request\blsp\bvimd\0\0\6\0\6\0\v6\0\0\0006\2\1\0009\2\2\0026\4\1\0009\4\3\0049\4\4\0049\4\5\4B\4\1\0A\2\0\0A\0\0\1K\0\1\0\27list_workspace_folders\bbuf\blsp\finspect\bvim\nprintÙ\t\1\2\n\0011\0Ä\1-\2\0\0009\2\0\2\18\4\0\0\18\5\1\0B\2\3\0016\2\1\0009\2\2\0029\2\3\2\18\4\1\0'\5\4\0'\6\5\0B\2\4\0015\2\6\0=\1\a\0023\3\b\0006\4\1\0009\4\t\0049\4\n\4'\6\v\0'\a\f\0006\b\1\0009\b\r\b9\b\14\b9\b\15\b\18\t\2\0B\4\5\0016\4\1\0009\4\t\0049\4\n\4'\6\v\0'\a\16\0006\b\1\0009\b\r\b9\b\14\b9\b\17\b\18\t\2\0B\4\5\0016\4\1\0009\4\t\0049\4\n\4'\6\v\0'\a\18\0003\b\19\0\18\t\2\0B\4\5\0016\4\1\0009\4\t\0049\4\n\4'\6\v\0'\a\20\0006\b\1\0009\b\r\b9\b\14\b9\b\21\b\18\t\2\0B\4\5\0016\4\1\0009\4\t\0049\4\n\4'\6\v\0'\a\22\0006\b\1\0009\b\r\b9\b\14\b9\b\23\b\18\t\2\0B\4\5\0016\4\1\0009\4\t\0049\4\n\4'\6\v\0'\a\24\0006\b\1\0009\b\r\b9\b\14\b9\b\25\b\18\t\2\0B\4\5\0016\4\1\0009\4\t\0049\4\n\4'\6\v\0'\a\26\0006\b\1\0009\b\r\b9\b\14\b9\b\27\b\18\t\2\0B\4\5\0016\4\1\0009\4\t\0049\4\n\4'\6\v\0'\a\28\0003\b\29\0\18\t\2\0B\4\5\0016\4\1\0009\4\t\0049\4\n\4'\6\v\0'\a\30\0006\b\1\0009\b\r\b9\b\14\b9\b\31\b\18\t\2\0B\4\5\0016\4\1\0009\4\t\0049\4\n\4'\6\v\0'\a \0006\b\1\0009\b\r\b9\b\14\b9\b!\b\18\t\2\0B\4\5\0016\4\1\0009\4\t\0049\4\n\4'\6\v\0'\a\"\0006\b\1\0009\b\r\b9\b\14\b9\b#\b\18\t\2\0B\4\5\0016\4\1\0009\4\t\0049\4\n\4'\6\v\0'\a$\0006\b\1\0009\b\r\b9\b\14\b9\b%\b\18\t\2\0B\4\5\0016\4\1\0009\4\t\0049\4\n\4'\6\v\0'\a&\0006\b\1\0009\b\r\b9\b'\b9\b(\b\18\t\2\0B\4\5\0016\4\1\0009\4\t\0049\4\n\4'\6\v\0'\a)\0006\b\1\0009\b'\b9\b*\b\18\t\2\0B\4\5\0016\4\1\0009\4\t\0049\4\n\4'\6\v\0'\a+\0006\b\1\0009\b'\b9\b,\b\18\t\2\0B\4\5\0016\4\1\0009\4\t\0049\4\n\4'\6\v\0'\a-\0006\b\1\0009\b\r\b9\b'\b9\b.\b\18\t\2\0B\4\5\0016\4\1\0009\4\t\0049\4\n\4'\6\v\0'\a/\0006\b\1\0009\b\r\b9\b\14\b9\b0\b\18\t\2\0B\4\5\0012\0\0€K\0\1\0\1À\15formatting\r<space>f\16set_loclist\r<space>q\14goto_next\n<C-j>\14goto_prev\n<C-k>\26show_line_diagnostics\15diagnostic\r<space>e\15references\agr\16code_action\14<space>ca\vrename\14<space>rn\20type_definition\r<space>D\0\14<space>wl\28remove_workspace_folder\14<space>wr\25add_workspace_folder\14<space>wa\19implementation\agi\nhover\6K\0\agv\15definition\agd\16declaration\bbuf\blsp\agD\6n\bset\vkeymap\0\vbuffer\1\0\2\vsilent\2\fnoremap\2\27v:lua.vim.lsp.omnifunc\romnifunc\24nvim_buf_set_option\bapi\bvim\14on_attach”\3\0\1\17\0\18\00046\1\0\0009\1\1\0019\1\2\0019\1\3\1B\1\1\0025\2\6\0005\3\5\0=\3\a\2=\2\4\0016\2\0\0009\2\1\0029\2\b\2)\4\0\0'\5\t\0\18\6\1\0\18\a\0\0B\2\5\0026\3\n\0\f\5\2\0X\5\1€4\5\0\0B\3\2\4H\6\26€6\b\n\0009\n\v\a\14\0\n\0X\v\1€4\n\0\0B\b\2\4H\v\17€9\r\f\f\15\0\r\0X\14\b€6\r\0\0009\r\1\r9\r\2\r9\r\r\r9\15\f\f'\16\14\0B\r\3\1X\r\6€6\r\0\0009\r\1\r9\r\15\r9\r\16\r9\15\17\fB\r\2\1F\v\3\3R\víF\6\3\3R\6äK\0\1\0\fcommand\20execute_command\bbuf\vutf-16\25apply_workspace_edit\tedit\vresult\npairs\28textDocument/codeAction\21buf_request_sync\tonly\1\0\0\1\2\0\0\27source.organizeImports\fcontext\22make_range_params\tutil\blsp\bvimÁ\3\1\0\r\0\17\0\0316\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0023\2\3\0005\3\4\0006\4\5\0\18\6\3\0B\4\2\4X\a\t€8\t\b\0009\t\6\t5\v\a\0=\2\b\v9\f\t\1=\f\t\v5\f\n\0=\f\v\vB\t\2\1E\a\3\3R\aõ3\4\f\0007\4\r\0006\4\14\0009\4\15\4'\6\16\0B\4\2\0012\0\0€K\0\1\0´\1                augroup GO_LSP\n                autocmd!\n                autocmd BufWritePre *.go :silent! lua vim.lsp.buf.formatting()\n                augroup END\n            \bcmd\bvim\14goimports\0\nflags\1\0\1\26debounce_text_changes\3–\1\17capabilities\14on_attach\1\0\0\nsetup\vipairs\1\3\0\0\ngopls\rtsserver\0\15lsp-status\14lspconfig\frequire\0", "config", "nvim-lspconfig")
time([[Config for nvim-lspconfig]], false)
-- Config for: trouble.nvim
time([[Config for trouble.nvim]], true)
try_loadstring("\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\ftrouble\frequire\0", "config", "trouble.nvim")
time([[Config for trouble.nvim]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0", "config", "Comment.nvim")
time([[Config for Comment.nvim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\nC\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\14git_files\22telescope.builtin\frequireA\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\fbuffers\22telescope.builtin\frequireI\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\20command_history\22telescope.builtin\frequireI\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\20lsp_definitions\22telescope.builtin\frequireç\2\1\0\6\0\21\0,6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\1\0B\0\2\0029\0\3\0'\2\4\0B\0\2\0016\0\5\0009\0\6\0009\0\a\0'\2\b\0'\3\t\0003\4\n\0005\5\v\0B\0\5\0016\0\5\0009\0\6\0009\0\a\0'\2\b\0'\3\f\0003\4\r\0005\5\14\0B\0\5\0016\0\5\0009\0\6\0009\0\a\0'\2\b\0'\3\15\0003\4\16\0005\5\17\0B\0\5\0016\0\5\0009\0\6\0009\0\a\0'\2\b\0'\3\18\0003\4\19\0005\5\20\0B\0\5\1K\0\1\0\1\0\2\vsilent\2\fnoremap\2\0\14<Leader>d\1\0\2\vsilent\2\fnoremap\2\0\14<Leader>h\1\0\2\vsilent\2\fnoremap\2\0\n<C-B>\1\0\2\vsilent\2\fnoremap\2\0\n<C-P>\6n\bset\vkeymap\bvim\bfzf\19load_extension\nsetup\14telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\n;\0\1\4\0\4\0\0066\1\0\0009\1\1\0019\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\20vsnip#anonymous\afn\bvimê\5\1\0\n\0)\0g6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\6\0005\4\4\0003\5\3\0=\5\5\4=\4\a\0034\4\0\0=\4\b\0039\4\t\0009\4\n\0049\4\v\0045\6\r\0009\a\t\0009\a\f\a)\tüÿB\a\2\2=\a\14\0069\a\t\0009\a\f\a)\t\4\0B\a\2\2=\a\15\0069\a\t\0009\a\16\aB\a\1\2=\a\17\0069\a\t\0009\a\18\aB\a\1\2=\a\19\0069\a\t\0009\a\20\a5\t\21\0B\a\2\2=\a\22\6B\4\2\2=\4\t\0039\4\23\0009\4\24\0044\6\3\0005\a\25\0>\a\1\0065\a\26\0>\a\2\0064\a\3\0005\b\27\0>\b\1\aB\4\3\2=\4\24\3B\1\2\0019\1\2\0009\1\28\1'\3\29\0005\4 \0009\5\23\0009\5\24\0054\a\3\0005\b\30\0>\b\1\a4\b\3\0005\t\31\0>\t\1\bB\5\3\2=\5\24\4B\1\3\0019\1\2\0009\1!\1'\3\"\0005\4#\0009\5\t\0009\5\n\0059\5!\5B\5\1\2=\5\t\0044\5\3\0005\6$\0>\6\1\5=\5\24\4B\1\3\0019\1\2\0009\1!\1'\3%\0005\4&\0009\5\t\0009\5\n\0059\5!\5B\5\1\2=\5\t\0049\5\23\0009\5\24\0054\a\3\0005\b'\0>\b\1\a4\b\3\0005\t(\0>\t\1\bB\5\3\2=\5\24\4B\1\3\1K\0\1\0\1\0\1\tname\fcmdline\1\0\1\tname\tpath\1\0\0\6:\1\0\1\tname\vbuffer\1\0\0\6/\fcmdline\1\0\0\1\0\1\tname\vbuffer\1\0\1\tname\fcmp_git\14gitcommit\rfiletype\1\0\1\tname\vbuffer\1\0\1\tname\nvsnip\1\0\1\tname\rnvim_lsp\fsources\vconfig\t<CR>\1\0\1\vselect\2\fconfirm\n<C-e>\nabort\14<C-Space>\rcomplete\n<C-f>\n<C-b>\1\0\0\16scroll_docs\vinsert\vpreset\fmapping\vwindow\fsnippet\1\0\0\vexpand\1\0\0\0\nsetup\bcmp\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: gruvbox.nvim
time([[Config for gruvbox.nvim]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\24colorscheme gruvbox\bcmd\bvim\0", "config", "gruvbox.nvim")
time([[Config for gruvbox.nvim]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
