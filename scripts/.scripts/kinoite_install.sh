#!/bin/bash
SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
. "$SCRIPTPATH"/tools_install.sh

###############################################################################
###  INSTALLATION KDE                                                       ###
###############################################################################
function install-kde(){
    echo "Perform Installation for Fedora KDE"
    ### Clean up kde
    clean-kde

    ### Generic Setup
    install-rpmfusion
    install-layered-packages
    install-oh-my-zsh

    # install-espIdf
    # install-emscripten

    ##### FLATPAKS
    install-flatpak

    ### Network
    install-iwd
}


###############################################################################
###  CLEAN UP KDE                                                           ###
###############################################################################
function clean-kde(){
    rpm-ostree override remove \
        firefox firefox-langpacks \
        gwenview gwenview-libs okular kwrite kmag kmousetool \
        kde-connect kdeconnectd kde-connect-libs \
        plasma-discover plasma-discover-notifier plasma-discover-flatpak plasma-discover-rpm-ostree \
        plasma-welcome
}

###############################################################################
##### SETUP DNF                                                         #######
###############################################################################
function setup-dnf(){
    echo "fastestmirror=1" | sudo tee -a /etc/dnf/dnf.conf
    echo "defaultyes=1" | sudo tee -a /etc/dnf/dnf.conf
    echo "deltarpm=0" | sudo tee -a /etc/dnf/dnf.conf
    echo "max_parallel_downloads=20" | sudo tee -a /etc/dnf/dnf.conf
}

###############################################################################
###  ADD RPM FUSION / FLATPAK                                               ###
###############################################################################
function install-rpmfusion(){
    echo "Add RPM Fusion to repositories"
    sudo rpm-ostree install \
        "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
        "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"
}

###############################################################################
##### FLATPAKS                                                           ######
###############################################################################
function install-flatpak(){
    echo "Add flathub repository"
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    sudo flatpak remote-delete fedora
    sudo flatpak remote-modify flathub --enable

    echo "Install flatpak applications"
    flatpak install -y \
    com.github.tchx84.Flatseal

    ##### INTERNET #####
    flatpak install -y \
    com.brave.Browser \
    com.discordapp.Discord \
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
    org.freedesktop.Platform.ffmpeg-full

    ##### KDE #####
    flatpak install -y \
    org.wezfurlong.wezterm \
    org.kde.okular \
    org.kde.gwenview \
    org.kde.kcalc \
    org.gnome.Evolution \
    org.gtk.Gtk3theme.Arc-Dark \
    org.gtk.Gtk3theme.Arc-Dark-solid

}

###############################################################################
##### LAYERED PACKAGES                                                   ######
###############################################################################
function install-layered-packages(){
    echo "Install layered packages"
    rpm-ostree install neovim virt-manager stow distrobox \
        openssl util-linux-user ripgrep redhat-lsb-core git zstd \
        podman-compose podman-docker ksshaskpass wireshark \
        rsms-inter-fonts

    echo "Install arc theme"
    rpm-ostree install arc-theme arc-kde

    echo "Install Visual Studio Code"
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
    rpm-ostree -y install code
}

###############################################################################
###### OH-MY-ZSH                                                         ######
###############################################################################
function install-oh-my-zsh(){
    echo "Install OH-MY-ZSH"
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting
        git clone https://github.com/zsh-users/zsh-completions "${ZSH_CUSTOM:=~/.oh-my-zsh/custom}"/plugins/zsh-completions
        git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions
}

###############################################################################
###  INSTALL DEVELOPMENT TOOLS                                              ###
###############################################################################
function install-development-packages(){
    echo "Add RPM Fusion to repositories"
    sudo dnf install -y \
        "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
        "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"

    echo "Install a selection of development tools"
    ###### CMAKE / CLANG #########
    sudo dnf install -y cmake ninja-build clang llvm clang-tools-extra lldb rust-lldb meson

    ###### NETWORKING ######
    sudo dnf install -y nmap curl wget

    ##### OTHER PACKAGES ######
    sudo dnf install -y openssl zstd ncurses git ripgrep \
        ncurses-libs zsh util-linux-user redhat-lsb-core autojump-zsh \
        java-17-openjdk
}

###############################################################################
###### INSTALL IWD                                                      #######
###############################################################################
function install-iwd(){
    rpm-ostree install iwd
    echo -e "[device]\nwifi.backend=iwd" | sudo tee /etc/NetworkManager/conf.d/10-iwd.conf
    sudo systemctl mask wpa_supplicant
}