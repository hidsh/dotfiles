-----------------
-- key bindings
-----------------

------------------------------------------------------
-- MODE                 NO-REMAPPING    REMAPPING
-- normal               nnoremap        nmap
-- visual               vnoremap	vmap
-- command mode         cnoremap	cmap
-- insert mode		inoremap	imap
-- normal + vilual      noremap		map
-- command + insert     noremap!	map!
------------------------------------------------------

--local map = vim.api.nvim_set_keymap
local map = vim.keymap.set
local opts = {noremap = true, silent = true}

vim.g.mapleader = ' '

-- unmap
map('n', 'q',     '', opts)
map('n', 'ZZ',    '', opts)
map('n', 'ZQ',    '', opts)
map('n', '<C-f>', '', opts)

-- swap ; and : (normal mode)
map({'n', 'i'}, ';', ':', {noremap = true})     -- nnoremap ; : / inoremap ; :
map({'n', 'i'}, ':', ';', {noremap = true})     -- nnoremap : ; / inoremap : ;

-- swap j/k and gj/gk: (normal mode)
map('n', 'j', 'gj', opts)     -- nnoremap j gj
map('n', 'gj', 'j', opts)     -- nnoremap gj j
map('n', 'k', 'gk', opts)     -- nnoremap k gk
map('n', 'gk', 'k', opts)     -- nnoremap gk k

map('n', 'm', '<C-f>', opts)     -- nnoremap m <C-f>
map('n', 'M', '<C-b>', opts)     -- nnoremap M <C-b>
map('n', 'U', '<C-r>', opts)     -- nnoremap U <C-r>

-- without shift-key
map({'n', 'i'}, '4', '$', opts)     -- nnoremap 4 $
map('n', '3', '#', opts)     -- nnoremap 3 #
map('n', '8', '*', opts)     -- nnoremap 8 *
map('n', 'a', 'A', opts)     -- nnoremap a A
map('n', ']]', '%', opts)     -- nnoremap ] %

-- just delete one character no push into register
vim.keymap.set('n', 'x', '"_x')
vim.keymap.set('n', 'X', '"_X')
vim.keymap.set('n', 's', '"_s')

-- disable highlight
map('n', '<ESC><ESC>', ':noh<CR>', opts)


--map('n', '<A-j>', 'gT', opts)     -- nnoremap <A-j> gT
--map('n', '<A-k>', 'gt', opts)     -- nnoremap <A-k> gt

--map('i', 'jj', '<ESC>', opts)     -- inoremap <silent> jj <ESC>

--map('c', '<c-h>', [[ wildmenumode() ? '<c-h>' : '<left>' ]], opts) -- expr mapping



--map('c', '<C-h>', '<Left>',     opts)
--map('c', '<C-l>', '<Right>',    opts)
--map('c', '<C-j>', '<Down>',     opts)
--map('c', '<C-k>', '<Up>', 	    opts)


-- toggle line number
map('n', 'tn', ':lua vim.o.number = not vim.o.number<CR>', opts)

-- truncate-lines
map('n', 'tt', ':lua vim.o.wrap = not vim.o.wrap<CR>', opts)

-----------------
-- other setting
-----------------

-- swp, undo, バックアップファイル出力無効
vim.o.swapfile = false        -- set noswapfile
vim.o.undofile = false        -- set noundofile
vim.o.backup = false          -- set nobackup

-- ターミナル接続を高速にする
vim.o.ttyfast = true           -- set ttyfast

-- ターミナルで256色表示を使う
--set t_Co=256

-- 行間をシームレスに移動する
--set whichwrap+=h,l,<,>,[,],b,s

-- カッコを閉じたとき対応するカッコに一時的に移動
vim.o.startofline = false      -- set nostartofline

-- コマンド、検索パターンを50まで保存
vim.o.history = 50            	-- set history=50

vim.o.incsearch = true          -- set incsearch

-- smart case で検索する
vim.o.ignorecase = true         -- set ignorecase
vim.o.smartcase = true		-- set smartcase

-- 行末まで検索したら行頭に戻る
vim.o.wrapscan = true           -- set wrapscan


-- 括弧の対応をハイライト
vim.o.showmatch = true		-- set showmatch

-- ターミナル上からの張り付けを許可
vim.o.paste = true		-- set paste

-- カーソルラインを表示する
--vim.o.cursorline = true        -- set cursorline

-- ファイルタイプに応じて挙動,色を変える
vim.o.syntax = 'on'             -- syntax on
vim.o.filetype = 'plugin', 'indent', 'on'       -- filetype plugin on, filetype indent on

-- 自動コメントを無効化
--au FileType * setlocal formatoptions-=r
--au FileType * setlocal formatoptions-=o

-- OSのクリップボードを使用する
vim.o.clipboard = 'unnamedplus' 		--set clipboard+=unnamedplus

-----------------
-- TODO: translate .vim --> .lua below
-----------------

-- sudoを忘れて権限のないファイルを編集した時\sudoで保存
--nmap ,sudo :w !sudo tee %<CR>

-- global tab settings (4 spaces)
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.smarttab = true

-- disable insert automatic comment
vim.opt.formatoptions:remove('r')

--show linum
--vim.opt.number = true

-- .lesskeyを保存したら自動的にコンパイルする
--autocmd BufWritePost ~/.lesskey call system('lesskey ' .. expand('%'))


-- :sでの置換を楽にする
-- https://zenn.dev/vim_jp/articles/2023-06-30-vim-substitute-tips
-- Usage:  :s<Space>
--vim.cmd(
--  [[cnoreabbrev <expr> s getcmdtype() .. getcmdline() ==# ':s' ? [getchar(), ''][1] .. '%s///g<Left><Left><Left>' : 's'
--  ]])



-----------------
-- theme (color scheme)
-----------------
--colorscheme onedark
--colorscheme hybrid_material


-----------------
-- plugins
-----------------

-- kitty-scrollback.nvim
--require('kitty-scrollback').setup()
