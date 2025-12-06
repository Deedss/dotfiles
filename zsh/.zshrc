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
# Catppuccin Macchiato Theme (for zsh-syntax-highlighting)
# Paste this files contents inside your ~/.zshrc before you activate zsh-syntax-highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main cursor)
typeset -gA ZSH_HIGHLIGHT_STYLES

# Main highlighter styling: https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md
#
## General
### Diffs
### Markup
## Classes
## Comments
ZSH_HIGHLIGHT_STYLES[comment]='fg=#5b6078'
## Constants
## Entitites
## Functions/methods
ZSH_HIGHLIGHT_STYLES[alias]='fg=#a6da95'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=#a6da95'
ZSH_HIGHLIGHT_STYLES[global-alias]='fg=#a6da95'
ZSH_HIGHLIGHT_STYLES[function]='fg=#a6da95'
ZSH_HIGHLIGHT_STYLES[command]='fg=#a6da95'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=#a6da95,italic'
ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=#f5a97f,italic'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#f5a97f'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#f5a97f'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=#c6a0f6'
## Keywords
## Built ins
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#a6da95'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#a6da95'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=#a6da95'
## Punctuation
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#ed8796'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=#cad3f5'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-unquoted]='fg=#cad3f5'
ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]='fg=#cad3f5'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]='fg=#ed8796'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=#ed8796'
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=#ed8796'
## Serializable / Configuration Languages
## Storage
## Strings
ZSH_HIGHLIGHT_STYLES[command-substitution-quoted]='fg=#eed49f'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-quoted]='fg=#eed49f'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#eed49f'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument-unclosed]='fg=#ee99a0'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#eed49f'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument-unclosed]='fg=#ee99a0'
ZSH_HIGHLIGHT_STYLES[rc-quote]='fg=#eed49f'
## Variables
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#cad3f5'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument-unclosed]='fg=#ee99a0'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=#cad3f5'
ZSH_HIGHLIGHT_STYLES[assign]='fg=#cad3f5'
ZSH_HIGHLIGHT_STYLES[named-fd]='fg=#cad3f5'
ZSH_HIGHLIGHT_STYLES[numeric-fd]='fg=#cad3f5'
## No category relevant in spec
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#ee99a0'
ZSH_HIGHLIGHT_STYLES[path]='fg=#cad3f5,underline'
ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=#ed8796,underline'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=#cad3f5,underline'
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]='fg=#ed8796,underline'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#cad3f5'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=#c6a0f6'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-unclosed]='fg=#ee99a0'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=#cad3f5'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=#cad3f5'
ZSH_HIGHLIGHT_STYLES[default]='fg=#cad3f5'
ZSH_HIGHLIGHT_STYLES[cursor]='fg=#cad3f5'

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
