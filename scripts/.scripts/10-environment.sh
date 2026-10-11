# shellcheck shell=bash

# Set up a few standard directories based on:
#   https://wiki.archlinux.org/title/XDG_Base_Directory
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"
export XDG_PROJECTS_DIR=${XDG_PROJECTS_DIR:-$HOME/Projects}

# EDITOR
export EDITOR="nvim"
export VISUAL="code --wait"

# Environment Variables
export LIBVIRT_DEFAULT_URI="qemu:///system"
export DOCKER_HOST=unix:///run/user/$UID/podman/podman.sock

# Android
export ANDROID_HOME="$HOME/Software/Android/Sdk"

# Go
export GOPATH="$HOME/Software/go"

# shellcheck disable=SC1091
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"