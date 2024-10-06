#!/bin/bash
DIR=$(dirname ${BASH_SOURCE[0]:-$0})
source $DIR/tools.sh

###############################################################################
###  INSTALLATION KDE                                                       ###
###############################################################################
install-desktop() {
    echo "Perform Installation for Debian"

    # install-kde

    ### Generic Setup
    install-default-packages
    install-brave

    ## Dev tools
    install-vscode
    install-pythontools
    install-podman
    install-rust
    install-npm
    install-neovim
    install-fzf

    ## Theme
    install-arc-theme

    ### Fix config for UDEV and powersave
    fix-config

    ##### FLATPAKS
    install-flatpak
}

##############################################################################
#### KDE DESKTOP                                                        ######
##############################################################################
install-kde() {
    echo "Install kde desktop"
    sudo apt -y install plasma-desktop plasma-workspace plasma-nm \
        kdialog kfind kde-spectacle libpam-kwallet5 kde-config-flatpak \
        udisks2 upower kwin-x11 kwin-wayland sddm xserver-xorg \
        aria2 ark dolphin pipewire pipewire-audio pipewire-pulse wireplumber \
        pipewire-audio-client-libraries libspa-0.2-bluetooth libspa-0.2-jack jq \
        ripgrep wl-clipboard network-manager-config-connectivity-debian konsole

    sudo apt autoremove -y plasma-discover pulseaudio zutty kdeconnect

    # Update GRUB timeout value
    sudo sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/' /etc/default/grub
    # Regenerate GRUB configuration
    sudo update-grub
}

###############################################################################
##### FLATPAKS                                                           ######
###############################################################################
install-flatpak() {
    sudo apt install flatpak -y

    echo "Add flathub repository"
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    sudo flatpak remote-modify flathub --enable

    echo "Install flatpak applications"
    ##### INTERNET #####
    flatpak install -y \
        com.discordapp.Discord \
        org.libreoffice.LibreOffice \
        org.signal.Signal \
        org.qbittorrent.qBittorrent \
        org.remmina.Remmina \
        com.valvesoftware.Steam \
        io.podman_desktop.PodmanDesktop \
        org.gnome.Evolution

    ##### MUSIC & GRAPHICS #####
    flatpak install -y \
        com.spotify.Client \
        com.obsproject.Studio \
        com.jgraph.drawio.desktop \
        org.videolan.VLC

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
install-default-packages() {
    echo "Install a selection of used applications"
    ###### CMAKE / CLANG #########
    sudo apt install -y cmake ninja-build clang llvm clang-tools systemd-zram-generator

    ###### VIRTUALIZATION ########
    sudo apt install -y virt-manager
    sudo usermod -aG kvm,libvirt,lp,dialout $USER
    sudo apt autoremove -y virt-viewer

    ###### NETWORKING ######
    sudo apt install -y wireshark nmap curl wget

    ##### VIDEO DRIVERS ######
    sudo apt install -y mesa-vulkan-drivers mesa-vdpau-drivers mesa-va-drivers \
        libvdpau1 libvdpau-va-gl1 libva2 libva-x11-2 libva-wayland2 libva-drm2 \
        libva-glx2 gstreamer1.0-vaapi

    ##### OTHER PACKAGES ######
    sudo apt install -y openssl zstd git openjdk-17-jdk stow ripgrep \
        libncurses5 libncurses5-dev libncurses6 libncurses-dev steam-devices \
        fonts-roboto fonts-jetbrains-mono libssl-dev zsh

    sudo chsh -s /bin/zsh $USER
}

###############################################################################
##### BRAVE BROWSER                                                      ######
###############################################################################
install-arc-theme() {
    echo "Install arc theme"
    sudo apt -y install arc-theme
    wget -qO- https://raw.githubusercontent.com/PapirusDevelopmentTeam/arc-kde/master/install.sh | sh
    wget -qO- https://git.io/papirus-icon-theme-install | DESTDIR="$HOME/.local/share/icons" sh
}

###############################################################################
##### BRAVE BROWSER                                                      ######
###############################################################################
install-brave() {
    echo "Install brave browser"
    sudo apt -y install curl
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    sudo apt update
    sudo apt install -y brave-browser
}

###############################################################################
##### VSCODE                                                            #######
###############################################################################
install-vscode() {
    echo "Install Visual Studio Code"
    sudo apt -y install wget gpg
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
    sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    rm -f packages.microsoft.gpg
    sudo apt update
    sudo apt install -y code
}

install-wezterm() {
    curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
    echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
    sudo apt update
    sudo apt install -y wezterm
}

###############################################################################
###### EXTRA SETTINGS                                                   #######
###############################################################################
# VISUDO %users  ALL=(ALL) NOPASSWD: /sbin/poweroff, /sbin/reboot
# Defaults secure_path = /usr/local/sbin:/usr/local/bin:/usr/sbin:/sbin
# root ALL=(ALL) ALL
#
