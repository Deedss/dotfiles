#########################################################################
# Variables & Cache
#########################################################################

# Create ZSH cache directory if it doesn't exist# Zsh cache directory
ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
[[ -d $ZSH_CACHE_DIR ]] || mkdir -p "$ZSH_CACHE_DIR"

#########################################################################
# Antidote Plugin Manager
#########################################################################

[[ -d $HOME/.antidote ]] || git clone https://github.com/mattmc3/antidote.git $HOME/.antidote

ANTIDOTE_HOME=$HOME/.antidote/plugins
source "$HOME/.antidote/antidote.zsh"
antidote load

#########################################################################
# General Settings
#########################################################################

autoload -U colors && colors

setopt auto_cd                 # auto cd to directory
setopt extended_glob           # advanced globbing features
setopt glob_dots               # include dotfiles in globs

unsetopt rm_star_silent        # ask confirmation for `rm *`
unsetopt beep                  # disable terminal bell

setopt prompt_subst            # enable parameter expansion in prompts

#########################################################################
# History (clean, consistent, no duplicates)
# Reference: https://zsh.sourceforge.net/Doc/Release/Options.html#History
#########################################################################

HISTSIZE=50000
SAVEHIST=$HISTSIZE
HISTFILE=~/.zsh_history

# History behavior
setopt append_history          # append to history file
setopt inc_append_history      # write immediately to history file
unsetopt share_history         # prevent race conditions & out-of-order history
setopt hist_fcntl_lock         # prevent race-conditions


# Duplicate handling
setopt hist_ignore_dups        # ignore consecutive duplicates
setopt hist_ignore_all_dups    # remove older duplicates anywhere
setopt hist_save_no_dups       # never save duplicates to file
setopt hist_expire_dups_first  # expire dupes first when trimming history

# Usability
setopt hist_ignore_space       # ignore commands starting with space
setopt hist_reduce_blanks      # clean up whitespace
setopt hist_verify             # show command before executing after history expansion
setopt hist_find_no_dups       # don’t show same result twice in reverse search

# Avoid: hist_no_store — causes missing history; intentionally not included

#########################################################################
# Colors
#########################################################################

#########################################################################
# Completion System
#########################################################################

unsetopt menu_complete         # don't auto-select matches (fzf needs this)

# Ensures new-style completion only.
zstyle ":completion:*" use-compctl false

# Groups results consistently
zstyle ":completion:*" group-name ""

# Enables extra helpful descriptions.
zstyle ":completion:*" verbose true

# Disable sorting in git checkout
zstyle ':completion:*:git-checkout:*' sort false

# Description formatting
zstyle ':completion:*:descriptions' format '[%d]'

# Enable colored completion lists
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Let fzf-tab capture completions early
zstyle ':completion:*' menu no

# fzf-tab config
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' switch-group '<' '>'

# Directory previews with ls
zstyle ':fzf-tab:complete:cd:*' command 'ls -la --color=always'

# Disable oh-my-zsh update prompt
zstyle ':omz:update' mode disabled

#########################################################################
# Key Bindings
#########################################################################

setopt emacs                   # use emacs keybindings
bindkey ' ' magic-space        # space does not trigger history expansion
bindkey '^[[3~' delete-char

# bindkey "^[[1;3C" forward-word
# bindkey "^[[1;3D" backward-word

#########################################################################
# Custom Scripting
#########################################################################

[[ -f ~/.scripts/sources ]] && source ~/.scripts/sources

# Integrations
command -v fzf     >/dev/null && source <(fzf --zsh)
command -v zoxide  >/dev/null && eval "$(zoxide init zsh)"
command -v uv      >/dev/null && eval "$(uv generate-shell-completion zsh)"
command -v uvx      >/dev/null && eval "$(uvx --generate-shell-completion=zsh)"
eval "$(starship init zsh)"

#########################################################################
# Initialize Completion
#########################################################################

autoload -Uz compinit
compinit
