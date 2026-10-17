if ! (( $+functions[zsh-defer] )); then
  fpath+=( "$HOME/.config/zsh/antidote/github.com/romkatv/zsh-defer" )
  source "$HOME/.dotfiles/zsh/.config/zsh/antidote/github.com/romkatv/zsh-defer/zsh-defer.plugin.zsh"
fi
fpath+=( "$HOME/.config/zsh/antidote/github.com/Aloxaf/fzf-tab" )
zsh-defer source "$HOME/.dotfiles/zsh/.config/zsh/antidote/github.com/Aloxaf/fzf-tab/fzf-tab.plugin.zsh"
fpath+=( "$HOME/.config/zsh/antidote/github.com/zdharma-continuum/fast-syntax-highlighting" )
zsh-defer source "$HOME/.dotfiles/zsh/.config/zsh/antidote/github.com/zdharma-continuum/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
fpath+=( "$HOME/.config/zsh/antidote/github.com/zsh-users/zsh-autosuggestions" )
zsh-defer source "$HOME/.dotfiles/zsh/.config/zsh/antidote/github.com/zsh-users/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh"
fpath+=( "$HOME/.config/zsh/antidote/github.com/zsh-users/zsh-completions/src" )
