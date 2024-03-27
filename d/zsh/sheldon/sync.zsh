#
# zsh/sheldon/sync.sh
#

# distingish on which OS/CPU running
case $(uname -s) in
Darwin)
	if [[ $(uname -m) != 'arm64' ]]; then
		export PC='mac_intel'
	else
		export PC='mac_arm'
	fi
    ;;

Linux)
	if [[ $(uname -m) != 'arm64' ]]; then
		export PC='linux_intel'
	else
		export PC='linux_arm'
	fi
    ;;

*)
	#### それ以外(Windows)の処理 ####
	if [[ $(uname -m) != 'arm64' ]]; then
		export PC='win_intel'
	else
		export PC='win_arm'
	fi
    ;;
esac

####################################################
# terminal settings
# unnbind key C-s, C-q in terminal
if [[ -t 0 ]]; then
	stty stop undef
	stty start undef
fi

# M-h(Alt-h) <- backward-kill-word(C-w)
# stty werase undef
# bindkey '"\eh": backward-kill-word'



####################################################
# zshell options
setopt autocd
setopt correct			# correct typing command
setopt hist_ignore_all_dups	# 古いものと同じなら古いものを削除
setopt hist_save_no_dups	# 古いコマンドと同じものは無視
setopt hist_ignore_space	# スペースで始まるコマンド行はヒストリから削除
setopt hist_reduce_blanks	# 余分な空白は詰めて記録
setopt hist_no_store		# historyコマンドはヒストリに登録しない
setopt hist_verify		# ヒストリを呼び出してから実行する間に一旦編集可能
setopt hist_expand		# 補完時にヒストリを自動的に展開
setopt inc_append_history	# ヒストリをインクリメンタルに追加
setopt share_history		# 他のターミナルとヒストリを共有
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# small word for C-w, M-h
WORDCHARS='*?.[]~&;!#$%^(){}<>'


# eval `dircolors -b ~/.dircolors`		# Windows

# # zsh の exntended_glob と HEAD^^^ を共存させる。
# # http://subtech.g.hatena.ne.jp/cho45/20080617/1213629154
# # git-escape-magic だとなぜか . ~/.zshrc したあとキーを1文字入力すると Ctrl-dが入るみたいなのでこれで対処
# # ...したつもりだったけど、cd でpreztoの補完候補が出力されたままになるので無効化しとく
# typeset -A abbreviations
# abbreviations=(
#   "L"    "| $PAGER"
#   "G"    "| grep"
#   "X"    "| xargs"
#   "T"    "| tail"
#   "C"    "| cat"
#   "W"    "| wc"
#   "A"    "| awk"
#   "S"    "| sed"
#   "E"    "2>&1 > /dev/null"
#   "N"    "> /dev/null"
#   "HEAD^"     "HEAD\\^"
#   "HEAD^^"    "HEAD\\^\\^"
#   "HEAD^^^"   "HEAD\\^\\^\\^"
#   "HEAD^^^^"  "HEAD\\^\\^\\^\\^\\^"
#   "HEAD^^^^^" "HEAD\\^\\^\\^\\^\\^"
# )
#
# magic-abbrev-expand () {
#   local MATCH
#   LBUFFER=${LBUFFER%%(#m)[-_a-zA-Z0-9^]#}
#   LBUFFER+=${abbreviations[$MATCH]:-$MATCH}
# }
#
# magic-abbrev-expand-and-insert () {
#   magic-abbrev-expand
#   zle self-insert
# }
#
# # magic-abbrev-expand-and-accept () {
# #   magic-abbrev-expand
# #   zle accept-line
# # }
#
# zle -N magic-abbrev-expand-and-insert
# # zle -N magic-abbrev-expand-and-accept
# # bindkey "\r"  magic-abbrev-expand-and-accept # M-x RET はできなくなる
# bindkey " "   magic-abbrev-expand-and-insert


####################################################
# environment variables

ENCODING=en_US.UTF-8
export LANG=$ENCODING
export LC_ALL=$ENCODING

export TIME_STYLE=long-iso				# yyyy-mm-dd

#export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/bin:$PATH
#export PATH=~/.cargo/bin:$PATH			# rust tools
export PATH=~/.fzf/bin:$PATH			# fzf
export PATH="$PATH:/opt/nvim-linux64/bin"	# nvim

# editor
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER=less						# for git

# auto-print time for command
export REPORTTIME=5
export TIMEFMT=$'⏰%E total'

# change background color to yellow for highlight search word in less
# https://qiita.com/PruneMazui/items/8a023347772620025ad6
export LESS_TERMCAP_so=$(echo -e '\e[1;43m\e[30m')
export LESS_TERMCAP_se=$(echo -e '\e[0m')

case $PC in
mac_intel)
    # postgresql@13 (from brew)"
    export PATH="/usr/local/opt/postgresql@13/bin:$PATH"

    # less
    export LESS='-R -N -S --no-init --shift 4 --LONG-PROMPT'
    export LESSOPEN='| /usr/share/source-highlight/src-hilite-lesspipe.sh %s'

    # coreutils from brew
    PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
    MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
    ;;

mac_arm)
    # postgresql@13 (from brew)"
    export PATH="/opt/homebrew/opt/postgresql@13/bin:$PATH"

    # less
    export LESS='-R -N -S --no-init --shift 4 --LONG-PROMPT'
    export LESSOPEN='| /opt/homebrew/bin/src-hilite-lesspipe.sh %s'

    # coreutils from brew
    PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
    MANPATH="/opt/homebrew/opt/coreutils/libexec/gnuman:$MANPATH"
    ;;

*)
    ;;
esac


####################################################
# alias
# (to invoke original command, use "\command")

#unalias ls
#alias ll="ls -FlGh --time-style='+%Y-%m-%d %H:%M:%S' | sed -E '2,$s/ +[0-9]+//'"
#alias ll="ls -lGh --color --time-style='+%Y-%m-%d %H:%M:%S'"
alias ls="ls -F --color"
alias ll="ls -lGh"

alias n=nvim
alias file='file -h'					# not follow symlink
alias dd='dd status=progress'
alias xcd='cd "$(xplr --print-pwd-as-result)"'

# tree
if [ -f $(which eza) ]; then
    alias tree='eza -TaF --git-ignore'
else
    alias tree='tree -I "*.pyc|__pycache__|*~" --charset=C -A $PWD'
fi

case $PC in
### Mac
mac_intel)
	alias cls='printf "\e]50;ClearScrollback\a"'	# buffer clear on iTerm2
	alias rm='/usr/local/bin/trash -F'		# trash
	alias e='open'					# file browser
	;;

mac_arm)
	alias cls='printf "\e]50;ClearScrollback\a"'	# buffer clear on iTerm2
	alias rm='/opt/homebrew/bin/trash -F'		# trash
	alias e='open'					# file browser
	;;

### Linux
linux_intel)
	alias cls=clear					# buffer clear
	alias rm=trash-put				# trash
	alias e='nautilus . 2> /dev/null &'		# file browser
	;;

linux_arm)
	alias cls=clear					# buffer clear
	alias rm=trash-put				# trash
	alias e='nautilus . 2> /dev/null &'		# file browser
	;;

### Windows
*)
	alias e='/mnt/c/Windows/explorer.exe'		# file browser
    ;;
esac

# LS_COLORS
eval $(dircolors -b ~/dotfiles/d/dot.dircolors)

