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

    install-vscode
    install-pythontools
    install-podman
    install-rust
    install-npm
    install-zed

    ## Theme
    install-arc-theme

    ### Fix config for UDEV and powersave
    fix-config

    ##### FLATPAKS
    install-flatpak
}

###############################################################################
###  CLEAN UP KDE                                                           ###
###############################################################################
clean-desktop() {
    #### Clean up KDE packages on minimal install
    sudo dnf remove -y \
        \*akonadi* kwrite kdeconnectd krfb kcharselect \
        plasma-discover plasma-drkonqi plasma-welcome \
        kdeplasma-addons plasma-milou im-chooser \
        totem-pl-parser gnome-disk-utility adwaita-gtk2-theme \
        ibus-libpinyin ibus-hangul ibus-libzhuyin \
        gnome-abrt vlc-plugin-* vlc-libs firefox

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
        org.libreoffice.LibreOffice \
        org.signal.Signal \
        org.qbittorrent.qBittorrent \
        org.remmina.Remmina \
        com.valvesoftware.Steam \
        io.podman_desktop.PodmanDesktop \
        org.gnome.Evolution \
        com.brave.Browser

    ##### MUSIC & GRAPHICS #####
    flatpak install -y \
        com.spotify.Client \
        com.obsproject.Studio \
        com.jgraph.drawio.desktop \
        org.videolan.VLC \

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

install-brave() {
    ## Mesa fixes
    sudo dnf install --allowerasing mesa-va-drivers-freeworld mesa-vdpau-drivers-freeworld

    sudo dnf install dnf-plugins-core
    sudo dnf4 config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
    sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
    sudo dnf install brave-browser
}
