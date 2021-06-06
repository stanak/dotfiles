filetype off
set encoding=utf-8
set fileformats=unix,dos,mac
set fileencodings=ucs-bom,utf-8,iso-2022-jp,eucjp-ms,euc-jp,sjis,cp932,latin-1
set nofixendofline
scriptencoding utf-8
set helplang=ja
let g:vim_indent_cont=3

" auto reload vimrc
augroup reload-vimrc
  autocmd!
  autocmd BufWritePost *vimrc source $MYVIMRC | edit! $MYVIMRC
augroup END

" 閉じタグ入力自動補完
augroup MyTagComp
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o><Esc>V=
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o><Esc>V=
  autocmd Filetype vue inoremap <buffer> </ </<C-x><C-o><Esc>V=
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
  "Plug 'Shougo/vimproc.vim',
  "      \ { 'dir': '~/.vim/plugged/vimproc.vim',
  "      \   'do': 'make'}

  Plug 'Shougo/neoyank.vim'
  Plug 'Shougo/neomru.vim'
  "Plug 'Shougo/neosnippet'
  "Plug 'Shougo/neosnippet-snippets'
  Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}

  " colorscheme
  Plug 'itchyny/lightline.vim'
  Plug 'cocopon/iceberg.vim'

  "python
  Plug 'Vimjas/vim-python-pep8-indent',
  Plug 'msmhrt/py3venv.vim',


  Plug 'thinca/vim-quickrun'
  Plug 'junegunn/vim-easy-align'


  Plug 'w0rp/ale'
  Plug 'Yggdroot/indentLine'
  Plug 'bronson/vim-trailing-whitespace'
  Plug 'tyru/open-browser.vim'
  Plug 'tyru/open-browser-github.vim'

  " fzf-preview
  Plug 'yuki-yano/fzf-preview.vim', { 'branch': 'release/rpc' }
  Plug 'junegunn/fzf'
	Plug 'lambdalisue/gina.vim'

