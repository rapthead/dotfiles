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
set iminsert=0
set imsearch=-1 "раскладка по умолчанию - английская
set statusline=%<%f\ %m[%n]\ %{virtualenv#statusline()}\ [%H%R%Y]%=%-10.(%l,%c%V%)\ [en]\ %{&fileencoding}\ %P
" set statusline=%<%f\ %m[%n]\ [%H%R%Y]%=%-10.(%l,%c%V%)\ [en]\ %{&fileencoding}\ %P "изменения формата "statusline"
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
" set wildignore+=*/.git/*,*/.svn/*,*/node_modules/*,*.pyc

set cryptmethod=blowfish2
set colorcolumn=80

filetype off
syntax on
filetype plugin indent on

" без этого inotify не срабатывает (webpack)
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
Plug 'tpope/vim-abolish'
" Plug 'takac/vim-hardtime'
Plug 'wikitopian/hardmode'

Plug 'SirVer/ultisnips'
Plug 'altercation/vim-colors-solarized'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'flazz/vim-colorschemes'
Plug 'honza/vim-snippets'
Plug 'jlanzarotta/bufexplorer'
Plug 'majutsushi/tagbar'
Plug 'mileszs/ack.vim'
Plug 'w0rp/ale'
" Plug 'neomake/neomake'
" Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdcommenter'
" Plug 'sjl/gundo.vim'
Plug 'mbbill/undotree'
Plug 'tpope/vim-sensible'

Plug 'hail2u/vim-css3-syntax'
" Plug 'vim-scripts/SQLUtilities'
" Plug 'suan/vim-instant-markdown'
Plug 'blueyed/vim-diminactive'
Plug 'felixhummel/setcolors.vim'
" Plug 'kylef/apiblueprint.vim'

Plug 'groenewege/vim-less', { 'for': 'less' }
" Plug 'insanum/votl', { 'for': 'votl' }
" Plug 'mgrabovsky/vim-cuesheet', { 'for': 'cuesheet' }
" Plug '2072/PHP-Indenting-for-VIm', { 'for': 'php' }
Plug 'vim-perl/vim-perl', { 'for': 'perl' }
" Plug 'klen/python-mode', { 'for': 'python' }
" Plug 'Yggdroot/indentLine', { 'for': 'python' }
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
" Plug 'rapthead/vim-virtualenv', { 'for': 'python' }
Plug 'jmcantrell/vim-virtualenv'
Plug 'fisadev/vim-isort', { 'for': 'python' }
Plug 'hynek/vim-python-pep8-indent', { 'for': 'python' }
" Plug 'tweekmonster/braceless.vim', { 'for': 'python' }

Plug 'pangloss/vim-javascript' ", { 'for': 'javascript' }
Plug 'moll/vim-node' ", { 'for': 'javascript' }
Plug 'mxw/vim-jsx' ", { 'for': 'javascript.jsx' }
Plug 'digitaltoad/vim-pug'
Plug 'chase/vim-ansible-yaml'
Plug 'hashivim/vim-terraform'

filetype plugin indent on                   " required!
call plug#end()

" ----------------------------------------------------------------------------
"   Plugins Settings
" ----------------------------------------------------------------------------
" Plug 'takac/vim-hardtime'
let g:hardtime_default_on = 1
" Plug 'neomake/neomake'
let g:neomake_error_sign        = { 'text': '', 'texthl': 'ErrorMsg' }
let g:neomake_warning_sign      = { 'text': '', 'texthl': 'WarningMsg' }

" Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_custom_ignore = '\v[\/](\.git|\.hg|\.svn|node_modules)'
let g:ctrlp_cmd = 'CtrlPMRU'

" Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Plug 'tweekmonster/braceless.vim'
" autocmd FileType python BracelessEnable +indent +fold

" Plug 'mileszs/ack.vim'
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Plug 'scrooloose/syntastic'
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" 
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" "
" let g:syntastic_python_checkers = ['pyflakes', 'pycodestyle']
" 
" let g:syntastic_python_pylint_args = "-j 2 --disable=missing-docstring"
" let g:syntastic_python_python_exec = '/path/to/python3'
" 
" let g:syntastic_javascript_checkers = ['eslint']
" cabbrev <silent> bd <C-r>=(getcmdtype()==#':' && getcmdpos()==1 ? 'lclose\|bdelete' : 'bd')<CR>

" Plug 'neomake/neomake'
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_python_enabled_makers = ['pyflakes']
let g:neomake_css_enabled_makers = []
let g:neomake_open_list = 2
let g:neomake_list_height = 5

" autocmd! BufWritePost * Neomake
" augroup neomake
"     autocmd!
"     autocmd BufReadPost * Neomake
"     autocmd BufWritePost * Neomake
" augroup END

" Plug 'jlanzarotta/bufexplorer'
map <Leader>b :BufExplorer<cr>
map <Leader>c :CMiniBufExplorer<cr>
map <Leader>u :UMiniBufExplorer<cr>
map <Leader>t :TMiniBufExplorer<cr>

let g:bufExplorerShowRelativePath=1
let g:bufExplorerSplitOutPathName=0

" Plug 'altercation/vim-colors-solarized'
let g:solarized_italic=0

" Plug '2072/PHP-Indenting-for-VIm', { 'for': 'php' }
" let g:PHP_BracesAtCodeLevel = 1
let g:PHP_outdentphpescape = 1

" Plug 'easymotion/vim-easymotion'
let g:EasyMotion_do_mapping = 1
let g:EasyMotion_smartcase = 1
nmap s <Plug>(easymotion-s2)
map <C-J> <Plug>(easymotion-j)
map <C-K> <Plug>(easymotion-k)

colorscheme slate

set mouse=
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
    colorscheme solarized
    set guioptions-=T
    set guioptions-=m
    if has("gui_gtk2")
        set guifont=SauceCodePro\ Nerd\ Font\ Medium\ 10
        " set guifont=Source\ Code\ Pro\ Medium\ 10
    elseif has("gui_macvim")
        set guifont=SauceCodePro_Nerd_Font:h11:cRUSSIAN
    elseif has("gui_win32")
        set guifont=SauceCodePro_Nerd_Font:h11:cRUSSIAN
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
set listchars=eol:$,tab:>-,trail:=,precedes:<,extends:>

if has("autocmd") 
    " close quickfix on buffer leave
    autocmd BufWinLeave * lclose
    autocmd FileType * set nonumber linebreak foldcolumn=0

    autocmd FileType c,cpp set cindent 
        \formatoptions=croql comments=sr:/*,mb:*,ex:*/,:// number textwidth=41
        \ nowrap number

    autocmd FileType perl set number nowrap foldlevel=50 foldcolumn=3
        let perl_fold=1
        let perl_fold_blocks=1
    autocmd! BufEnter *.pl compiler perl

    autocmd FileType php set number nowrap foldlevel=50 foldcolumn=3

    autocmd FileType python setlocal colorcolumn=120 completeopt-=preview

    autocmd FileType javascript set nowrap foldlevel=50 foldcolumn=3 foldmethod=syntax

    autocmd FileType yaml setlocal shiftwidth=2

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
