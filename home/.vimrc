" ----------------------------------------------------------------------------
"   Common Settings
" ----------------------------------------------------------------------------

set cpoptions+=>
set nocompatible
set noea
set undofile
set encoding=utf-8
set showbreak=-> "визуально показывать перенос длинных строк перенесенные строки будит начинаться с '-->'
set hlsearch incsearch ignorecase " поиск - подсветка, немедленное отображение, без учета регистра
set magic " For regular expressions turn magic on
set showcmd "показывает подсказку при вводе длинных команд
set showmatch "показывает парные скобки
set showmode "отображение режима
set wildmenu wcm=<Tab> " автодополнение - улучшенный режим, кнопка автодополнения
set helplang=ru "язык справки
set backspace=indent,eol,start "выбор режима работы клавиши "backspace" позволяет "backspace" удалять все
set smartindent "установка интелектуального автоматического форматирования отступов

set formatoptions=tcql "опции форматирования по умолчанию
set comments& "выставление стандартных опций комментария
set laststatus=2 "всегда отображать строку состояния
set keymap=russian-jcukenwin "добавление допалнительной раскладки
set langmap=йq,цw,уe,кr,еt,нy,гu,шi,щo,зp,х[,ъ],фa,ыs,вd,аf,пg,рh,оj,лk,дl,э',яz,чx,сc,мv,иb,тn,ьm,б\\,,ю.,ё`,ЙQ,ЦW,УE,КR,ЕT,НY,ГU,ШI,ЩO,ЗP,Х{,Ъ},ФA,ЫS,ВD,АF,ПG,РH,ОJ,ЛK,ДL,Ж:,Э\\",ЯZ,ЧX,СC,МV,ИB,ТN,ЬM,Б\\<,Ю\\>,Ё\\~
" set langmap=ёйцукенгшщзхъфывапролджэячсмитьбюЙЦУКЕHГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ\\;;`qwertyuiop[]asdfghjkl\\;’zxcvbnm\\,.QWERTYUIOP{}ASDFGHJKL:\\«ZXCVBNM$
" set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯЖ;ABCDEFGHIJKLMNOPQRSTUVWXYZ:,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
set iminsert=0
set imsearch=-1 "раскладка по умолчанию - английская
"set statusline=%<%f\ %m[%n]\ %{virtualenv#statusline()}\ [%H%R%Y]%=%-10.(%l,%c%V%)\ [en]\ %{&fileencoding}\ %P
set statusline=%<%f\ %m[%n]\ [%H%R%Y]%=%-10.(%l,%c%V%)\ [en]\ %{&fileencoding}\ %P "изменения формата "statusline"
set cmdheight=2 "высота командной строки
set hidden "не выгружать буферы из памяти при закрытии окна буфера
set fileencodings=utf-8,cp1251,cp866,koi8-r,utf-16le "список используемых кодировок
set title "включение изменения заголовка окна
set history=1000
set scrolloff=3
set modelines=0
set lazyredraw " Don't redraw while executing macros (good performance config)
set foldcolumn=1
set nowrap

