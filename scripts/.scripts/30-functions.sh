# shellcheck shell=bash

###############################################
# Utilities 
###############################################
up() {
    local n=${1:-1} d=
    [ "$n" -ge 1 ] 2>/dev/null || { echo "up: expecting a positive integer" >&2; return 1; }
    while [ "$n" -gt 0 ]; do d=../$d; n=$((n - 1)); done
    cd -- "$d" || return
}

set-gtk-theme() {
  dbus-send --session --dest=org.kde.GtkConfig --type=method_call /GtkConfig org.kde.GtkConfig.setGtkTheme 'string:Arc-Dark'
}

backup-files() {
  cd ~ || exit
  tar -cvf backup.tar.gz \
    ~/.config/BraveSoftware \
    ~/.dotfiles \
    ~/Private \
    ~/Work \
    ~/Projects \
    ~/.ssh \
    ~/.gitconfig
}

path_add() {
    case ":${PATH}:" in
    *:"$1":*) ;;
    *)
        if [ "$2" = "after" ]; then
            PATH=$PATH:$1
        else
            PATH=$1:$PATH
        fi
        ;;
    esac
}

update() {
  echo '-------- UPDATE ---------'
  sudo dnf update --refresh
  echo ''

  echo '-------- FLATPAK --------'
  flatpak update --assumeyes
  echo ''

  __update-dev-tools
  __update-neovim
  __update-kitty
}

__update-dev-tools() {
  echo '------ DEV TOOLING ------'
  rustup update
  echo ''
}

__update-neovim() {
  echo '--------- NEOVIM --------'
  local_nvim_version=$(nvim --version | head -n1 | sed 's/^NVIM //')
  latest_nvim_version=$(curl -L https://api.github.com/repos/neovim/neovim/releases/latest 2>/dev/null | jq --raw-output '.tag_name')
  if [[ "$local_nvim_version" != "$latest_nvim_version" ]]; then
    sudo curl --location https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage --output /usr/local/bin/nvim
    sudo chmod 755 /usr/local/bin/nvim
  else
    echo 'Already up to date'
  fi
  echo ''
}

__update-kitty() {
  echo '---------- KITTY --------'
  local_kitty_version=$(kitty --version | awk '{print $2}')
  latest_kitty_version=$(curl -sL https://api.github.com/repos/kovidgoyal/kitty/releases/latest | jq -r '.tag_name' | sed 's/^v//')
  if [[ "$local_kitty_version" != "$latest_kitty_version" ]]; then
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin launch=n
  else
    echo 'Already up to date'
  fi
  echo ''
}

###############################################
# Fuzzy Find
###############################################
fkill() {
  local pid
  pid=$(ps -eo pid,user,%cpu,%mem,command --sort=-%cpu \
        | fzf --header-lines=1 --reverse --no-sort \
        | awk '{print $1}')

  if [[ -n "$pid" ]]; then
    printf "%s\n" "$pid" | xargs kill -"${1:-9}"
  fi
}

###############################################
# Podman / Docker
###############################################
function prm() {
  podman ps -a | sed 1d | fzf -q "$1" --no-sort -m --tac | awk '{ print $1 }' | xargs -r podman rm
}

function prmi() {
  podman images | sed 1d | fzf -q "$1" --no-sort -m --tac | awk '{ print $3 }' | xargs -r podman rmi -f 
}