call plug#end()
filetype plugin indent on
""" }}}

""" color {{{
set t_Co=256
set background=dark
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
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
set clipboard=unnamed,unnamedplus
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

" ambiwidthを上書きする主に二文字分を取る全角記号対策
" 環境変えたら何も変えずに直ったので備忘録に置いとく
" setcellwidths([])

" Windows Subsystem for Linux で、ヤンクでクリップボードにコピー
if system('uname -a | grep microsoft') != ''
  augroup wsl-yank
    autocmd!
    autocmd TextYankPost * :call system('echo '.shellescape(join(v:event.regcontents, "\<CR>")).' | clip.exe')
  augroup END
endif

augroup vimrc-auto-mkdir
  autocmd!
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
  function! s:auto_mkdir(dir, force)
    if !isdirectory(a:dir) && (a:force ||
    \    input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction
augroup END

" %による対応タグ、ブレースにジャンプする機能を有効にする
packadd! matchit
" rubyのendに移動する
:let b:match_words="<begin>:<end>"
:let b:match_words="<do>:<end>"
:let b:match_words="<if>:<end>"


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
imap <Nul> <Nop>

" Yの動作をDやCと同じにする
map Y y$

" 検索後のハイライト解除
nnoremap <C-L> :nohl<CR><C-L>

" 見た目通りの上下移動
nnoremap j gj
nnoremap k gk
""" }}}

"Plugin Setting {{{
" lightline {{{
set laststatus=2
let g:lightline = {
\ 'colorscheme': 'iceberg',
\ 'active': {
\   'left': [ [ 'mode', 'paste' ],
\             [ 'branch', 'readonly', 'filename', 'modified' ] ]
\ },
\ 'component': {
\   'readonly': '%{&filetype=="help"?"":&readonly?"✖":""}',
\   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
\   'branch': '%{gina#component#repo#branch()}'
\ },
\ 'component_visible_condition': {
\   'readonly': '(&filetype!="help"&& &readonly)',
\   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
\   'branch': '(gina#component#repo#branch())'
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

"ALE{{{
let g:ale_sign_column_always = 0
let g:ale_linters = {
\ 'python': ['flake8', 'mypy'],
\ 'ruby': ['rubocop']
\}
"}}}

"Coc{{{
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" coc extensions
let g:coc_global_extensions = [
   \ 'coc-pyright',
   \ 'coc-solargraph',
   \ 'coc-json',
   \ 'coc-vetur',
   \ ]

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.

xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
"nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
"" Manage extensions
"nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
"" Show commands
"nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
"" Find symbol of current document
"nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
"" Search workspace symbols
"nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
"" Do default action for next item.
"nnoremap <silent> <space>j  :<C-u>CocNext<CR>
"" Do default action for previous item.
"nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
"" Resume latest coc list
"nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
"
"}}}

" fzf-preview {{{
nnoremap <fzf-p> <Nop>
xnoremap <fzf-p> <Nop>
nmap     <space>	<fzf-p>
xmap     <space>  <fzf-p>
nmap <Leader>f [fzf-p]
xmap <Leader>f [fzf-p]

nnoremap <silent> <fzf-p>h     :<C-u>FzfPreviewDirectoryFilesRpc $HOME<CR>
nnoremap <silent> <fzf-p>r     :<C-u>FzfPreviewFromResourcesRpc buffer project_mru<CR>
nnoremap <silent> <fzf-p>w     :<C-u>FzfPreviewProjectMruFilesRpc<CR>
nnoremap <silent> <fzf-p>a     :<C-u>FzfPreviewFromResourcesRpc project_mru git<CR>
nnoremap <silent> <fzf-p>s     :<C-u>FzfPreviewGitStatusRpc<CR>
nnoremap <silent> <fzf-p>gg    :<C-u>FzfPreviewGitActionsRpc<CR>
nnoremap <silent> <fzf-p>b     :<C-u>FzfPreviewBuffersRpc<CR>
nnoremap <silent> <fzf-p>/     :<C-u>FzfPreviewLinesRpc --resume --add-fzf-arg=--no-sort<CR>
" nnoremap <silent> <fzf-p>*     :<C-u>FzfPreviewLinesRpc --add-fzf-arg=--no-sort --add-fzf-arg=--query="<C-r>=expand('<cword>')<CR>"<CR>
nnoremap <silent> <fzf-p>*     :<C-u>FzfPreviewProjectGrepRpc --add-fzf-arg=--exact --add-fzf-arg=--no-sort<Space>-F<Space>"<C-r>=expand('<cword>')<CR>"<CR>
xnoremap <silent> <fzf-p>*     "sy:FzfPreviewLinesRpc --add-fzf-arg=--no-sort --add-fzf-arg=--query="<C-r>=substitute(@s, '\(^\\v\)\\|\\\(<\\|>\)', '', 'g')<CR>"<CR>
nnoremap <silent> <fzf-p>q     :<C-u>FzfPreviewQuickFixRpc<CR>
nnoremap <silent> <fzf-p>l     :<C-u>FzfPreviewLocationListRpc<CR>
nnoremap          <fzf-p>f     :<C-u>FzfPreviewProjectGrepRpc --add-fzf-arg=--exact --add-fzf-arg=--no-sort<Space>
xnoremap          <fzf-p>f     "sy:FzfPreviewProjectGrepRpc --add-fzf-arg=--exact --add-fzf-arg=--no-sort<Space>-F<Space>"<C-r>=substitute(substitute(@s, '\n', '', 'g'), '/', '\\/', 'g')<CR>"
nnoremap <silent> <fzf-p>F     :<C-u>FzfPreviewProjectGrepRecallRpc --add-fzf-arg=--exact --add-fzf-arg=--no-sort --resume<CR>
" }}}

""" }}}
