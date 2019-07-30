filetype off
set encoding=utf-8
set fileformats=unix,dos,mac
set fileencodings=ucs-bom,utf-8,iso-2022-jp,eucjp-ms,euc-jp,sjis,cp932,latin-1
scriptencoding utf-8
set helplang=ja
let g:vim_indent_cont=3

" auto reload vimrc
augroup reload-vimrc
  autocmd!
  autocmd BufWritePost *vimrc source $MYVIMRC | edit! $MYVIMRC
augroup END

""" plugins{{{
if has('vim_starting')
  set runtimepath+=~/.vim/plugged/vim-plug
  if !isdirectory(expand('~/.vim/plugged/vim-plug'))
    echo 'install vim-plug...'
    call system('mkdir -p ~/.vim/plugged/vim-plug')
    call system('git clone https://github.com/junegunn/vim-plug.git ~/.vim/plugged/vim-plug/autoload')
  end
endif

call plug#begin('~/.vim/plugged')
  Plug 'junegunn/vim-plug',
        \ {'dir': '~/.vim/plugged/vim-plug/autoload'}

  " docs
  Plug 'vim-jp/vimdoc-ja'
  Plug 'mattn/learn-vimscript'

  " library
  Plug 'Shougo/vimproc.vim',
        \ { 'dir': '~/.vim/plugged/vimproc.vim',
        \   'do': 'make'}

  Plug 'Shougo/denite.nvim'
  Plug 'h1mesuke/unite-outline'
  Plug 'Shougo/neoyank.vim'
  Plug 'Shougo/neomru.vim'
  Plug 'Shougo/vimshell'
  Plug 'Shougo/neocomplete'
  Plug 'Shougo/neosnippet'
  Plug 'Shougo/neosnippet-snippets'
  if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
  endif
  Plug 'zchee/deoplete-jedi'

  " colorscheme
  Plug 'itchyny/lightline.vim'
  Plug 'cocopon/iceberg.vim'

  "python
  Plug 'davidhalter/jedi-vim',
        \ { 'for': 'python',
        \   'do': 'pip install jedi'}
  Plug 'Vimjas/vim-python-pep8-indent',
  Plug 'msmhrt/py3venv.vim',


  Plug 'thinca/vim-quickrun'
  Plug 'junegunn/vim-easy-align'


  Plug 'w0rp/ale'
  Plug 'Yggdroot/indentLine'
  Plug 'bronson/vim-trailing-whitespace'
  Plug 'tpope/vim-fugitive'

  " syntax
  Plug 'tpope/vim-markdown'
  Plug 'posva/vim-vue'


call plug#end()
filetype plugin indent on
""" }}}

""" color {{{
set t_Co=256
set background=dark
set termguicolors
syntax enable
colorscheme iceberg
""" }}}

""" basic {{{
"日本語入力をリセット
augroup imreset
  autocmd!
  autocmd BufNewFile, BufRead * set iminsert=0
augroup END

"ファイル保存ダイアログの初期ディレクトリをバッファファイル位置に設定
set browsedir=buffer
"クリップボードをWindowsと連携
set clipboard=unnamed,unnamedplus,autoselect
"変更中のファイルでも、保存しないで他のファイルを表示
set hidden
"カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]

"バックアップ・スワップファイルを作らない"
set noswapfile " swapは要検討？
set nobackup
set noundofile

" オートインデント、改行、インサートモード開始直後にバックスペースキーで
" 削除できるようにする。
set backspace=indent,eol,start

" 移動コマンドを使ったとき、行頭に移動しない
set nostartofline

" バッファが変更されているとき、コマンドをエラーにするのでなく、保存する
" かどうか確認を求める
set confirm

" 編集中のファイルが変更されたら自動で読み直す
set autoread

" ヒープをミュート
set t_vb=
set novisualbell
set noerrorbells

" 全モードでマウスを有効化
set mouse=a

" キーコードはすぐにタイムアウト。マッピングはタイムアウトしない
set notimeout ttimeout ttimeoutlen=200


"------------------------------------------------------------
" 表示
"
"行番号を表示する
set number
" 現在行の強調
set cursorline

" コマンドライン補完を便利に
set wildmenu
" タイプ途中のコマンドを画面最下行に表示
set showcmd
"タブ文字、行末など不可視文字を表示する
set list
"listで表示される文字のフォーマットを指定する
set listchars=tab:>-,trail:-,nbsp:%,extends:>,precedes:<
"閉じ括弧が入力されたとき、対応する括弧を表示する
set showmatch

" 折り畳みを有効化
set foldmethod=marker

" コマンドラインの高さを2行に
set cmdheight=2


"------------------------------------------------------------
" 検索
" 検索語を強調表示（<C-L>を押すと現在の強調表示を解除する）
set hlsearch
"インクリメンタルサーチを行う
set incsearch
" 検索時に大文字・小文字を区別しない。ただし、検索後に大文字小文字が
" 混在しているときは区別する
set ignorecase
set smartcase
"検索をファイルの先頭へループしない
set nowrapscan
""" }}}

