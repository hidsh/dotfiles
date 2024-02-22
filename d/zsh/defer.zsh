#
# zsh/defer.sh
#

# distingish OS/CPU

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

# bind key M-h(Alt-h) <- backward-kill-word(C-w)
stty werase undef
bind '"\eh": backward-kill-word'



####################################################
# zshell options
setopt correct					# correct typing command
setopt hist_ignore_all_dups		# ヒストリに追加されるコマンド行が古いものと同じなら古いものを削除
setopt hist_save_no_dups		# 古いコマンドと同じものは無視
setopt hist_ignore_space		# スペースで始まるコマンド行はヒストリから削除
setopt hist_reduce_blanks		# 余分な空白は詰めて記録
setopt hist_no_store			# historyコマンドはヒストリに登録しない
setopt hist_verify				# ヒストリを呼び出してから実行する間に一旦編集可能
setopt hist_expand				# 補完時にヒストリを自動的に展開
setopt inc_append_history		# ヒストリをインクリメンタルに追加
setopt share_history			# 他のターミナルとヒストリを共有
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# small word for C-w, M-h
WORDCHARS='*?.[]~&;!#$%^(){}<>'


# eval `dircolors -b ~/.dircolors`		# Windows

# for ubuntu
ubuntu-version() {
	if [ -f /etc/lsb-release ]; then
		echo `cat /etc/lsb-release |grep -oP '(?<=").+(?=")'`
	fi
}


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

ENCODE=en_US.utf-8
export LANG=$ENCODE
export LC_ALL=$ENCODE
export PATH=$HOME/bin:$PATH

# editor
export EDITOR='nvim'
export VISUAL='nvim'
#export PAGER='less'

# auto-print time for command
export REPORTTIME=2
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
alias cd..="cd .."
alias cd-="cd -"


alias file='file -h'					# not follow symlink
alias dd='dd status=progress'


# tree
if [ -f $(which eza) ]; then
	alias tree='eza -Ta --icons'
else
	alias tree='tree -I "*.pyc|__pycache__|*~" --charset=C -A $PWD'
fi

case $PC in
### Mac
mac_intel)
	alias cls='printf "\e]50;ClearScrollback\a"'	# buffer clear on iTerm2
	alias rm='/usr/local/bin/trash -F'				# trash
	alias e='open'									# file browser
	;;

mac_arm)
	alias cls='printf "\e]50;ClearScrollback\a"'	# buffer clear on iTerm2
	alias rm='/opt/homebrew/bin/trash -F'			# trash
	alias e='open'									# file browser
	;;

### Linux
linux_intel)
linux_arm)
	alias cls=clear									# buffer clear
	alias rm=trash-put								# trash
	alias e='nautilus . 2> /dev/null &'				# file browser
    ;;

### Windows
*)
	alias e='/mnt/c/Windows/explorer.exe'			# file browser
    ;;
esac

####################################################
# functions

# file path in title bar
precmd() {eval 'echo -ne "\033]0;${PWD/#$HOME/~}\007"'}

# my zip compress command
# zip DIR-NAME
zzzip () {
    dir=$1
    d=`echo $dir | sed -e 's/\/$//'`
    \zip -r $d.zip $d
    if [ "$?" -eq 0 ]; then
        echo
        echo -n "  Zipped to: "
        ls -d $PWD/{*,.*} | grep $d.zip
    fi
}
alias zip=zzzip

no-cmd() {
	echo "This command is unbound by 'no-cmd' in ~/.zshrc"
}

find- () {find $* 2>/dev/null}
rg- () {rg $* 2>/dev/null}

alias pico=no-cmd
alias nano=no-cmd

####################################################
# keybindings

# unbind shell keybindings
# check by 'bindkey | less'
bindkey -r "^[T"        # alt-T: transpose-words
bindkey -r "^[t"        # alt-t: transpose-words
bindkey -r "^[h"		# alt-h: run-help

####################################################
# various commands, apps, sdk, programs

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_COMPLETION_TRIGGER=',,'	# ,,<TAB>でfzfに入る
FZF_THEME_DRACURA_MOD='--color=dark,fg:-1,bg:-1,hl:#ff87d7,fg+:#d6ffe0,bg+:-1,hl+:#5fff87,info:#af87ff,prompt:#ff87d7,pointer:#5fff87,marker:#ff87d7,spinner:#ff87d7 '
export FZF_DEFAULT_OPTS=$FZF_THEME_DRACURA_MOD'--height 40% --reverse --header-lines=0 --border=none --no-separator --no-info --no-scrollbar'
#export FZF_CTRL_T_OPTS='--height 100% --preview="[[ $(file --mime {}) =~ binary ]] && \
#                 echo {} is a binary file || \
#                 (highlight -O ansi -l {} || \
#                 cat {}) 2> /dev/null | head -100"'
export FZF_CTRL_T_OPTS='--bind ctrl-p:preview-up,ctrl-n:preview-down --preview "bat --theme zenburn --color=always --style=grid --line-range :100 {}"'
export FZF_CTRL_R_OPTS='--with-nth=2..'
#export FZF_ALT_C_OPTS="--preview 'tree -CFA {} | head -200'"
export FZF_ALT_C_OPTS="--bind ctrl-p:preview-up,ctrl-n:preview-down --preview 'exa -T {} | head -100'"

