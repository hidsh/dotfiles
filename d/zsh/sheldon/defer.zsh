#
# zsh/sheldon/defer.sh
#

#echo zsh/sheldon/defer.sh
# ------------------------------
# functions
# ------------------------------

# for ubuntu
#ubuntu-version() {
#	if [ -f /etc/lsb-release ]; then
#		echo `cat /etc/lsb-release |grep -oP '(?<=").+(?=")'`
#	fi
#}

# file path in title bar
precmd() {eval 'echo -ne "\033]0;${PWD/#$HOME/~}\007"'}

nop() {
	echo "This command is unbound by 'nop()' in zsh/sheldon/defer.sh"
}
alias pico=nop
alias nano=nop

foo () {echo $1}
ps-1 () {
    local labels=(pid user pcpu %mem cmd)

    if [[ "$1" = '' ]]; then
        ps axo ${(j:,:)labels} --sort=-pcpu,-%mem 2>/dev/null
    else
        ps axo ${(j:,:)labels} --sort=-pcpu,-%mem | cut -c -$(( COLUMNS - 2 )) 2>/dev/null
    fi
}
alias p-='ps-1 | less -S'

kill- () {
    local help="Usage: $0
Kill specified process via fzf"

    if [[ "$#" -eq 1 ]] && [ "$1" = '--help' ]; then
        echo $help; return 0
    elif [[ ! "$#" -eq 0 ]]; then
        echo $help; return 1
    fi

    procs=$(ps-1 t)
    local sel=$(echo $procs | fzf --header-lines=1 --ellipsis='')
    local line=(${(@s: :)sel})
    local pid=${line[1]}
    local user=${line[2]}
    local cmdline=${line[5]}
    # local cmd=''
    [ "$user" = 'root' ] && cmd='sudo '     # needs `g ALL=(ALL) NOPASSWD: ALL` in /etc/sudoers.d

    $cmd kill -KILL ${pid}

    [[ ! "$?" -eq 0 ]] && echo 'Failed'
}

# find- () {}
# rg- () {rg $* 2>/dev/null}
# ps- () {ps aux | rg $1}

# add to command history for completion
print -s "sed -i -e 's///g' *.x"
print -s "echo $PATH | tr ':' '\n'"

#compdef _sed_comp sed
#function _sed_comp {
#	_values 'sed' "sed -i -e 's/A/B/'"
#}

h() {
    local cmd=''

    if [ "$#" -eq 0 ]; then
        cmd=$(echo $PATH | tr ':' '\n' | xargs -I {} find {} -maxdepth 1 -type f -executable 2>/dev/null | xargs -n 1 basename | fzf);
    elif [ "$#" -eq 1 ]; then
        cmd=$1
    else
        echo 'Usage: h               shows help for which command chosen via fzf'
        echo '       h <command>     shows help for <command>'
        return 1
    fi

    local content=$($cmd --help 1)
#   if [ "$?" != 0 ]; then
    if [ "$?" != "$?" ]; then       # temporarily ignore result (workaround)
        echo "No help for `$cmd`"
    else
        echo $content | less
    fi
}

_m() {
	local cmd=''
	local sec=''

	if [ "$#" -eq 0 ]; then
		cmd=$(echo $PATH | tr ':' '\n' | xargs -I {} find {} -maxdepth 1 -type f -executable 2>/dev/null | xargs -n 1 basename | fzf)
		echo $cmd
	elif [[ "$#" -eq 1 ]] && ! [[ "$1" =~ '^[0-9]+$' ]]; then
		echo !!!
		cmd=$1
	elif [[ "$#" -eq 2 ]] && [[ "$1" = '^[0-9]+$' ]] && ! [[ "$2" =~ '^[0-9]+$' ]]; then
		sec=$1
		cmd=$2
	else
		echo 'Usage: m                         shows manpage for which command choosen via fzf'
		echo '       m <command>               shows manpage for <command>'
		echo '       m <section> <command>     shows mappage for <command> in the <section>'
	fi

	echo $sec
	echo $cmd
#	man $sec $cmd 2>/dev/null
#	if [ "$?" != 0 ]; then
#		echo "No manpage for $cmd"
#	else
#		man $sec $cmd | bat
#	fi
}

####################################################
# keybindings
# ------------------------------
# check by 'bindkey | less'

# unbind shell keybindings
bindkey -r "^[T"        # alt-T: transpose-words
bindkey -r "^[t"        # alt-t: transpose-words
bindkey -r "^[h"		# alt-h: run-help

# new bind
bindkey "^[h" backward-kill-word

# ------------------------------
# hooks
# ------------------------------
autoload -Uz add-zsh-hook

# copy last command to clipboard
hook-fn-last-command () {
   echo -n $(fc -nl -1) | wl-copy 2>/dev/null
}
add-zsh-hook precmd hook-fn-last-command

# copy last output to clipboard
# This functionality is moved into `~/dotfiles/d/kitty/custom.conf` as below:
# ```
#   map kitty_mod+c launch --stdin-source=@last_cmd_output --type=clipboard
# ```