" indent
set tabstop=8
set expandtab
set smarttab "установка вставки пробелов в начало строки вместо символа 'tabstop'
set shiftwidth=4 "установка размера таб-отступа
set shiftround
set autoindent "автоматическая табуляция. если текущая строка начинается с TAB, то и следующая тоже
set wildignore+=*/.git/*,*/.svn/*,*/node_modules/*,*/target/*,*.pyc,*.class

let mapleader="\<SPACE>"

filetype off
syntax on
syntax sync minlines=10000
filetype plugin indent on

" без этого inotify не срабатывает
set backupcopy=yes
" ----------------------------------------------------------------------------
"   Plug
" ----------------------------------------------------------------------------

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'dense-analysis/ale'
" Plug 'Quramy/tsuquyomi'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'Valloric/YouCompleteMe'
" Plug 'iCyMind/NeoSolarized'
" Plug 'pangloss/vim-javascript'
" Plug 'mxw/vim-jsx'
" Plug 'statico/vim-javascript-sql'
" Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next' }

" Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'jparise/vim-graphql'
" Plug 'mattn/vim-sqlfmt'

Plug 'hashivim/vim-terraform'
Plug 'tpope/vim-abolish' " cases modifications
Plug 'tpope/vim-sensible'
Plug 'morhetz/gruvbox'
" Plug 'easymotion/vim-easymotion'
" Plug 'sjl/gundo.vim'
" Plug 'mileszs/ack.vim'
" Plug 'scrooloose/nerdcommenter'
" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'
Plug 'stephpy/vim-yaml'

Plug 'leafgarland/typescript-vim'
" Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
filetype plugin indent on                   " required!
call plug#end()

" ----------------------------------------------------------------------------
"   Plugins Settings
" ----------------------------------------------------------------------------
" " Plug 'neoclide/coc.nvim'
" " if hidden is not set, TextEdit might fail.
" set hidden
" 
" " Some servers have issues with backup files, see #649
" set nobackup
" set nowritebackup
" 
" " Better display for messages
" set cmdheight=2
" 
" " You will have bad experience for diagnostic messages when it's default 4000.
" set updatetime=300
" 
" " don't give |ins-completion-menu| messages.
" set shortmess+=c
" 
" " always show signcolumns
" set signcolumn=yes
" 
" " Use tab for trigger completion with characters ahead and navigate.
" " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" 
" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction
" 
" " Use <c-space> to trigger completion.
" inoremap <silent><expr> <c-space> coc#refresh()
" 
" " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" " Coc only does snippet and additional edit on confirm.
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" 
" " Use `[c` and `]c` to navigate diagnostics
" nmap <silent> [c <Plug>(coc-diagnostic-prev)
" nmap <silent> ]c <Plug>(coc-diagnostic-next)
" 
" " Remap keys for gotos
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)
" 
" " Use K to show documentation in preview window
" nnoremap <silent> K :call <SID>show_documentation()<CR>
" 
" function! s:show_documentation()
"   if (index(['vim','help'], &filetype) >= 0)
"     execute 'h '.expand('<cword>')
"   else
"     call CocAction('doHover')
"   endif
" endfunction
" 
" " Highlight symbol under cursor on CursorHold
" autocmd CursorHold * silent call CocActionAsync('highlight')
" 
" " Remap for rename current word
" nmap <leader>rn <Plug>(coc-rename)
" 
" " Remap for format selected region
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)
" 
" augroup mygroup
"   autocmd!
"   " Setup formatexpr specified filetype(s).
"   autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"   " Update signature help on jump placeholder
"   autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" augroup end
" 
" " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)
" 
" " Remap for do codeAction of current line
" nmap <leader>ac  <Plug>(coc-codeaction)
" " Fix autofix problem of current line
" nmap <leader>qf  <Plug>(coc-fix-current)
" 
" " Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
" nmap <silent> <TAB> <Plug>(coc-range-select)
" xmap <silent> <TAB> <Plug>(coc-range-select)
" xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)
" 
" command! -nargs=0 CocDetail :call CocAction('diagnosticInfo')
" 
" " Use `:Format` to format current buffer
" command! -nargs=0 Format :call CocAction('format')
" 
" " Use `:Fold` to fold current buffer
" command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" 
" " use `:OR` for organize import of current buffer
" command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
" 
" " Add status line support, for integration with other plugin, checkout `:h coc-status`
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" 
" " Using CocList
" " Show all diagnostics
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" " Show commands
" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document
" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" 
" " Plug 'statico/vim-javascript-sql'
" let g:javascript_sql_dialect = 'pgsql'
" 
" " Plug 'autozimu/LanguageClient-neovim'
" " let g:LanguageClient_windowLogMessageLevel = "Error"
" " let g:LanguageClient_serverCommands = {
" "     \ 'javascript': ['/usr/bin/javascript-typescript-stdio'],
" "     \ 'typescript': ['/usr/bin/javascript-typescript-stdio'],
" "     \ }

" nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
" nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
" nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" Plug 'w0rp/ale'
let g:ale_completion_enabled = 1
let g:ale_linters = {
\   'typescript': ['tsserver'],
\}
nmap K <Plug>(ale_hover)
nmap gd <Plug>(ale_go_to_definition)
nmap gy <Plug>(ale_go_to_type_definition)
nmap <C-k> <Plug>(ale_previous_wrap)
nmap <C-j> <Plug>(ale_next_wrap)
nmap <leader>rn <Plug>(ale_rename)
" inoremap <silent> <leader>rn :AleRename<CR>

" Plug 'Shougo/deoplete.nvim'
" let g:deoplete#enable_at_startup = 1
" inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
" call deoplete#custom#source('_', 'sorters', ['sorter_word'])

" nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
" nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
" nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
" 
" autocmd FileType javascript,typescript nnoremap <buffer>
"   \ <leader>lf :call LanguageClient_textDocument_documentSymbol()<cr>
" autocmd FileType javascript,typescript nnoremap <buffer>
"   \ <leader>lr :call LanguageClient_textDocument_rename()<cr>
" autocmd FileType javascript,typescript nnoremap <buffer>
"   \ <leader>ld :call LanguageClient_textDocument_definition()<cr>
" autocmd FileType javascript,typescript nnoremap <buffer>
"   \ <leader>lh :call LanguageClient_textDocument_hover()<cr>
" autocmd FileType javascript,typescript nnoremap <buffer>
"   \ <leader>lr :call LanguageClient_textDocument_rename()<cr>

" Plug 'Quramy/tsuquyomi'
" let g:tsuquyomi_disable_quickfix = 1
" autocmd FileType typescript nmap <buffer> <Leader>r <Plug>(TsuquyomiRenameSymbol)
" autocmd FileType typescript nmap <buffer> <Leader>R <Plug>(TsuquyomiRenameSymbolC)
" autocmd FileType typescript nmap <buffer> K :echo tsuquyomi#hint()<cr>


" Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Plug 'mileszs/ack.vim'
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Plug '2072/PHP-Indenting-for-VIm', { 'for': 'php' }
" let g:PHP_BracesAtCodeLevel = 1
let g:PHP_outdentphpescape = 1

" Plug 'easymotion/vim-easymotion'
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1
nmap s <Plug>(easymotion-s2)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" Plug 'junegunn/fzf.vim'
nnoremap <C-P> :GFiles --cached --others --exclude-standard<cr>
nnoremap <Leader>b :Buffers<cr>
nnoremap <Leader>h :History<cr>
imap <c-x><c-f> <plug>(fzf-complete-file)


set mouse=a
nmap <ScrollWheelUp> <nop>
nmap <S-ScrollWheelUp> <nop>
nmap <C-ScrollWheelUp> <nop>
nmap <ScrollWheelDown> <nop>
nmap <S-ScrollWheelDown> <nop>
nmap <C-ScrollWheelDown> <nop>
nmap <ScrollWheelLeft> <nop>
nmap <S-ScrollWheelLeft> <nop>
nmap <C-ScrollWheelLeft> <nop>
nmap <ScrollWheelRight> <nop>
nmap <S-ScrollWheelRight> <nop>
nmap <C-ScrollWheelRight> <nop>
imap <ScrollWheelUp> <nop>
imap <S-ScrollWheelUp> <nop>
imap <C-ScrollWheelUp> <nop>
imap <ScrollWheelDown> <nop>
imap <S-ScrollWheelDown> <nop>
imap <C-ScrollWheelDown> <nop>
imap <ScrollWheelLeft> <nop>
imap <S-ScrollWheelLeft> <nop>
imap <C-ScrollWheelLeft> <nop>
imap <ScrollWheelRight> <nop>
imap <S-ScrollWheelRight> <nop>
imap <C-ScrollWheelRight> <nop>
vmap <ScrollWheelUp> <nop>
vmap <S-ScrollWheelUp> <nop>
vmap <C-ScrollWheelUp> <nop>
vmap <ScrollWheelDown> <nop>
vmap <S-ScrollWheelDown> <nop>
vmap <C-ScrollWheelDown> <nop>
vmap <ScrollWheelLeft> <nop>
vmap <S-ScrollWheelLeft> <nop>
vmap <C-ScrollWheelLeft> <nop>
vmap <ScrollWheelRight> <nop>
vmap <S-ScrollWheelRight> <nop>
vmap <C-ScrollWheelRight> <nop>
"отключение мыши

" исключение буферов quickfix из listed
augroup qf
    autocmd!
    autocmd FileType qf set nobuflisted
augroup END
""""""""""""""""""""""""""""""""""
"""""клавиатурные сокращения""""""
""""""""""""""""""""""""""""""""""
"не использовать режим Ex, использовать Q для форматирования
map Q gq

"вызов функции изменения "statusline"
nmap <silent> <F7> :call ChLang()<cr>
imap <silent> <F7> <Left><Right><C-O>:call ChLang()<cr>

"переключение между открытыми файлами: <Tab>, <Shift>+<Tab>
nmap <Tab>   :cclose<CR>:bnext<CR>
nmap <S-Tab> :cclose<CR>:bprevious<CR>
nmap <C-Tab> :cclose<CR>:tabnext<CR>
""""""""""""""""
"""""menus""""""
""""""""""""""""
"меню выбора кодировки по f8
menu Encoding.utf-8        :e ++enc=utf-8<CR>
menu Encoding.windows-1251 :e ++enc=cp1251<CR>
menu Encoding.utf-16le     :e ++enc=utf-16le<CR>
menu Encoding.koi8-r 	   :e ++enc=koi8-r<CR>
menu Encoding.ibm-866      :e ++enc=ibm866<CR>
map <F8> :emenu Encoding.<TAB>

if has("win32")
    set dir=~/_vimfiles/swaps/
    set undodir=~/_vimfiles/undos/
    lan mes en
else
    set dir=~/.vim/swaps/
    set undodir=~/.vim/undos/
    set t_Co=256
endif

set background=dark
colorscheme gruvbox
" if has("gui_running")
"     set background=light
"     set guioptions-=T
"     set guioptions-=m
"     if has("gui_gtk2")
"         set guifont=Source\ Code\ Pro\ Medium\ 10
"     elseif has("gui_macvim")
"         set guifont=Menlo\ Regular:h14
"     elseif has("gui_win32")
"         set guifont=Source_Code_Pro:h11:cRUSSIAN
"     endif
" else
"     colorscheme slate
" endif

"функция для изменения "statusline" при изменении раскладки
function! ChLang()
    let str=substitute(&statusline, '\ ', '\\ ','g')
    if &iminsert==0
        highlight StatusLine ctermfg=DarkBlue guifg=DarkBlue
        let str=substitute(str,'\[en\]', '[ru]','')
        exec "set iminsert=1 statusline=".str
    else
        highlight StatusLine ctermfg=DarkGreen guifg=DarkGreen
        let str=substitute(str,'\[ru\]', '[en]','')
        exec "set iminsert=0 statusline=".str
    endif
endfunction

"изменение цвета "statusline" по умолчанию
highlight StatusLine ctermfg=DarkGreen guifg=DarkGreen

"показывать неполные строки не помещающиеся в экран
set display=lastline

"минимальное количество символов для горизонтальной прокрутки
set sidescroll=5

"отменяет действие "ignorecase" если шаблон находится в верхнем регистре
set smartcase

"замена непечатаемых символов в режиме "list"
if &listchars ==# 'eol:$'
    set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif
" Show problematic characters.
set list

if has("autocmd")
    autocmd FileType * set nonumber linebreak foldcolumn=0

    autocmd FileType c,cpp set cindent 
        \formatoptions=croql comments=sr:/*,mb:*,ex:*/,:// number textwidth=41
        \ nowrap number

    autocmd FileType perl set number nowrap foldlevel=50 foldcolumn=3
        let perl_fold=1
        let perl_fold_blocks=1
    autocmd! BufEnter *.pl compiler perl

    autocmd FileType php set number nowrap foldlevel=50 foldcolumn=3

    autocmd FileType python setlocal colorcolumn=120

    " переходить к последней позиции в файле
    autocmd BufReadPost * 
        \ if line("'\"") > 0 && line("'\"") <= line("$") | 
        \   exe "normal g`\"" | 
        \ endif 

    " outline
    autocmd BufNewFile,BufReadPost *.otl setfiletype votl
    autocmd BufReadPre,BufNewFile auth.otl 
        \ setlocal noswapfile foldlevel=1 "viminfo=""
    autocmd BufRead,BufNewFile auth.otl 
        \ setlocal foldlevel=1
endif

function! CueMakeTitle()
    %s#FILE\s\+".\+\\\d\d\s\?-\s\?\(.\+\).\(wav\|flac\)"\s\+WAVE#\0    TITLE "\1"#
endfunction
