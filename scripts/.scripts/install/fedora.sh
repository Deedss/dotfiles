#!/bin/bash
DIR=$(dirname ${BASH_SOURCE[0]:-$0})
source $DIR/tools.sh

###############################################################################
###  INSTALLATION KDE                                                       ###
###############################################################################
install-desktop() {
    echo "Perform Installation for Fedora"
    ### Set the correct DNF settings
    setup-dnf

    ### Generic Setup
    install-rpmfusion
    default-packages
    # install-iwd

    install-vscode
    install-neovim
    install-podman
    install-rust
    install-pythontools
    install-npm

    ### theme for kde
    if [[ "$XDG_CURRENT_DESKTOP" == "KDE" ]]; then
        install-arc-theme
    fi

    ### Fix default configs
    fix-config

    ##### FLATPAKS
    install-flatpak
}

###############################################################################
###  CLEAN UP KDE                                                           ###
###############################################################################
clean-desktop() {
    #### Clean up KDE packages on minimal install
    if [[ "$XDG_CURRENT_DESKTOP" == "KDE" ]]; then
        sudo dnf remove -y \
            \*akonadi* kwrite kdeconnectd krfb kcharselect \
            plasma-discover plasma-drkonqi plasma-welcome \
            kdeplasma-addons plasma-milou im-chooser \
            totem-pl-parser gnome-disk-utility adwaita-gtk2-theme \
            ibus-libpinyin ibus-hangul ibus-libzhuyin \
	    gnome-abrt vlc-plugin-* vlc-libs

    elif [[ "$XDG_CURRENT_DESKTOP" == "GNOME" ]]; then
        ### Clean up GNOME packages
        sudo dnf remove -y \
            gnome-tour gnome-boxes libreoffice-* \
            gnome-weather gnome-maps totem mediawriter \
            gnome-connections gnome-software firefox \
            gnome-calendar gnome-initial-setup gnome-contacts \
            gnome-classic-session

        ## Install for Gnome specific
        sudo dnf install -y \
            adwaita-gtk2-theme gnome-menus gnome-tweaks
    fi

    # Update GRUB timeout value
    sudo sed -i 's/GRUB_TIMEOUT=.*/GRUB_TIMEOUT=0/' /etc/default/grub
    sudo grub2-mkconfig -o /boot/grub2/grub.cfg

    sudo rm -rf /usr/share/akonadi
    rm -rf "$HOME/.config"
    rm -rf "$HOME/.local/share/akonadi*"
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
    sudo dnf install -y \
        "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
        "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"
}

###############################################################################
##### FLATPAKS                                                           ######
###############################################################################
install-flatpak() {
    sudo dnf install flatpak -y

    echo "Add flathub repository"
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    sudo flatpak remote-delete fedora
    sudo flatpak remote-modify flathub --enable

    echo "Install flatpak applications"
    ##### INTERNET #####
    flatpak install -y \
        com.discordapp.Discord \
        com.brave.Browser \
        org.mozilla.firefox \
        org.libreoffice.LibreOffice \
        org.signal.Signal \
        org.qbittorrent.qBittorrent \
        org.remmina.Remmina \
        com.valvesoftware.Steam \
        org.gnome.Evolution

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
    if [[ "$XDG_CURRENT_DESKTOP" == "KDE" ]]; then
        flatpak install -y \
            org.kde.okular \
            org.kde.gwenview \
            org.kde.kcalc \
            org.gtk.Gtk3theme.Arc-Dark \
            org.gtk.Gtk3theme.Arc-Dark-solid
    elif [[ "$XDG_CURRENT_DESKTOP" == "GNOME" ]]; then
        flatpak install -y \
            org.gtk.Gtk3theme.Adwaita-dark \
            org.gnome.Extensions
    fi
}

###############################################################################
###  INSTALL DEVELOPMENT TOOLS                                              ###
###############################################################################
default-packages() {
    echo "Install a selection of used applications"
    ###### CMAKE / CLANG #########
    sudo dnf install -y cmake ninja-build clang llvm clang-tools-extra

    ###### VIRTUALIZATION ########
    sudo dnf install -y virt-manager
    sudo usermod -aG kvm,libvirt,lp,dialout "$USER"

    ###### NETWORKING ######
    sudo dnf install -y wireshark nmap curl wget

    ##### VIDEO DRIVERS ######
    sudo dnf install -y mesa-vulkan-drivers mesa-va-drivers \
        mesa-vdpau-drivers mesa-libGLw mesa-libEGL libva-utils \
        mesa-libGL mesa-libGLU mesa-libOpenCL libva libva-vdpau-driver libva-utils \
        libvdpau-va-gl gstreamer1-vaapi mesa-libGL-devel libglvnd-devel

    ##### OTHER PACKAGES ######
    sudo dnf install -y openssl-devel zstd ncurses git ripgrep \
        ncurses-libs stow zsh util-linux-user \
        java-17-openjdk java-17-openjdk-devel \
        jetbrains-mono-fonts google-roboto-fonts \
        steam-devices wl-clipboard bat eza fzf zoxide


    ### Set default shell
    sudo chsh -s /bin/zsh $USER 
}

###############################################################################
##### ARC THEME                                                          ######
###############################################################################
install-arc-theme() {
    echo "Install arc theme"
    sudo dnf -y install arc-theme arc-kde
}

###############################################################################
##### VSCODE                                                            #######
###############################################################################
install-vscode() {
    echo "Install Visual Studio Code"
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
    sudo dnf -y install code
}
