"
" key bindings
"
"------------------------------------------------------
"MODE                   NO-REMAPPING	REMAPPING
"normal			nnoremap	nmap
"visual			vnoremap	vmap
"command mode		cnoremap	cmap
"insert mode		inoremap	imap
"normal + vilual	noremap		map
"command + insert 	noremap!	map!
"------------------------------------------------------

" swap ; and : (normal mode)
nnoremap ; :
nnoremap : ;

" swap ; and : (insert mode)
"inoremap ; :
"inoremap : ;

"nnoremap : <ESC>	" disable :
nnoremap 4 $

noremap j gj
noremap k gk
noremap gj j
noremap gk k
noremap m <C-f>
noremap M <C-b>
noremap U <C-r>
noremap q <Nop>
noremap a A
noremap 4 $
noremap 3 #
noremap 8 *
noremap ] %
"noremap <A-j> gT
"noremap <A-k> gt

"inoremap <silent> jj <ESC>

"
" line number
"
"set number

function! s:toggle_linum()
	set number!
endfunction

command! Linum call s:toggle_linum()
cnoreabbrev l Linum

"
" truncate-lines
"
function! s:toggle_wrap()
	set wrap!
endfunction

command! TrancateLines call s:toggle_wrap()
cnoreabbrev t TrancateLines

"
" other setting
"

" swp, undo, バックアップファイル出力無効
set noswapfile
set noundofile
set nobackup

"ターミナル接続を高速にする
set ttyfast

"ターミナルで256色表示を使う
set t_Co=256

"バックアップを作成しない
set nobackup

"Swapを作るまでの時間m秒
set updatetime=0

"行間をでシームレスに移動する
"set whichwrap+=h,l,<,>,[,],b,s

"カッコを閉じたとき対応するカッコに一時的に移動
set nostartofline

"コマンド、検索パターンを50まで保存
set history=50

set incsearch

"smart case で検索する
set ignorecase
set smartcase

"行末まで検索したら行頭に戻る
"set wrapscan


"括弧の対応をハイライト
set showmatch

"ターミナル上からの張り付けを許可
"set paste

"カーソルラインを表示する
"set cursorline
:autocmd InsertEnter,InsertLeave * set cul!


"ファイルタイプに応じて挙動,色を変える
syntax on
filetype plugin on
filetype indent on

" 自動コメントを無効化
au FileType * setlocal formatoptions-=r
au FileType * setlocal formatoptions-=o

"OSのクリップボードを使用する
set clipboard+=unnamedplus
set clipboard+=unnamed

" for windows on wsl2
"
" prerequisites: win32yank, zenhan
" refer: https://qiita.com/sijiaoh/items/4add320d684b7978a29f
"
" let g:clipboard = {
"  \   'name': 'win32yank-wsl',
"  \   'copy': {
"  \      '+': 'win32yank.exe -i --crlf',
"  \      '*': 'win32yank.exe -i --crlf',
"  \    },
"  \   'paste': {
"  \      '+': 'win32yank.exe -o --lf',
"  \      '*': 'win32yank.exe -o --lf',
"  \   },
"  \   'cache_enabled': 0,
"  \ }

" Auto disable ime for windows on wsl2
"autocmd InsertLeave  * :call system('zenhan.exe 0')
"autocmd CmdlineLeave * :call system('zenhan.exe 0')

"sudoを忘れて権限のないファイルを編集した時\sudoで保存
nmap ,sudo :w !sudo tee %<CR>

"indent  tab->space:	set expandtab
"        tab<-space:	set noet
"        width:			set tabstop=2
set shiftwidth=4 smarttab
set expandtab
"set tabstop=8 softtabstop=0
"set noet ts=4 sts=-1 sw=0

" .lesskeyを保存したら自動的にコンパイルする
autocmd BufWritePost ~/.lesskey call system("lesskey " .. expand("%"))


" :sでの置換を楽にする
" https://zenn.dev/vim_jp/articles/2023-06-30-vim-substitute-tips
" Usage:  :s<Space>
cnoreabbrev <expr> s getcmdtype() .. getcmdline() ==# ':s' ? [getchar(), ''][1] .. "%s///g<Left><Left><Left>" : 's'



"
" theme (color scheme)
"
"colorscheme onedark
"colorscheme hybrid_material

"
" transparent setting
"
"highlight Normal ctermbg=none
"highlight NonText ctermbg=none
"highlight LineNr ctermbg=none
"highlight Folded ctermbg=none
"highlight EndOfBuffer ctermbg=none

" vim-plug
"let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
"if empty(glob(data_dir . '/autoload/plug.vim'))
"  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubu"sercontent.com/junegunn/vim-plug/master/plug.vim'
"  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
"endif


