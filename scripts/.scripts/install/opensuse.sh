#!/bin/bash
DIR=$(dirname ${BASH_SOURCE[0]:-$0})
source $DIR/tools.sh

###############################################################################
###  INSTALLATION KDE                                                       ###
###############################################################################
install-desktop() {
    echo "Perform Installation for OpenSuse"
    cleanup-packages

    ### Generic Setup
    install-zram
    install-default-packages

    install-vscode
    install-rust
    install-zed

    ## Theme
    install-arc-theme

    ### Fix config for UDEV and powersave
    fix-config

    ##### FLATPAKS
    install-flatpak
}

cleanup-packages() {
    sudo zypper remove -y \
        icewm chromium xscreensaver xscreensaver-data \
        plasma6-desktop-emojier 
}

###############################################################################
##### FLATPAKS                                                           ######
###############################################################################
install-flatpak() {
    sudo zypper install -y flatpak

    echo "Add flathub repository"
    sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
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
        io.podman_desktop.PodmanDesktop

    ##### MUSIC & GRAPHICS #####
    flatpak install -y \
        com.spotify.Client

    ##### KDE #####
    flatpak install -y \
        org.gtk.Gtk3theme.Arc-Dark \
        org.gtk.Gtk3theme.Arc-Dark-solid
}

###############################################################################
###  INSTALL DEVELOPMENT TOOLS                                              ###
###############################################################################
install-default-packages() {
    echo "Install a selection of used applications"
    ###### CMAKE / CLANG #########
    sudo zypper install -y cmake ninja clang llvm clang-tools

    ###### VIRTUALIZATION ########
    sudo zypper install -y virt-manager
    sudo usermod -aG kvm,libvirt,lp,dialout "$USER"

    ###### NETWORKING ######
    sudo zypper install -y wireshark nmap curl wget

    ##### VIDEO DRIVERS ######
    sudo zypper install -y intel-media-driver intel-vaapi-driver 

    ##### OTHER PACKAGES ######
    sudo zypper install -y flatpak openssl zstd ncurses-utils git \
        stow zsh util-linux java-25-openjdk java-25-openjdk-devel \
        jetbrains-mono-fonts google-roboto-fonts \
        steam-devices wl-clipboard nodejs \
        lsd bat zoxide fd procs ripgrep fzf neovim python313-neovim \
        starship kitty lua-language-server StyLua

    ###### PODMAN #######
    echo "Install podman and buildah"
    sudo zypper install -y podman podman-docker buildah distrobox python313-podman-compose
    sudo touch /etc/containers/nodocker
    systemctl --user enable --now podman.socket
    systemctl --user status podman.socket

    ###### PYTHON #######
    sudo zypper install -y python313-wheel python313-devel python313-pipx python313-virtualenv

    ### Set default shell
    sudo chsh -s /bin/zsh $USER
}

###############################################################################
##### ARC THEME                                                          ######
###############################################################################
install-arc-theme() {
    echo "Install arc theme"
    sudo zypper addrepo https://download.opensuse.org/repositories/home:kill_it/openSUSE_Tumbleweed/home:kill_it.repo
    sudo zypper refresh
    sudo zypper install -y arc-kde-decoration arc-kde-style gtk2-metatheme-arc gtk3-metatheme-arc gtk4-metatheme-arc

    # Set gtk theme
    dbus-send --session --dest=org.kde.GtkConfig --type=method_call /GtkConfig org.kde.GtkConfig.setGtkTheme 'string:Arc-Dark'

}

###############################################################################
##### VSCODE                                                            #######
###############################################################################
install-vscode() {
    echo "Install Visual Studio Code"
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc && \
    echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" \
    | sudo tee /etc/zypp/repos.d/vscode.repo > /dev/null

    sudo zypper install -y code
}

install-brave() {
    curl -fsS https://dl.brave.com/install.sh | sh
}

install-zram() {
    sudo zypper install -y zram-generator
    echo -e "[zram0]\nzram-size = min(ram, 8192)" | sudo ktee /etc/systemd/zram-generator.conf
    sudo systemctl daemon-reload
    sudo systemctl start systemd-zram-setup@zram0.service
}
