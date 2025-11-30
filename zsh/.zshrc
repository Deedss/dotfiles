# Setup cache directory
: ${__zsh_cache_dir:=${XDG_CACHE_HOME:-$HOME/.cache}/zsh}
[[ -d $__zsh_cache_dir ]] || mkdir -p $__zsh_cache_dir

# Clone antidote if necessary.
[[ -d $HOME/.antidote ]] || git clone https://github.com/mattmc3/antidote.git $HOME/.antidote
# Source/Load antidote
ANTIDOTE_HOME=$HOME/.antidote/plugins
source "$HOME/.antidote/antidote.zsh"
antidote load

source ~/.zsh/variables.zsh
source ~/.zsh/options.zsh
source ~/.zsh/completions.zsh
source ~/.zsh/keys.zsh

[[ ! -f ~/.scripts/sources ]] || source  ~/.scripts/sources

# Shell integrations
command -v fzf > /dev/null && source <(fzf --zsh)
command -v zoxide > /dev/null && eval "$(zoxide init zsh)"
command -v uv > /dev/null && eval "$(uv generate-shell-completion zsh)"
command -v uv > /dev/null && eval "$(uvx --generate-shell-completion zsh)"
eval "$(starship init zsh)"

# Load completions
autoload -Uz compinit
compinit