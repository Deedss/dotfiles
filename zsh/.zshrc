#########################################################################
# Variables & Cache
#########################################################################
ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
ZSH_PLUGIN_DIR="${ZDOTDIR:-$HOME}/.zsh/plugins"
ZSH_COMPLETIONS_CACHE="$ZSH_CACHE_DIR/completions"

mkdir -p "$ZSH_CACHE_DIR"
mkdir -p "$ZSH_PLUGIN_DIR"
mkdir -p "$ZSH_COMPLETIONS_CACHE"

#########################################################################
# Plugin registry + minimal loader
#########################################################################
typeset -gA ZSH_PLUGINS=(
  [romkatv/zsh-defer]=zsh-defer.plugin.zsh
  [zsh-users/zsh-completions]=""
  [Aloxaf/fzf-tab]=fzf-tab.plugin.zsh
  [zsh-users/zsh-autosuggestions]=zsh-autosuggestions.zsh
  [zsh-users/zsh-syntax-highlighting]=zsh-syntax-highlighting.zsh
)

# Clone a plugin if needed and print its local directory.
zsh-plugin-clone() {
  local repo=$1
  local dir="$ZSH_PLUGIN_DIR/${repo##*/}"
  if [[ ! -d "$dir/.git" ]]; then
    git clone --quiet --depth 1 "https://github.com/$repo" "$dir"
  fi
  print -r -- "$dir"
}

# Clone (if needed) + source a plugin's entry file.
zsh-plugin-load() {
  local repo=$1
  local file=${ZSH_PLUGINS[$repo]}
  local dir
  dir=$(zsh-plugin-clone "$repo") || return 1
  if [[ -n "$file" ]]; then
    [[ -f "$dir/$file" ]] || {
      print -u2 "zsh-plugin-load: missing entry file: $repo/$file"
      return 1
    }
    source "$dir/$file"
  fi
}

# Update every registered plugin that is already cloned.
zsh-plugin-update() {
  local repo dir
  for repo in "${(@k)ZSH_PLUGINS}"; do
    dir="$ZSH_PLUGIN_DIR/${repo##*/}"
    if [[ -d "$dir/.git" ]]; then
      print -P "%F{cyan}==>%f updating $repo"
      git -C "$dir" pull --quiet --ff-only
    fi
  done
}

alias zpupdate='zsh-plugin-update'

zsh-plugin-load romkatv/zsh-defer

#########################################################################
# Command availability
#########################################################################
zsh-has-command() {
  command -v "$1" >/dev/null 2>&1
}

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
setopt hist_find_no_dups        # don't show same result twice in reverse search

#########################################################################
# fpath additions — MUST happen before compinit
#########################################################################
fpath=("$(zsh-plugin-clone zsh-users/zsh-completions)/src" "${fpath[@]}")

if zsh-has-command rustup; then
  [[ -f "$ZSH_COMPLETIONS_CACHE/_rustup" ]] || rustup completions zsh > "$ZSH_COMPLETIONS_CACHE/_rustup"
  [[ -f "$ZSH_COMPLETIONS_CACHE/_cargo" ]] || rustup completions zsh cargo > "$ZSH_COMPLETIONS_CACHE/_cargo"
fi

if zsh-has-command uv; then
  [[ -f "$ZSH_COMPLETIONS_CACHE/_uv" ]] || uv generate-shell-completion zsh > "$ZSH_COMPLETIONS_CACHE/_uv"
fi

if zsh-has-command uvx; then
  [[ -f "$ZSH_COMPLETIONS_CACHE/_uvx" ]] || uvx --generate-shell-completion zsh > "$ZSH_COMPLETIONS_CACHE/_uvx"
fi

fpath=("$ZSH_COMPLETIONS_CACHE" "${fpath[@]}")

#########################################################################
# Completion System
#########################################################################
unsetopt menu_complete          # don't auto-select matches (fzf-tab needs this)

zstyle ":completion:*" use-compctl false
zstyle ":completion:*" group-name ""
zstyle ":completion:*" verbose true
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no        # let fzf-tab capture completions early

autoload -Uz compinit
compinit -d "$ZSH_CACHE_DIR/zcompdump"

#########################################################################
# fzf-tab — must load AFTER compinit
#########################################################################
zsh-plugin-load Aloxaf/fzf-tab
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:complete:cd:*' command 'ls -la --color=always'

#########################################################################
# Key Bindings
#########################################################################
setopt emacs                   # use emacs keybindings
bindkey ' ' magic-space        # space does not trigger history expansion
bindkey '^[[3~' delete-char

bindkey '^[[1;5C' emacs-forward-word
bindkey '^[[1;5D' emacs-backward-word

#########################################################################
# Custom Scripting
#########################################################################
[[ -f ~/.local/bin/mise ]] && eval "$(~/.local/bin/mise activate zsh)"
source ~/.scripts/sources

# Integrations
zsh-has-command fzf && source <(fzf --zsh)
zsh-has-command zoxide && eval "$(zoxide init zsh)"
zsh-has-command starship && eval "$(starship init zsh)"

#########################################################################
# deferred so it doesn't block prompt startup
#########################################################################
zsh-defer zsh-plugin-load zsh-users/zsh-autosuggestions
zsh-defer zsh-plugin-load zsh-users/zsh-syntax-highlighting