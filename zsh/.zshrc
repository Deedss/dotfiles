# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set Zsh options.
set extended_glob

# Setup vars similar to Oh My Zsh.
ZSH=${ZSH:-${ZDOTDIR:-$HOME/.config/zsh}}
ZSH_CUSTOM=${ZSH_CUSTOM:-$ZSH/custom}

# Clone antidote if necessary.
[[ -d ${ZSH:-~}/antidote ]] ||
  git clone https://github.com/mattmc3/antidote ${ZSH}/antidote

# Load completions
autoload -Uz compinit && compinit

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'eval "$(fzf --zsh)"
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Keybindings
# bindkey -v
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
# enables history substring search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Source/Load antidote
source "${ZSH}/antidote/antidote.zsh"
antidote load

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[[ ! -f ~/.scripts/sources ]] || source  ~/.scripts/sources

# Shell integrations
export NVM_DIR="$HOME/.nvm" && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
source <(fzf --zsh)
eval "$(zoxide init zsh)"
