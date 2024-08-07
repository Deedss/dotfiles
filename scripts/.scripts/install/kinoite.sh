#!/bin/bash
source tools.sh

###############################################################################
###  INSTALLATION KDE                                                       ###
###############################################################################
install-kde() {
    echo "Perform Installation for Fedora KDE"
    ### Clean up kde
    clean-kde

    ### Generic Setup
    install-rpmfusion
    install-layered-packages
    # install-oh-my-zsh

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
clean-kde() {
    rpm-ostree override remove \
        firefox firefox-langpacks \
        gwenview gwenview-libs okular kwrite kmag kmousetool \
        kde-connect kdeconnectd kde-connect-libs \
        plasma-discover plasma-discover-notifier plasma-discover-flatpak plasma-discover-rpm-ostree \
        plasma-welcome dolphin dolphin-libs dolphin-plugins ark ark-libs \
        kcharselect krfb krfb-libs kcalc
}

###############################################################################
##### SETUP DNF                                                         #######
###############################################################################
setup-dnf() {
    echo "fastestmirror=1" | sudo tee -a /etc/dnf/dnf.conf
    echo "defaultyes=1" | sudo tee -a /etc/dnf/dnf.conf
    echo "deltarpm=0" | sudo tee -a /etc/dnf/dnf.conf
    echo "max_parallel_downloads=20" | sudo tee -a /etc/dnf/dnf.conf
}

###############################################################################
###  ADD RPM FUSION / FLATPAK                                               ###
###############################################################################
install-rpmfusion() {
    echo "Add RPM Fusion to repositories"
    sudo rpm-ostree install \
        "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
        "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"
}

###############################################################################
##### FLATPAKS                                                           ######
###############################################################################
install-flatpak() {
    echo "Add flathub repository"
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    sudo flatpak remote-delete fedora
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
        org.telegram.desktop

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
install-layered-packages() {
    echo "Install layered packages"
    rpm-ostree install \
        stow distrobox openssl util-linux-user ripgrep redhat-lsb-core git zstd \
        podman-compose podman-docker ksshaskpass zsh arc-theme arc-kde
}

###############################################################################
##### VSCODE                                                            #######
###############################################################################
install-vscode() {
    echo "Install Visual Studio Code"
    vscode_repo="https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc"
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=$vscode_repo" > /etc/yum.repos.d/vscode.repo'
    rpm-ostree -y install code
}

###############################################################################
###### INSTALL IWD                                                      #######
###############################################################################
install-iwd() {
    rpm-ostree install iwd
    echo -e "[device]\nwifi.backend=iwd" | sudo tee /etc/NetworkManager/conf.d/10-iwd.conf
    sudo systemctl mask wpa_supplicant
}

###############################################################################
##### NEOVIM                                                            #######
###############################################################################
install-neovim() {
    cd ~/.local/bin || exit
    curl -L https://github.com/neovim/neovim/releases/latest/download/nvim.appimage -o nvim
    chmod u+x nvim
    cd ~ || exit
    echo ''
}
