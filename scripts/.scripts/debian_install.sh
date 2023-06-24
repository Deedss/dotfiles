#!/bin/bash
SCRIPT_PATH="$(dirname -- "${BASH_SOURCE[0]}")"
. "$SCRIPT_PATH"/tools_install.sh

###############################################################################
###  INSTALLATION KDE                                                       ###
###############################################################################
function install-kde(){
    echo "Perform Installation for Debian KDE"
    install-kde-desktop

    ### Generic Setup
    default-packages
    install-brave
    install-vscode
    install-pythontools
    install-rust
    install-oh-my-zsh
    install-podman
    #install-espIdf
    install-emscripten

    ### THEME
    install-arc-theme

    ##### FLATPAKS
    install-flatpak
}

##############################################################################
#### KDE DESKTOP                                                        ######
##############################################################################
function install-kde-desktop(){
    echo "Install kde desktop"
    sudo apt -y install plasma-desktop plasma-workspace plasma-nm \
        kdialog kfind kde-spectacle libpam-kwallet5 kde-config-flatpak \
        udisks2 upower kwin-x11 kwin-wayland sddm xserver-xorg \
        aptitude aria2 ark dolphin

    # Update GRUB timeout value
    sudo sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/' /etc/default/grub
    # Regenerate GRUB configuration
    sudo update-grub
}

###############################################################################
##### FLATPAKS                                                           ######
###############################################################################
function install-flatpak(){
    sudo apt install flatpak -y

    echo "Add flathub repository"
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    sudo flatpak remote-modify flathub --enable

    echo "Install flatpak applications"
    ##### INTERNET #####
    flatpak install -y \
    com.discordapp.Discord \
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
    sudo apt install -y cmake ninja-build clang llvm clang-tools

    ###### VIRTUALIZATION ########
    sudo apt install -y virt-manager
    sudo usermod -aG kvm,libvirt,lp,dialout $USER

    ###### NETWORKING ######
    sudo apt install -y wireshark nmap curl wget

    ##### VIDEO DRIVERS ######
    sudo apt install -y mesa-vulkan-drivers mesa-vdpau-drivers mesa-va-drivers \
        libvdpau1 libvdpau-va-gl1 libva2 libva-x11-2 libva-wayland2 libva-drm2 \
        libva-glx2 gstreamer1.0-vaapi

    ##### OTHER PACKAGES ######
    sudo apt install -y openssl zstd git openjdk-17-jdk stow ripgrep \
        libncurses5 libncurses5-dev libncurses6 libncurses-dev \
        fonts-roboto fonts-jetbrains-mono libssl-dev neovim zsh autojump
}

###############################################################################
##### BRAVE BROWSER                                                      ######
###############################################################################
function install-arc-theme(){
    echo "Install arc theme"
    sudo apt -y install arc-theme
    wget -qO- https://raw.githubusercontent.com/PapirusDevelopmentTeam/arc-kde/master/install.sh | sh
    wget -qO- https://git.io/papirus-icon-theme-install | DESTDIR="$HOME/.local/share/icons" sh
}

###############################################################################
##### BRAVE BROWSER                                                      ######
###############################################################################
function install-brave(){
    echo "Install brave browser"
    sudo apt -y install curl
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    sudo apt update
    sudo apt install -y brave-browser
}

###############################################################################
##### VSCODE                                                            #######
###############################################################################
function install-vscode(){
    echo "Install Visual Studio Code"
    sudo apt -y install wget gpg
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    rm -f packages.microsoft.gpg
    sudo apt update
    sudo apt install -y code
}

###############################################################################
##### NEOVIM                                                            #######
###############################################################################
function install-neovim(){
    cd ~/.local/bin || exit
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x nvim.appimage
    sudo ln -s nvim.appimage /usr/bin/nvim
}

###############################################################################
###### OH-MY-ZSH                                                         ######
###############################################################################
function install-oh-my-zsh(){
    echo "Install OH-MY-ZSH"
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone https://github.com/zsh-users/zsh-completions "${ZSH_CUSTOM:-${ZSH:-$HOME/.oh-my-zsh}/custom}/plugins/zsh-completions"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
    git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"

}

###############################################################################
###### INSTALL IWD                                                      #######
###############################################################################
function install-iwd(){
    sudo apt install -y iwd
    echo -e "[device]\nwifi.backend=iwd" | sudo tee /etc/NetworkManager/conf.d/10-iwd.conf
    sudo systemctl mask wpa_supplicant
}

###############################################################################
###### FLUTTER AND DART                                                 #######
###############################################################################
function install-flutter(){
    echo "Install Flutter and Dart"
    sudo apt install -y clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev
    mkdir -p ~/Software
    cd ~/Software || exit
    git clone https://github.com/flutter/flutter.git -b stable
    flutter doctor
}

###############################################################################
###### ESP-IDF Framework                                                #######
###############################################################################
function install-espIdf(){
    echo "Install ESP-IDF"
    sudo apt install -y git wget flex bison gperf python3 python3-pip python3-venv cmake ninja-build ccache libffi-dev libssl-dev dfu-util libusb-1.0-0
    mkdir -p ~/Software
    cd ~/Software || exit
    git clone --recursive https://github.com/espressif/esp-idf.git
    cd esp-idf || exit
    sh install.sh
}

###############################################################################
###### PYTHON                                                           #######
###############################################################################
function install-pythontools(){
    echo "Install Python-Devel"
    sudo apt -y install python3-dev python3-wheel python3-virtualenv

    echo "Installing python formatter"
    pip install black

    echo "installing language servers"
    pip install python-lsp-server cmake-language-server debugpy pynvim

    echo "Installing Poetry"
    curl -sSL https://install.python-poetry.org | python3 -
}

###############################################################################
###### PODMAN                                                           #######
###############################################################################
function install-podman(){
    echo "Install podman and buildah"
    sudo apt install -y podman podman-compose podman-docker buildah
}

###############################################################################
###### EXTRA SETTINGS                                                   #######
###############################################################################
# VISUDO %users  ALL=(ALL) NOPASSWD: /sbin/poweroff, /sbin/reboot

