# Set up a few standard directories based on:
#   https://wiki.archlinux.org/title/XDG_Base_Directory
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

# Enable raw control characters (needed for colors)
export LESS='-R'

# TERMINCAP settings for colored output
export LESS_TERMCAP_mb=$'\e[1;31m'     # blinking (rarely used) -> red bold
export LESS_TERMCAP_md=$'\e[1;36m'     # bold text -> bright cyan
export LESS_TERMCAP_us=$'\e[4;32m'     # underlined text -> green underline
export LESS_TERMCAP_so=$'\e[1;44;33m'  # standout (info boxes) -> yellow on blue

# Reset sequences
export LESS_TERMCAP_me=$'\e[0m'        # end bold/blink
export LESS_TERMCAP_ue=$'\e[0m'        # end underline
export LESS_TERMCAP_se=$'\e[0m'        # end standout
