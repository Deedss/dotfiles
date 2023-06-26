#!/bin/bash
SCRIPT_PATH="$(dirname -- "${BASH_SOURCE[0]}")"
. "$SCRIPT_PATH"/tools_install.sh

###############################################################################
###  INSTALLATION KDE                                                       ###
###############################################################################
function install-kde(){
    echo "Perform Installation for OpenSUSE"
    ### Set the correct DNF settings
    setup-zypper

    ### Generic Setup
    default-packages

    # install-brave
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

###############################################################################
##### SETUP DNF                                                         #######
###############################################################################
function setup-zypper(){
    sudo sed -i 's/# download.max_concurrent_connections = 5/download. max_concurrent_connections = 20/' /etc/zypp/zypp.conf
}

###############################################################################
##### FLATPAKS                                                           ######
###############################################################################
function install-flatpak(){
    sudo zypper install -y flatpak

    echo "Add flathub repository"
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
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

    flatpak install -y \
    org.wezfurlong.wezterm \
    org.kde.okular \
    org.kde.dolphin \
    org.kde.ark \
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
    sudo zypper install -y cmake ninja clang llvm clang-tools

    ###### VIRTUALIZATION ########
    sudo zypper install -y virt-manager-test
    sudo usermod -aG kvm,libvirt,lp,dialout "$USER"

    ###### NETWORKING ######
    sudo zypper install -y wireshark nmap curl wget

    ##### VIDEO DRIVERS ######
    sudo zypper install -y \
        Mesa-libva Mesa-libEGL1 Mesa-libEGL-devel Mesa-libOpenCL \
        Mesa-libRusticlOpenCL libva2 libva-wayland2 libva-x11-2 libva-vdpau-driver

    ##### OTHER PACKAGES ######
    sudo zypper install -y \
        openssl zstd ncurses git power-profiles-daemon ripgrep \
        ncurses-utils stow zsh util-linux neovim autojump \
        java-17-openjdk java-17-openjdk-devel jetbrains-mono-fonts google-roboto-fonts
}

###############################################################################
##### BRAVE BROWSER                                                      ######
###############################################################################
function install-arc-theme(){
    echo "Install arc theme"
    sudo zypper addrepo https://download.opensuse.org/repositories/home:kill_it/openSUSE_Tumbleweed/home:kill_it.repo
    sudo zypper refresh
    sudo zypper install -y \
        gtk2-metatheme-arc gtk3-metatheme-arc gtk4-metatheme-arc arc-kde
}

###############################################################################
##### BRAVE BROWSER                                                      ######
###############################################################################
function install-brave(){
    echo "Install brave browser"
    sudo zypper install curl
    sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
    sudo zypper addrepo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
    sudo zypper install brave-browser -y
}

###############################################################################
##### VSCODE                                                            #######
###############################################################################
function install-vscode(){
    echo "Install Visual Studio Code"
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/zypp/repos.d/vscode.repo'
    sudo zypper refresh
    sudo zypper install code
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
    sudo zypper install -y iwd
    echo -e "[device]\nwifi.backend=iwd" | sudo tee /etc/NetworkManager/conf.d/10-iwd.conf
    sudo systemctl mask wpa_supplicant
}

###############################################################################
###### FLUTTER AND DART                                                 #######
###############################################################################
function install-flutter(){
    echo "Install Flutter and Dart"
    sudo zypper install gtk3-devel -y
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
    sudo zypper install -y git wget flex bison gperf python311-pip python311-setuptools ccache dfu-util libusbx
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
    sudo zypper -y install python311-devel python311-wheel python311-virtualenv

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
    sudo zypper install -y podman python311-podman-compose podman-docker buildah
}