""" indent {{{
" 新しい行を開始したとき、現在行と同じインデントになる
set autoindent

"
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab


augroup file-indents
  autocmd!
  autocmd FileType c setl ts=4 sw=4 sts=4 et
  autocmd FileType cpp setl ts=4 sw=4 sts=4 et
  autocmd FileType vim setl ts=2 sw=2 sts=2 et
  autocmd FileType python setl autoindent indentkeys+=0#
  autocmd FileType python setl ts=4 sw=4 sts=4 et
augroup END
""" }}}}

""" map {{{
inoremap <silent> jj <Esc>

" Yの動作をDやCと同じにする
map Y y$

" 検索後のハイライト解除
nnoremap <C-L> :nohl<CR><C-L>

" 見た目通りの上下移動
nnoremap j gj
nnoremap k gk
""" }}}

""" plugin-settings {{{
let g:mapleader = "\\"

" denite {{{
call denite#custom#var('file_rec', 'command',
      \['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'default_opts',
      \['--follow', '--no-group', '--no-color'])
call denite#custom#source('file_rec', 'matchers', ['matcher_fuzzy'])

nmap <Space> [denite]
noremap <silent> [denite] :<C-u>Denite file_rec<CR>

" }}}

" lightline {{{
set laststatus=2
let g:lightline = {
\ 'colorscheme': 'iceberg',
\ 'active': {
\   'left': [ [ 'mode', 'paste' ],
\             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
\ },
\ 'component': {
\   'readonly': '%{&filetype=="help"?"":&readonly?"✖":""}',
\   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
\   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
\ },
\ 'component_visible_condition': {
\   'readonly': '(&filetype!="help"&& &readonly)',
\   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
\   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
\ },
\}
" }}}

" vim-quickrun {{{
let g:quickrun_config = {
\ "_" : {
\   "outputter/buffer/split" : ":botright 8sp",
\   "outputter/error/success" : "buffer",
\   "outputter/error/error" : "quickfix",
\   "outputter/buffer/close_on_empty" : 1,
\   "outputter/quickfix/errorformat" : "%f:%l,%m in %f on line %l",
\   "outputter" : "error",
\   "hook/time/enable" : 1,
\   "runner" : "vimproc",
\   "runner/vimproc/updatetime" : 500,
\ },
\ "python" : {
\   "cmdopt" : "-u"
\ },
\}

" C-cで実行を強制終了、実行していない場合はC-cを呼び出す
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"
"}}}

"jedi-vim {{{
" jediにvimの設定を任せると'completeopt+=preview'するので
" 自動設定機能をOFFにし手動で設定を行う
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
" quickrunと被るため大文字に変更
let g:jedi#rename_command = '<Leader>R'
"}}}

" deoplete {{{
let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<C-n>" :
        \ neosnippet#expandable_or_jumpable() ?
        \    "\<Plug>(neosnippet_expand_or_jump)" : "\<tab>"
" }}}

"ALE{{{
let g:ale_sign_column_always = 0
let g:ale_linters = {
\ 'python': ['flake8', 'mypy']
\}
"}}}
""" }}}
