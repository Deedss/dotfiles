#########################################################################
# Variables & Cache
#########################################################################
ZSH_PLUGIN_DIR="$HOME/.config/zsh/plugins"
ZSH_COMPLETION_DIR="$HOME/.config/zsh/completions"
ZDOTDIR="$HOME/.config/zsh"
export ANTIDOTE_HOME="$HOME/.config/zsh/antidote"

# Clone antidote if necessary.
if [[ ! -d $ANTIDOTE_HOME ]]; then
  git clone https://github.com/mattmc3/antidote $ANTIDOTE_HOME
fi

source $ANTIDOTE_HOME/antidote.zsh
antidote load 

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
# User specific aliases and functions
for f in "$HOME"/.scripts/*.sh; do
    [ -r "$f" ] && source "$f"
done

[[ -f ~/.local/bin/mise ]] && eval "$(~/.local/bin/mise activate zsh)"
(( $+commands[fzf] )) && source <(fzf --zsh)
(( $+commands[zoxide] )) && eval "$(zoxide init zsh)"
(( $+commands[starship] )) && eval "$(starship init zsh)"

#########################################################################
# Completions
#########################################################################
fpath=("$ZSH_COMPLETION_DIR" "${fpath[@]}")

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
zstyle ':completion:*' remove-all-dups yes
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

autoload -Uz compinit && compinit -d $HOME/.cache/zcompdump

#########################################################################
# fzf-tab
#########################################################################
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:complete:cd:*' command 'ls -la --color=always'
