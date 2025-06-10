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

## ZSH Options https://zsh.sourceforge.net/Doc/Release/Options.html

# Changing Directories https://zsh.sourceforge.net/Doc/Release/Options.html#Changing-Directories
setopt auto_cd                 # if a command isn't valid, but is a directory, cd to that dir
setopt auto_pushd              # make cd push the old directory onto the directory stack
setopt pushd_ignore_dups       # don’t push multiple copies of the same directory onto the directory stack
setopt pushd_minus             # exchanges the meanings of ‘+’ and ‘-’ when specifying a directory in the stack

# Completions https://zsh.sourceforge.net/Doc/Release/Options.html#Completion-2
setopt always_to_end           # move cursor to the end of a completed word
setopt auto_menu               # show completion menu on a successive tab press
setopt auto_param_slash        # if completed parameter is a directory, add a trailing slash
setopt complete_in_word        # complete from both ends of a word
unsetopt menu_complete         # don't autoselect the first completion entry

# Expansion and Globbing https://zsh.sourceforge.net/Doc/Release/Options.html#Expansion-and-Globbing
setopt extended_glob           # use more awesome globbing features
setopt glob_dots               # include dotfiles when globbing

# History https://zsh.sourceforge.net/Doc/Release/Options.html#History
setopt append_history          # append to history file
setopt extended_history        # write the history file in the ':start:elapsed;command' format
unsetopt hist_beep             # don't beep when attempting to access a missing history entry
setopt hist_expire_dups_first  # expire a duplicate event first when trimming history
setopt hist_find_no_dups       # don't display a previously found event
setopt hist_ignore_all_dups    # delete an old recorded event if a new event is a duplicate
setopt hist_ignore_dups        # don't record an event that was just recorded again
setopt hist_ignore_space       # don't record an event starting with a space
setopt hist_no_store           # don't store history commands
setopt hist_reduce_blanks      # remove superfluous blanks from each command line being added to the history list
setopt hist_save_no_dups       # don't write a duplicate event to the history file
setopt hist_verify             # don't execute immediately upon history expansion
setopt inc_append_history      # write to the history file immediately, not when the shell exits
setopt share_history         # don't share history between all sessions

# Input/Output https://zsh.sourceforge.net/Doc/Release/Options.html#Input_002fOutput
unsetopt clobber               # must use >| to truncate existing files
unsetopt correct               # don't try to correct the spelling of commands
unsetopt correct_all           # don't try to correct the spelling of all arguments in a line
unsetopt flow_control          # disable start/stop characters in shell editor
setopt interactive_comments    # enable comments in interactive shell
unsetopt mail_warning          # don't print a warning message if a mail file has been accessed
setopt path_dirs               # perform path search even on command names with slashes
setopt rc_quotes               # allow 'Henry''s Garage' instead of 'Henry'\''s Garage'
unsetopt rm_star_silent        # ask for confirmation for `rm *' or `rm path/*'

# Job Control https://zsh.sourceforge.net/Doc/Release/Options.html#Job-Control
setopt auto_resume            # attempt to resume existing job before creating a new process
unsetopt bg_nice              # don't run all background jobs at a lower priority
unsetopt check_jobs           # don't report on jobs when shell exit
unsetopt hup                  # don't kill jobs on shell exit
setopt long_list_jobs         # list jobs in the long format by default
setopt notify                 # report status of background jobs immediately

# Prompting https://zsh.sourceforge.net/Doc/Release/Options.html#Prompting
setopt prompt_subst           # expand parameters in prompt variables

# Zle https://zsh.sourceforge.net/Doc/Release/Options.html#Zle
unsetopt beep                 # be quiet!
setopt combining_chars        # combine zero-length punctuation characters (accents) with the base character
setopt emacs                  # use emacs keybindings in the shell

# Zstyles
zstyle ':completion:*' use-cache on                                               # Enable caching
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"               # Specify caching folder
zstyle ':completion:*:descriptions' format '[%d]'                                 # todo: describe action
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'                            # Completion styling
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}                             # activate color-completion(!)
zstyle ':completion:*' group-name ''                                              # group
zstyle ':completion:*' menu no                                                    # force zsh not to show completion menu
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'              # preview directory's content with ls when completing cd
# zstyle ':fzf-tab:complete:cd:*'                                                    # preview directory's content with ls when completing cd 
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