if type rg &> /dev/null; then
	export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    #export FZF_DEFAULT_COMMAND='rg --files --hidden'
fi

# rga: rip-grep all with fzf
rga-fzf() {
	RG_PREFIX="rga --files-with-matches"
	local file
	file="$(
		FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
			fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
				--phony -q "$1" \
				--bind "change:reload:$RG_PREFIX {q}" \
				--preview-window="70%:wrap"
	)" &&
	echo "opening $file" &&
	xdg-open "$file"
}

# fzf-git-hash
function fzf-git-hash() {
        git gr | fzf | sed -e "s/^[\*\|][ |\\\/\*]*//g" | awk '{ print $1 }'
}
#alias -g C='$(fzf-git-hash)'

# command history
# function select-history() {
#   BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="Hist > ")
#   CURSOR=$#BUFFER
# }
# zle -N select-history
# bindkey '^r' select-history

# cdr with fzf
#autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
#add-zsh-hook chpwd chpwd_recent_dirs

#zstyle ':completion:*' recent-dirs-insert both
#zstyle ':chpwd:*' recent-dirs-max 500
#zstyle ':chpwd:*' recent-dirs-default true
#zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/shell/chpwd-recent-dirs"
#zstyle ':chpwd:*' recent-dirs-pushd true

#function fzf-cdr() {
#    local selected_dir=$(cdr -l | awk '{ print $2 }' | fzf --prompt="cd:")
#    if [ -n "$selected_dir" ]; then
#        BUFFER="cd ${selected_dir}"
#        zle accept-line
#    fi
#   zle clear-screen
#}
#zle -N fzf-cdr
#bindkey '^v' fzf-cdr


# docker completion
# if [ -e ~/.zsh/completions ]; then
#   fpath=(~/.zsh/completions $fpath)
# fi

# alias dps='docker ps --format "{{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Command}}\t{{.RunningFor}}"'
# alias dc='docker exec -it `dps | fzf | cut -f 1` /bin/bash'


# meld
# alias meld='/Applications/Meld.app/Contents/MacOS/Meld'		# Mac

# wine
# alias wine='/Applications/Wine\ Stable.app/Contents/MacOS/wine'	# Mac

# gitignore.io cli
#function gi() { curl -sLw n https://www.toptal.com/developers/gitignore/api/$@ ;}


# node setting for jest
#export NODE_OPTIONS=--experimental-vm-modules

# raspberry pi pico-sdk
#export PICO_SDK_PATH="$HOME/git-clone/pico-sdk"
#export PICO_SDK_PATH="$HOME/pico/pico-sdk"


# llvm
case $PC in
mac_intel)
    export PATH="/usr/local/opt/llvm/bin:$PATH"
    PATH="/usr/local/bin:$PATH"
	;;

mac_arm)
    export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
    PATH="/opt/homebrew/bin:$PATH"
	;;

*)
    ;;
esac

# Mac; iterm2
case $PC in
mac_intel)
mac_arm)
	test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
	;;

*)
    ;;
esac

# for qmk_firmware
#export GTAGSLIBPATH=/usr/local/Cellar/avr-gcc/7.3.0/avr/include
# :/usr/local/Cellar/avr-gcc/7.3.0/avr/include/sys\
# :/usr/local/Cellar/avr-gcc/7.3.0/avr/include/avr\
# :/usr/local/Cellar/avr-gcc/7.3.0/avr/include/util\

# pyenv for qmk
#    % echo 'eval "$(pyenv init --path)"' >> ~/.zprofile
#    % echo 'eval "$(pyenv init -)"' >> ~/mysetting/.zshrc-mymod
#eval "$(pyenv init -)"

# nim
#export PATH=/Users/g/.nimble/bin:$PATH

# Mac: opoenssl
#export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
#export LDFLAGS="-L/opt/homebrew/opt/openssl@3/lib"
#export CPPFLAGS="-I/opt/homebrew/opt/openssl@3/include"
#export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@3/lib/pkgconfig"

# rbenv, ruby
#eval "$(rbenv init -)"

# Mac: use gnu-gcc instead of clang-gcc forcely
#alias gcc='gcc-12'
#alias mypath='echo $PATH | tr ":" "\n"'

# picocom as arduino serial monitor
#alias picocom='picocom --imap lfcrlf /dev/tty.usbmodem11101'

# Renesas R8C C++ framework
#PATH=$PATH:/usr/local/m32c-elf/bin

# jekyll-zzz-kbd
#/Users/g/.local/share/gem/ruby/3.2.0/bin
#export PATH="$HOME/.local/share/gem/ruby/3.2.0/bin:$PATH"

# zephyr (not for zmk firmware)
#export ZEPHYR_BASE=/Users/g/zeph-3.5.0/zephyr
#export ESPTOOL_PORT=/dev/cu.usbmodem1101

# github cli
eval "$(gh completion -s zsh)"


####################################################
# in tray yet

