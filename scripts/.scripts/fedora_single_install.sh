#!/bin/sh
# This file contains most things that I run while installing the main fedora-kde
# install
###############################################################################
###  INSTALL PACKAGES                                                       ###
###############################################################################
echo "Perform initial cleanup of Fedora KDE"
sudo dnf autoremove -y \
    \*akonadi* \
    dnfdragora \
    kwrite \
    kmag \
    kmouth \
    kmousetool \
    kget \
    kruler \
    kcolorchooser \
    gnome-disk-utility \
    ibus-libpinyin \
    ibus-libzhuyin \
    ibus-cangjie-* \
    ibus-hangul \
    kcharselect \
    kde-spectacle \
    firefox \
    plasma-browser-integration \
    plasma-discover \
    plasma-drkonqi

### Packages on kde spin =>> not on minimal install
sudo dnf autoremove -y \
    elisa-player \
    dragon \
    mediawriter \
    kmahjongg \
    kmines \
    kpat \
    ksudoku \
    kamoso \
    krdc \
    libreoffice-* \
    kdeconnectd \
    krfb \
    kolourpaint-* \
    konversation

### Install packages that are kde specific
sudo dnf install -y \
    ark

#### SETUP DNF ####
echo "fastestmirror=1" | sudo tee -a /etc/dnf/dnf.conf
echo "defaultyes=1" | sudo tee -a /etc/dnf/dnf.conf
echo "deltarpm=0" | sudo tee -a /etc/dnf/dnf.conf
echo "max_parallel_downloads=20" | sudo tee -a /etc/dnf/dnf.conf

#### RPMFUSION #####
echo "Add RPM Fusion to repositories"
sudo dnf install -y \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm


#### FLATPAK ####
echo "Add flathub repository"
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak remote-modify flathub --enable
sudo flatpak remote-delete fedora

#### MAIN PACKAGES ####
echo "Install a selection of used applications"
###### CMAKE / CLANG #########
sudo dnf install -y cmake ninja-build clang llvm clang-tools-extra

###### VIRTUALIZATION ########
sudo dnf install -y virt-manager
sudo usermod -aG kvm,libvirt,lp,dialout $USER

###### NETWORKING ######
sudo dnf install -y wireshark nmap curl wget

##### VIDEO DRIVERS ######
sudo dnf install -y mesa-vulkan-drivers mesa-vdpau-drivers mesa-libGLw mesa-libEGL \
    mesa-libGL mesa-libGLU mesa-libOpenCL libva libva-vdpau-driver libva-utils \
    libvdpau-va-gl gstreamer1-vaapi mesa-libGL-devel libglvnd-devel

##### OTHER PACKAGES ######
sudo dnf install -y openssl zstd ncurses git power-profiles-daemon jetbrains-mono-fonts \
    ncurses-libs stow google-roboto-fonts zsh util-linux-user redhat-lsb-core neovim \
    starship

#### KDE THEMES ####
echo "Install arc theme"
sudo dnf -y install arc-theme arc-kde

##### BRAVE BROWSER
echo "Install brave browser"
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sudo dnf -y install brave-browser

##### VSCODE 
echo "Install Visual Studio Code"
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf -y install code

###### PODMAN
echo "Install podman and buildah"
sudo dnf install -y podman podman-compose podman-docker buildah
####### START PODMAN ROOTLESS
systemctl --user enable podman.socket
systemctl --user start podman.socket
systemctl --user status podman.socket
export DOCKER_HOST=unix:///run/user/$UID/podman/podman.sock

###### OH-MY-ZSH
echo "Install OH-MY-ZSH"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

###### RUST INSTALL
echo "Install rust and rust-analyzer"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
mkdir -p $HOME/.local/bin
curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86-64-unknown-linux-gnu.gz | gunzip -c - > ~/.local/bin/rust-analyzer
chmod +x ~/.local/bin/rust-analyzer
source $HOME/.cargo/env
rustup component add rust-src

###### PYTHON
echo "Install Python-Devel"
sudo dnf -y install python3-devel python3-wheel python3-virtualenv

echo "Install Poetry"
curl -sSL https://install.python-poetry.org | python -

echo "installing language servers"
pip install python-lsp-server cmake-language-server

###### ESP-IDF Framework
echo "Install ESP-IDF"
sudo dnf install -y git wget flex bison gperf python3 python3-pip python3-setuptools cmake ninja-build ccache dfu-util libusbx
mkdir -p ~/Software
cd ~/Software
git clone --recursive https://github.com/espressif/esp-idf.git
cd esp-idf
sh install.sh


###### Emscripten Framework
echo "Install Emscripten WebAssembly"
mkdir -p ~/Software
cd ~/Software
# Get the emsdk repo
git clone https://github.com/emscripten-core/emsdk.git
# Enter that directory
cd emsdk
# Fetch the latest version of the emsdk (not needed the first time you clone)
git pull
# Download and install the latest SDK tools.
./emsdk install latest
# Make the "latest" SDK "active" for the current user. (writes .emscripten file)
./emsdk activate latest

##### FLATPAK PACKAGES
echo "Install flatpak applications"
flatpak install -y \
com.github.tchx84.Flatseal 

##### INTERNET #####
flatpak install -y \
com.discordapp.Discord \
org.gnome.Evolution \
org.mozilla.firefox \
org.libreoffice.LibreOffice \
org.signal.Signal \
org.qbittorrent.qBittorrent \
org.remmina.Remmina \
org.telegram.desktop

##### UTILITIES #####
flatpak install -y \
org.wezfurlong.wezterm

##### MUSIC & GRAPHICS #####
flatpak install -y \
com.spotify.Client \
com.obsproject.Studio \
com.jgraph.drawio.desktop \
org.blender.Blender \
org.videolan.VLC

##### THEMES ######
flatpak install -y \
org.kde.KStyle.Adwaita \
org.gtk.Gtk3theme.Arc-Dark \
org.gtk.Gtk3theme.Arc-Dark-solid
