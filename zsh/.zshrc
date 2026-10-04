#########################################################################
# Variables & Cache
#########################################################################
ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
ZSH_COMPLETIONS_CACHE="$ZSH_CACHE_DIR/completions"
ZSH_PLUGIN_DIR="${ZDOTDIR:-$HOME}/.zsh/plugins"

mkdir -p "$ZSH_COMPLETIONS_CACHE"

#########################################################################
# Plugin registry
#########################################################################
typeset -gA ZSH_PLUGINS=(
  [romkatv/zsh-defer]=zsh-defer.plugin.zsh
  [zsh-users/zsh-completions]=""
  [Aloxaf/fzf-tab]=fzf-tab.plugin.zsh
  [zsh-users/zsh-autosuggestions]=zsh-autosuggestions.zsh
  [zsh-users/zsh-syntax-highlighting]=zsh-syntax-highlighting.zsh
)

#########################################################################
# Plugin management
#########################################################################
zsh-plugin-install() {
  local repo=$1
  local dir="$ZSH_PLUGIN_DIR/${repo##*/}"
  git clone --quiet --depth 1 "https://github.com/$repo" "$dir"
}

zsh-plugin-load() {
  local repo=$1
  local file=${ZSH_PLUGINS[$repo]}
  local dir="$ZSH_PLUGIN_DIR/${repo##*/}"
  [[ -n "$file" && -f "$dir/$file" ]] && source "$dir/$file"
}

zsh-plugin-update() {
  local repo dir
  for repo in "${(@k)ZSH_PLUGINS}"; do
    dir="$ZSH_PLUGIN_DIR/${repo##*/}"
    [[ -d "$dir/.git" ]] || continue
    print -P "%F{cyan}==>%f updating $repo"
    git -C "$dir" pull --quiet --ff-only
  done
}

zpbootstrap() {
  local repo dir
  mkdir -p "$ZSH_PLUGIN_DIR"
  for repo in "${(@k)ZSH_PLUGINS}"; do
    dir="$ZSH_PLUGIN_DIR/${repo##*/}"
    [[ -d "$dir" ]] || zsh-plugin-install "$repo"
  done
}

[[ -d "$ZSH_PLUGIN_DIR" ]] || zpbootstrap

zsh-plugin-load romkatv/zsh-defer

#########################################################################
# General Settings
#########################################################################
autoload -U colors && colors

setopt auto_cd extended_glob glob_dots prompt_subst
unsetopt rm_star_silent beep

setopt emacs

bindkey ' ' magic-space
bindkey '^[[3~' delete-char
bindkey '^[[1;5C' emacs-forward-word
bindkey '^[[1;5D' emacs-backward-word

#########################################################################
# History
#########################################################################
HISTSIZE=50000
SAVEHIST=$HISTSIZE
HISTFILE=~/.zsh_history

setopt append_history
setopt inc_append_history
unsetopt share_history
setopt hist_fcntl_lock

setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_expire_dups_first

setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_verify
setopt hist_find_no_dups

#########################################################################
# Custom Tooling
#########################################################################
[[ -f ~/.local/bin/mise ]] && eval "$(~/.local/bin/mise activate zsh)"
[[ -f ~/.scripts/sources ]] && source ~/.scripts/sources

(( $+commands[fzf] )) && source <(fzf --zsh)
(( $+commands[zoxide] )) && eval "$(zoxide init zsh)"
(( $+commands[starship] )) && eval "$(starship init zsh)"

#########################################################################
# Completions
#########################################################################
if (( $+commands[rustup] )); then
  [[ -f "$ZSH_COMPLETIONS_CACHE/_rustup" ]] || rustup completions zsh > "$ZSH_COMPLETIONS_CACHE/_rustup"
  [[ -f "$ZSH_COMPLETIONS_CACHE/_cargo" ]] || rustup completions zsh cargo > "$ZSH_COMPLETIONS_CACHE/_cargo"
fi

if (( $+commands[uv] && $+commands[uvx] )); then
  [[ -f "$ZSH_COMPLETIONS_CACHE/_uv" ]] || uv generate-shell-completion zsh > "$ZSH_COMPLETIONS_CACHE/_uv"
  [[ -f "$ZSH_COMPLETIONS_CACHE/_uvx" ]] || uvx --generate-shell-completion zsh > "$ZSH_COMPLETIONS_CACHE/_uvx"
fi

fpath=(
  "$ZSH_PLUGIN_DIR/zsh-completions/src"
  "$ZSH_COMPLETIONS_CACHE"
  "${fpath[@]}"
)

#########################################################################
# Completion System
#########################################################################
unsetopt menu_complete

zstyle ':completion:*' use-compctl false
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose true
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no

autoload -Uz compinit
compinit -d "$ZSH_CACHE_DIR/zcompdump"

#########################################################################
# fzf-tab
#########################################################################
zsh-plugin-load Aloxaf/fzf-tab

zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:complete:cd:*' command 'ls -la --color=always'

#########################################################################
# Deferred Plugins
#########################################################################
zsh-defer zsh-plugin-load zsh-users/zsh-autosuggestions
zsh-defer zsh-plugin-load zsh-users/zsh-syntax-highlighting