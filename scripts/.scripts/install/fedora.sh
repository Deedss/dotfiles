#!/bin/bash
DIR=$(dirname ${BASH_SOURCE[0]:-$0})
source $DIR/common.sh

###############################################################################
###  INSTALLATION KDE                                                       ###
###############################################################################
install-desktop() {
    echo "Perform Installation for Fedora"
    ### Set the correct DNF settings
    setup-dnf

    ### Generic Setup
    install-rpmfusion
    install-default-packages
    install-brave

    install-vscode
    install-rust
    install-python-tools
    install-zed
    install-neovim
    install-cli-tools
    install-kitty

    ## Theme
    install-arc-theme

    ### Fix config for UDEV and powersave
    fix-config

    ##### FLATPAKS
    install-flatpak
}

clean-desktop() {
    #### Clean up KDE packages on minimal install
    sudo dnf remove -y \
        \*akonadi* kwrite kdeconnectd krfb kcharselect \
        plasma-discover plasma-drkonqi plasma-welcome \
        kdeplasma-addons plasma-milou im-chooser \
        totem-pl-parser gnome-disk-utility adwaita-gtk2-theme \
        ibus-libpinyin ibus-hangul ibus-libzhuyin \
        gnome-abrt vlc-plugin-* vlc-libs firefox \
        libreoffice-* kpat kmahjongg kmines \
        neochat krdc dragon krusader qrca kmouth ktorrent \
        kamoso k3b elisa-player digikam kolourpaint

    sudo dnf install -y flatpak

    sudo rm -rf /usr/share/akonadi
    rm -rf "$HOME/.config"
    rm -rf "$HOME/.local/share/akonadi*"
}


setup-dnf() {
    echo -e "defaultyes=1" | sudo tee -a /etc/dnf/dnf.conf
    echo -e "deltarpm=0" | sudo tee -a /etc/dnf/dnf.conf
    echo -e "max_parallel_downloads=20" | sudo tee -a /etc/dnf/dnf.conf
}

install-rpmfusion() {
    echo "Add RPM Fusion to repositories"
    sudo dnf install -y \
        "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
        "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"
}

install-flatpak() {
    sudo dnf install -y flatpak

    echo "Add flathub repository"
    sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
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
        io.podman_desktop.PodmanDesktop

    ##### MUSIC & GRAPHICS #####
    flatpak install -y \
        com.spotify.Client \
        com.jgraph.drawio.desktop \
        org.videolan.VLC

    ##### KDE #####
    flatpak install -y \
        org.gtk.Gtk3theme.Arc-Dark \
        org.gtk.Gtk3theme.Arc-Dark-solid
}

install-default-packages() {
    echo "Install a selection of used applications"
    ###### CMAKE / CLANG #########
    sudo dnf install -y cmake ninja-build clang llvm clang-tools-extra

    ###### VIRTUALIZATION ########
    sudo dnf install -y virt-manager
    sudo usermod -aG kvm,libvirt,lp,dialout "$USER"

    ###### NETWORKING ######
    sudo dnf install -y wireshark nmap curl wget

    ### Power-profiles
    sudo dnf swap -y power-profiles-daemon tuned-ppd

    ### VIDEO DRIVERS ######
    sudo dnf install -y mesa-vulkan-drivers mesa-va-drivers \
        mesa-vdpau-drivers mesa-libGLw mesa-libEGL libva-utils \
        mesa-libGL mesa-libGLU mesa-libOpenCL libva libva-vdpau-driver libva-utils \
        libvdpau-va-gl gstreamer1-vaapi mesa-libGL-devel libglvnd-devel intel-media-driver

    ### OTHER PACKAGES ######
    sudo dnf install -y openssl-devel zstd ncurses git \
        ncurses-libs stow zsh util-linux-user \
        java-25-openjdk java-25-openjdk-devel \
        jetbrains-mono-fonts google-roboto-fonts \
        steam-devices wl-clipboard nodejs \
        lsd bat zoxide fd-find procs ripgrep \
        kcalc okular gwenview plasma-milou vim

    ### Podman
    sudo dnf install -y podman podman-compose podman-docker buildah distrobox
    sudo touch /etc/containers/nodocker
    systemctl --user enable --now podman.socket
    systemctl --user status podman.socket

    ### python
    sudo dnf install -y python3-devel python3-wheel python3-virtualenv python3-pygments

    ### Set default shell
    sudo chsh -s /bin/zsh $USER
}

install-arc-theme() {
    echo "Install arc theme"
    sudo dnf -y install arc-theme arc-kde

    # Set gtk theme
    dbus-send --session --dest=org.kde.GtkConfig --type=method_call /GtkConfig org.kde.GtkConfig.setGtkTheme 'string:Arc-Dark'
}

install-vscode() {
    echo "Install Visual Studio Code"
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
    sudo dnf -y install code
}

install-brave() {
    curl -fsS https://dl.brave.com/install.sh | sh
}

install-kitty() {
    # kitty installer script
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin launch=n
    # Create symbolic links to add kitty and kitten to PATH (assuming ~/.local/bin is in your system-wide PATH)
    ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten ~/.local/bin/
    # Place the kitty.desktop file somewhere it can be found by the OS
    cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
    # If you want to open text files and images in kitty via your file manager also add the kitty-open.desktop file
    cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
    # Update the paths to the kitty and its icon in the kitty desktop file(s)
    sed -i "s|Icon=kitty|Icon=$(readlink -f ~)/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
    sed -i "s|Exec=kitty|Exec=$(readlink -f ~)/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop
    # Make xdg-terminal-exec (and hence desktop environments that support it use kitty)
    echo 'kitty.desktop' > ~/.config/xdg-terminals.list
}