# ------------------------------
# fzf
# ------------------------------
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_COMPLETION_TRIGGER=',,'	# ,,<TAB>でfzfに入る
FZF_THEME_DRACURA_MOD='--color=dark,fg:-1,bg:-1,hl:#ff87d7,fg+:#d6ffe0,bg+:-1,hl+:#5fff87,info:#af87ff,prompt:#ff87d7,pointer:#5fff87,marker:#ff87d7,spinner:#ff87d7 '
export FZF_DEFAULT_OPTS=$FZF_THEME_DRACURA_MOD'--height 40% --reverse --header-lines=0 --border=none --no-separator --no-info --no-scrollbar'
#export FZF_CTRL_T_OPTS='--height 100% --preview="[[ $(file --mime {}) =~ binary ]] && \
#                 echo {} is a binary file || \
#                 (highlight -O ansi -l {} || \
#                 cat {}) 2> /dev/null | head -100"'
#export FZF_CTRL_T_OPTS='--bind ctrl-p:preview-up,ctrl-n:preview-down --preview "bat --theme zenburn --color=always --style=grid --line-range :100 {}"'
#export FZF_CTRL_T_OPTS='--bind ctrl-p:preview-up,ctrl-n:preview-down --preview "[[ -f {} ]] && file --mime-type -b {} | grep -q image && viu -w 50 -h 20 {} || bat --theme zenburn --color=always --style=grid --line-range :100 {}" --preview-window=right:60%:wrap'
#export FZF_CTRL_T_OPTS='--bind ctrl-p:preview-up,ctrl-n:preview-down --preview "[[ -f {} ]] && file --mime-type -b {} | grep -q image && catimg -r2 -w$COLUMNS {} || bat --theme zenburn --color=always --style=grid --line-range :100 {}" --preview-window=right:60%:wrap'
export FZF_CTRL_T_OPTS='--bind ctrl-p:preview-up,ctrl-n:preview-down --preview="pistol {}" || bat --theme zenburn --color=always --style=grid --line-range :100 {}" --preview-window=right:60%:wrap'


export FZF_CTRL_R_OPTS='--with-nth=2..'
#export FZF_ALT_C_OPTS="--preview 'tree -CFA {} | head -200'"
export FZF_ALT_C_OPTS="--bind ctrl-p:preview-up,ctrl-n:preview-down --preview 'eza -T {} | head -100'"

if type rg &> /dev/null; then
	export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    #export FZF_DEFAULT_COMMAND='rg --files --hidden'
fi

# git log をfzfに渡してshaを入力 (ALT-g)
# https://zenn.dev/miyanokomiya/articles/5931a3af9a710d
select_commit_from_git_log() {
  git log -n1000 --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |\
    fzf -m --ansi --no-sort --reverse --tiebreak=index --preview 'f() {
      set -- $(echo "$@" | grep -o "[a-f0-9]\{7\}" | head -1);
      if [ $1 ]; then
        git show --color $1
      else
        echo "blank"
      fi
    }; f {}' |\
    grep -o "[a-f0-9]\{7\}" |
    tr '\n' ' '
}
function insert_selected_git_logs(){
    LBUFFER+=$(select_commit_from_git_log)
    CURSOR=$#LBUFFER
    zle reset-prompt
}
zle -N insert_selected_git_logs
bindkey "^[g" insert_selected_git_logs

# rgf: rip-grep all with fzf
function rgf {
  command rg --color=always --line-number --no-heading --smart-case "${*:-}" \
  | command fzf -d':' --ansi \
    --preview "command bat -p --color=always {1} --highlight-line {2}" \
    --preview-window ~8,+{2}-5 \
  | awk -F':' '{print $1}'
}

# https://riq0h.jp/2023/11/26/204717/
fv() {
  IFS=$'\n' files=($(fzf --height 50% --preview 'bat  --color=always --style=plain {}' --preview-window=border-sharp,right:60% --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
  zsh
}

#export MANPAGER="sh -c 'col -bx | bat -l man -p --paging always'"

# docker completion
# if [ -e ~/.zsh/completions ]; then
#   fpath=(~/.zsh/completions $fpath)
# fi

# alias dps='docker ps --format "{{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Command}}\t{{.RunningFor}}"'
# alias dc='docker exec -it `dps | fzf | cut -f 1` /bin/bash'


# fzf my keybindings
#   tab:		accept
#   ctrl-space:	toggle+down
#   ctrl-p:	preview-up
#   ctrl-n:	preview-down
FZF_MY_MOVE_KEYS=' --bind=tab:accept,ctrl-space:toggle+down,ctrl-p:preview-up,ctrl-n:preview-down'
FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS$FZF_MY_MOVE_KEYS

# ------------------------------
# various commands, apps, sdk and/or programs
# ------------------------------

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
#mac_intel)

mac_arm)
	test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
	;;

*)
    ;;
esac

# yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# ------------------------------
# dev-env
# ------------------------------
# qmk_firmware
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
#eval "$(gh completion -s zsh)"

# ------------------------------
# dropbox
# ------------------------------
source ~/Dropbox/sec/apik

# ------------------------------
# deepl
# ------------------------------
translate() {
    if [ $# -lt 1 ]; then
        echo -n '>'
        read text
    else
        text="$@"
    fi

    deepl-linux -t ja -i $text
}


# ------------------------------
# terminal width/height
# ------------------------------
#  trap 'eval $(LINES=""; stty size|if read r c
#      then for x in `seq $c`
#      do LINES="${LINES}-"
#      done
#      echo LINES="$LINES"
#      fi
#  )' SIGWINCH

export FZF_COLUMNS=$COLUMNS
export FZF_LINES=$LINES
# export FZF_PREVIEW_COLUMNS=$COLUMNS
# export FZF_PREVIEW_LINES=$LINES

# ------------------------------
# in tray yet
