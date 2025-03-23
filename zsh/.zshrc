# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set Zsh options.
set extended_glob   # extend glob
setopt globdots     # hidden files

# Clone antidote if necessary.
[[ -d $HOME/.antidote ]] || git clone https://github.com/mattmc3/antidote.git $HOME/.antidote

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
setopt LIST_PACKED

zstyle ':completion:*' use-cache on                                               # Enable caching
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"               # Specify caching folder
zstyle ':completion:*:descriptions' format '[%d]'                                 # todo: describe action
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'                            # Completion styling
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}                             # activate color-completion(!)
zstyle ':completion:*' group-name ''                                              # group
zstyle ':completion:*' menu no                                                    # force zsh not to show completion menu
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'                # preview directory's content with ls when completing cd
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview 'git diff $word'  # todo: describe action
zstyle ':fzf-tab:complete:git-log:*' fzf-preview 'git log --color=always $word'   # todo: describe action
zstyle ':completion:*:git-checkout:*' sort false                                  # todo: describe action
zstyle ':fzf-tab:*' switch-group '<' '>'                                          # todo: describe action
zstyle ':completion:*' list-max-items 20                                          # todo: describe action

bindkey ' ' magic-space                               # [Space] - don't do history expansion
bindkey '^[[3~' delete-char

bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

# Source/Load antidote
ANTIDOTE_HOME=$HOME/.antidote/plugins
source "$HOME/.antidote/antidote.zsh"
antidote load

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[[ ! -f ~/.scripts/sources ]] || source  ~/.scripts/sources

# Shell integrations
command -v fzf > /dev/null && source <(fzf --zsh)
command -v zoxide > /dev/null && eval "$(zoxide init zsh)"
