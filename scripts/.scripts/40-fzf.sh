# shellcheck shell=bash

###############################################
# FZF Commands
###############################################
# Files (CTRL-T, default)
export FZF_DEFAULT_COMMAND="rg --files --no-ignore-vcs \
  --glob '!*/{.git,node_modules,.cov-idir,jacoco-files}/**'"

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Directories (ALT-C)
export FZF_ALT_C_COMMAND="fd --type d --no-ignore-vcs --strip-cwd-prefix \
  --exclude node_modules \
  --exclude .git \
  --exclude .cov-idir \
  --exclude jacoco-files"

###############################################
# FZF UI Defaults
###############################################
export FZF_DEFAULT_OPTS="\
--highlight-line \
--info=inline-right \
--layout=reverse \
--border=none"

# # # Catppuccin Macchiato Theme https://github.com/catppuccin/fzf/blob/main/themes/catppuccin-fzf-macchiato.sh
export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} \
  --color=bg+:#363A4F,bg:#24273A,spinner:#F4DBD6,hl:#ED8796 \
  --color=fg:#CAD3F5,header:#ED8796,info:#C6A0F6,pointer:#F4DBD6 \
  --color=marker:#B7BDF8,fg+:#CAD3F5,prompt:#C6A0F6,hl+:#ED8796 \
  --color=selected-bg:#494D64 \
  --color=border:#6E738D,label:#CAD3F5"

# CTRL-T (file picker)
export FZF_CTRL_T_OPTS="
  --preview='cat {}' \
  --bind shift-up:preview-page-up,shift-down:preview-page-down"

