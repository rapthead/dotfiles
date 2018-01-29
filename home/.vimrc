" ----------------------------------------------------------------------------
"   Common Settings
" ----------------------------------------------------------------------------

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
" Plug 'airblade/vim-rooter'
" Plug 'idbrii/AsyncCommand'

" Plug 'neomake/neomake'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-sensible'
Plug 'iCyMind/NeoSolarized'
Plug 'easymotion/vim-easymotion'
" Plug 'ctrlpvim/ctrlp.vim'
Plug 'sjl/gundo.vim'
Plug 'mileszs/ack.vim'
Plug 'w0rp/ale'
" Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdcommenter'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'leafgarland/typescript-vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'groenewege/vim-less', { 'for': 'less' }
Plug 'insanum/votl', { 'for': 'votl' }
Plug 'mgrabovsky/vim-cuesheet', { 'for': 'cuesheet' }
Plug '2072/PHP-Indenting-for-VIm', { 'for': 'php' }
Plug 'vim-perl/vim-perl', { 'for': 'perl' }
" Plug 'klen/python-mode', { 'for': 'python' }
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'rapthead/vim-virtualenv', { 'for': 'python' }
Plug 'fisadev/vim-isort', { 'for': 'python' }
Plug 'hynek/vim-python-pep8-indent', { 'for': 'python' }

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh', }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'roxma/nvim-completion-manager'
filetype plugin indent on                   " required!
call plug#end()

" ----------------------------------------------------------------------------
"   Plugins Settings
" ----------------------------------------------------------------------------
" Plug 'autozimu/LanguageClient-neovim'
let g:LanguageClient_serverCommands = {
    \ 'typescript':     ['javascript-typescript-stdio', '--logfile', '/tmp/javascript-typescript-stdio-typescript'],
    \ 'javascript':     ['javascript-typescript-stdio', '--logfile', '/tmp/javascript-typescript-stdio']
    \ }

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

autocmd FileType javascript,typescript nnoremap <buffer>
  \ <leader>lf :call LanguageClient_textDocument_documentSymbol()<cr>
autocmd FileType javascript,typescript nnoremap <buffer>
  \ <leader>lr :call LanguageClient_textDocument_rename()<cr>
autocmd FileType javascript,typescript nnoremap <buffer>
  \ <leader>ld :call LanguageClient_textDocument_definition()<cr>
autocmd FileType javascript,typescript nnoremap <buffer>
  \ <leader>lh :call LanguageClient_textDocument_hover()<cr>
autocmd FileType javascript,typescript nnoremap <buffer>
  \ <leader>lr :call LanguageClient_textDocument_rename()<cr>

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
nnoremap <C-P> :Files<cr>
nnoremap <Leader>b :Buffers<cr>
nnoremap <Leader>h :History<cr>
imap <c-x><c-f> <plug>(fzf-complete-file)


colorscheme NeoSolarized

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
if has("gui_running")
    set background=light
    set guioptions-=T
    set guioptions-=m
    if has("gui_gtk2")
        set guifont=Source\ Code\ Pro\ Medium\ 10
    elseif has("gui_macvim")
        set guifont=Menlo\ Regular:h14
    elseif has("gui_win32")
        set guifont=Source_Code_Pro:h11:cRUSSIAN
    endif
endif

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
