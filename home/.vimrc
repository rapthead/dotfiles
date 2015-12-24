set rtp+=~/.vim/bundle/Vundle.vim
filetype off
set nocompatible

call vundle#begin()
Plugin 'gmarik/Vundle.vim'

Plugin 'itchyny/calendar.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin '2072/PHP-Indenting-for-VIm'
Plugin 'insanum/votl'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'vim-scripts/mru.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'groenewege/vim-less'
Plugin 'mgrabovsky/vim-cuesheet'
Plugin 'vim-perl/vim-perl'
Plugin 'klen/python-mode'
Plugin 'tpope/vim-surround'

Bundle 'pydave/AsyncCommand'
call vundle#end()

set encoding=utf-8

set showbreak=->
"визуально показывать перенос длинных строк
"перенесенные строки будит начинаться с '-->'

" поиск - подсветка, немедленное отображение, без учета регистра
set hlsearch incsearch ignorecase

set showcmd
"показывает подсказку при вводе длинных команд

set showmatch
"показывает парные скобки

set showmode
"отображение режима

" автодополнение - улучшенный режим, кнопка автодополнения
set wildmenu wcm=<Tab>

set helplang=ru
"язык справки

set backspace=indent,eol,start
"выбор режима работы клавиши "backspace"
"позволяет "backspace" удалять все

set smartindent
"установка интелектуального автоматического форматирования отступов

syntax on
filetype indent on
filetype plugin on

set formatoptions=tcql 
"опции форматирования по умолчанию

set comments&
"выставление стандартных опций комментария

set laststatus=2
"всегда отображать строку состояния

set keymap=russian-jcukenwin
"добавление допалнительной раскладки

set iminsert=0
set imsearch=-1
"раскладка по умолчанию - английская

set statusline=%<%f\ %m[%n]\ [%H%R%Y]%=%-10.(%l,%c%V%)\ [en]\ %{&fileencoding}\ %P
"изменения формата "statusline"

set cmdheight=2
"высота командной строки

set hidden
"не выгружать буферы из памяти при закрытии окна буфера

set fileencodings=utf-8,cp1251,cp866,koi8-r,utf-16le
"список используемых кодировок

set title
"включение изменения заголовка окна

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

"""""""""""""""""
"""""indent""""""
"""""""""""""""""
set tabstop=8
set expandtab
set smarttab
"установка вставки пробелов в начало строки вместо символа 'tabstop'
set shiftwidth=4
"установка размера таб-отступа
set shiftround
set autoindent
"автоматическая табуляция. если текущая строка начинается с TAB,
"то и следующая тоже
""""""""""""""""""""""""""""""""""
"""""клавиатурные сокращения""""""
""""""""""""""""""""""""""""""""""
map Q gq
"не использовать режим Ex, использовать Q для форматирования

nmap <silent> <F7> :call ChLang()<cr>
imap <silent> <F7> <Left><Right><C-O>:call ChLang()<cr>
"вызов функции изменения "statusline"

nmap <space> <C-D>
"""""""""""""""""
"minibufexplorer"
"""""""""""""""""
map <Leader>b :BufExplorer<cr>
map <Leader>c :CMiniBufExplorer<cr>
map <Leader>u :UMiniBufExplorer<cr>
map <Leader>t :TMiniBufExplorer<cr>
"""""""""""""""""
"bufexplorer"
"""""""""""""""""
let g:bufExplorerShowRelativePath=1
let g:bufExplorerSplitOutPathName=0
"""""""""""""""""
"pomodoro"
"""""""""""""""""
" Duration of a pomodoro in minutes (default: 25)
let g:pomodoro_time_work = 25

" Duration of a break in minutes (default: 5)
let g:pomodoro_time_slack = 5 

" Log completed pomodoros, 0 = False, 1 = True (default: 0)
let g:pomodoro_do_log = 1

" Path to the pomodoro log file (default: /tmp/pomodoro.log)
let g:pomodoro_log_file = "/tmp/pomodoro.log" 
""""""""""""""""
"""""menus""""""
""""""""""""""""
menu Encoding.utf-8        :e ++enc=utf-8<CR>
menu Encoding.windows-1251 :e ++enc=cp1251<CR>
menu Encoding.utf-16le     :e ++enc=utf-16le<CR>
menu Encoding.koi8-r 	   :e ++enc=koi8-r<CR>
menu Encoding.ibm-866      :e ++enc=ibm866<CR>
map <F8> :emenu Encoding.<TAB>
"меню выбора кодировки по f8

"--*plugins*--"
let g:proj_flags='imstg'
let g:solarized_italic=0
let g:PHP_BracesAtCodeLevel = 1
set wildignore+=*/static_root/*,*/.git/*,*/.svn/*,*/bower_components/*,*/node_modules/*,*.pyc
colorscheme solarized

if has("win32")
    set dir=~/_vimfiles/swaps/
    lan mes en
else
    set dir=~/.vim/swaps/
    set t_Co=256
endif

set background=dark
if has("gui_running")
    set guioptions-=T
    set guioptions-=m
    set background=light
    if has("gui_gtk2")
        "set guifont=LiberationMono\ 11
        set guifont=Source\ Code\ Pro\ Medium\ 10
    elseif has("gui_macvim")
        set guifont=Menlo\ Regular:h14
    elseif has("gui_win32")
        set guifont=Source_Code_Pro:h11:cRUSSIAN
    endif
endif

set scrolloff=3
set modelines=0

"переключение между открытыми файлами: <Tab>, <Shift>+<Tab>
nmap <Tab>   :cclose<CR>:bnext<CR>
nmap <S-Tab> :cclose<CR>:bprevious<CR>
nmap <C-Tab> :cclose<CR>:tabnext<CR>

"ускоренное передвижение по тексту
nmap <C-H> 5h
nmap <C-J> 5j
nmap <C-K> 5k
nmap <C-L> 5l

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
    autocmd FileType * set nonumber linebreak foldcolumn=0

    autocmd FileType c,cpp set cindent 
        \formatoptions=croql comments=sr:/*,mb:*,ex:*/,:// number textwidth=41
        \ nowrap number

    autocmd FileType perl set number nowrap foldlevel=50 foldcolumn=3
        let perl_fold=1
        let perl_fold_blocks=1
    autocmd! BufEnter *.pl compiler perl

    autocmd FileType php set number nowrap foldlevel=50 foldcolumn=3

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
