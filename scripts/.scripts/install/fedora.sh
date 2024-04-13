#!/bin/bash
source tools.sh

###############################################################################
###  INSTALLATION KDE                                                       ###
###############################################################################
function install-desktop(){
    echo "Perform Installation for Fedora"
    ### Set the correct DNF settings
    setup-dnf

    ### Generic Setup
    install-rpmfusion
    default-packages
    install-vscode
    install-pythontools
    install-rust
    install-oh-my-zsh
    install-podman
    install-iwd
    install-neovim

    ### theme for kde
    # install-emscripten
    install-arc-theme

    ### Fix default configs
    fix-config

    ##### FLATPAKS
    install-flatpak
}

###############################################################################
###  INSTALL VIRTUAL MACHINE                                                ###
###############################################################################
function install-virtual-machine(){
    ### Set the correct DNF settings
    setup-dnf

    ### Generic Setup
    install-rpmfusion

    echo "Install a selection of used applications"
    ###### CMAKE / CLANG #########
    sudo dnf install -y cmake ninja-build clang llvm clang-tools-extra lldb

    ##### VIDEO DRIVERS ######
    sudo dnf install -y mesa-vulkan-drivers mesa-va-drivers \
        mesa-vdpau-drivers mesa-libGLw mesa-libEGL libva-utils \
        mesa-libGL mesa-libGLU mesa-libOpenCL libva libva-vdpau-driver libva-utils \
        libvdpau-va-gl gstreamer1-vaapi mesa-libGL-devel libglvnd-devel

    ##### OTHER PACKAGES ######
    sudo dnf install -y openssl zstd ncurses git ripgrep \
        ncurses-libs stow zsh util-linux-user redhat-lsb-core \
        java-17-openjdk java-17-openjdk-devel jetbrains-mono-fonts google-roboto-fonts \
        wl-clipboard

    install-vscode
    install-pythontools
    install-oh-my-zsh
    install-podman
    install-arc-theme

    sudo dnf install flatpak -y
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    sudo flatpak remote-delete fedora
    sudo flatpak remote-modify flathub --enable
    flatpak install -y com.brave.Browser 
}

###############################################################################
###  CLEAN UP KDE                                                           ###
###############################################################################
function clean-kde(){
    #### Clean up KDE packages
    sudo dnf autoremove -y \
        \*akonadi* dnfdragora kwrite kmag kmouth kmousetool \
        kget kruler kcolorchooser gnome-disk-utility ibus-libpinyin \
        ibus-libzhuyin ibus-cangjie-* ibus-hangul kcharselect \
        kde-spectacle firefox plasma-browser-integration \
        plasma-discover plasma-drkonqi okular gwenview kcalc \
        plasma-welcome

    ### Packages on kde spin =>> not on minimal install
    sudo dnf autoremove -y \
        elisa-player dragon mediawriter kmahjongg \
        kmines kpat ksudoku kamoso krdc libreoffice-* \
        kdeconnectd krfb kolourpaint-* konversation

    ### Excess gnome packages
    sudo dnf autoremove -y \
        gnome-keyring gnome-desktop3 gnome-desktop4 gnome-abrt

    sudo dnf install -y \
        ark dolphin 

    # Update GRUB timeout value
    sudo sed -i 's/GRUB_TIMEOUT=.*/GRUB_TIMEOUT=0/' /etc/default/grub
    sudo grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg

    sudo rm -rf /usr/share/akonadi
    rm -rf "$HOME/.config"
    rm -rf "$HOME/.local/share/akonadi*"
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
    sudo dnf install -y \
        "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
        "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"
}

###############################################################################
##### FLATPAKS                                                           ######
###############################################################################
function install-flatpak(){
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
    org.wezfurlong.wezterm \
    org.kde.okular \
    org.kde.gwenview \
    org.kde.kcalc \
    org.gtk.Gtk3theme.Arc-Dark \
    org.gtk.Gtk3theme.Arc-Dark-solid
}

###############################################################################
###  INSTALL DEVELOPMENT TOOLS                                              ###
###############################################################################
function default-packages(){
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
    sudo dnf install -y openssl zstd ncurses git ripgrep \
        ncurses-libs stow zsh util-linux-user \
        java-17-openjdk java-17-openjdk-devel jetbrains-mono-fonts google-roboto-fonts \
        steam-devices wl-clipboard
}

###############################################################################
##### ARC THEME                                                          ######
###############################################################################
function install-arc-theme(){
    echo "Install arc theme"
    sudo dnf -y install arc-theme arc-kde
}

###############################################################################
##### VSCODE                                                            #######
###############################################################################
function install-vscode(){
    echo "Install Visual Studio Code"
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
    sudo dnf -y install code
}
