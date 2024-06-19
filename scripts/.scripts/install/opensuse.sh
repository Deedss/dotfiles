#!/bin/bash
DIR=$(dirname ${BASH_SOURCE[0]:-$0})
source $DIR/tools.sh

###############################################################################
###  INSTALLATION KDE                                                       ###
###############################################################################
function install-desktop() {
  echo "Perform Installation for OpenSUSE"

  ### Generic Setup
  default-packages
  install-vscode
  install-pythontools
  install-rust
  install-oh-my-zsh
  install-podman
  install-neovim

  ### theme for kde
  install-arc-theme

  ### Fix default configs
  fix-config

  ##### FLATPAKS
  install-flatpak
}

###############################################################################
##### FLATPAKS                                                           ######
###############################################################################
function install-flatpak() {
  echo "Add flathub repository"
  sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  sudo flatpak remote-modify flathub --enable

  echo "Install flatpak applications"
  ##### INTERNET #####
  flatpak install -y \
    com.discordapp.Discord \
    com.brave.Browser \
    org.mozilla.Thunderbird \
    org.mozilla.firefox \
    org.libreoffice.LibreOffice \
    org.signal.Signal \
    org.qbittorrent.qBittorrent \
    org.remmina.Remmina \
    org.telegram.desktop \
    com.valvesoftware.Steam

  ##### MUSIC & GRAPHICS #####
  flatpak install -y \
    com.spotify.Client \
    com.obsproject.Studio \
    com.jgraph.drawio.desktop \
    org.blender.Blender \
    org.videolan.VLC \
    org.freedesktop.Platform.ffmpeg-full \
    io.podman_desktop.PodmanDesktop

  ##### KDE #####
  flatpak install -y \
    org.kde.okular \
    org.kde.gwenview \
    org.kde.kcalc \
    org.gtk.Gtk3theme.Arc-Dark \
    org.gtk.Gtk3theme.Arc-Dark-solid
}

###############################################################################
###  INSTALL DEVELOPMENT TOOLS                                              ###
###############################################################################
function default-packages() {
  echo "Install a selection of used applications"
  ###### CMAKE / CLANG #########
  sudo zypper install -y cmake ninja-build clang llvm clang-tools

  ###### VIRTUALIZATION ########
  sudo zypper install -y virt-manager
  sudo usermod -aG kvm,libvirt,lp,dialout "$USER"

  ###### NETWORKING ######
  sudo zypper install -y wireshark nmap curl wget

  ##### VIDEO DRIVERS ######
  sudo zypper install -y Mesa-libva Mesa-libRusticlOpenCL Mesa-libGL1 \
  libva-utils libva-wayland2 libva-vdpau-driver libva2 libva-glx2 \
  libglvnd-devel Mesa-libEGL-devel

  ##### OTHER PACKAGES ######
  sudo zypper install -y openssl zstd ncurses-devel git ripgrep \
    stow zsh util-linux java-21-openjdk java-21-openjdk-devel \
    jetbrains-mono-fonts google-roboto-fonts lsb-release \
    steam-devices wl-clipboard bat eza wezterm fzf fzf-zsh-integration
}

###############################################################################
##### ARC THEME                                                          ######
###############################################################################
function install-arc-theme() {
  echo "Install arc theme"
  sudo zypper addrepo https://download.opensuse.org/repositories/home:kill_it/openSUSE_Tumbleweed/home:kill_it.repo
  sudo zypper refresh
  sudo zypper -y install arc-kde-* arc arc-icon-theme
}

###############################################################################
##### VSCODE                                                            #######
###############################################################################
function install-vscode() {
  echo "Install Visual Studio Code"
  sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
  echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" |
    sudo tee /etc/zypp/repos.d/vscode.repo >/dev/null
  sudo zypper refresh
  sudo zypper -y install code
}