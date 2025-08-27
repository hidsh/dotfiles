# patch--filter-ctr-r--fzf-history-widget.zsh
#
# filter to hide relative paths while using `ctrl-r`
#
# note:
# - tested: zsh 5.9 (x86_64-pc-linux-gnu)
# - need the following lines in .zshrc
#   ```
#   eval "$(fzf --zsh)"
#   source ~/dotfiles/d/zsh/create-my-filter--fzf-history-widget.zsh \
#     || echo "[fzf-patch] warning: using unpatched fzf-history-widget"
#   ```

# Ensure original is defined
if ! (( $+functions[fzf-history-widget] )); then
  echo "[fzf-patch] Error: fzf-history-widget is not defined" >&2
  return 1
fi

# Extract function source
original=$(typeset -f fzf-history-widget)

# patch `fzf-history-widget` function
patched="${original//$'\n    }\' |'/$'\n    }\' |\n    grep -vE "^cd[[:space:]]+(\\.{1,2}(/|$)|\\.[^/~\$`(]|[^/~\$`(])" |'}"

# Check if patch succeeded
if [[ "$patched" == "$original" ]]; then
  echo "[fzf-patch] Error: Failed to apply patch to fzf-history-widget. Pattern not found." >&2
  return 1
fi

# Redefine function
eval "$patched"
