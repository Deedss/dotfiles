#!/usr/bin/env bash
# This file contains most things that I run while installing the main fedora-kde
# install

function full_first_install(){
    ###############################################################################
    ###  INITIAL REMOVAL                                                        ###
    ###############################################################################
    sudo dnf autoremove -y \*akonadi* dnfdragora kwrite kmag kmouth kmousetool \
        kget kruler kcolorchooser gnome-disk-utility ibus-libpinyin ibus-libzhuyin \
        ibus-cangjie-* ibus-hangul kcharselect kde-spectacle firefox \
        plasma-browser-integration plasma-discover

    ###############################################################################
    ###  ADD RPM FUSION / FLATPAK                                               ###
    ###############################################################################
    sudo dnf install -y \
        https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
        https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

    ###############################################################################
    ###  INSTALL DEVELOPMENT TOOLS                                              ###
    ###############################################################################
    ###### CMAKE / CLANG #########
    sudo dnf install -y cmake ninja-build clang llvm clang-tools-extra

    ###### RUST INSTALL #########
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.local/bin/rust-analyzer
    chmod +x ~/.local/bin/rust-analyzer
    sh -c "$(curl -fsSL https://starship.rs/install.sh)"

    ###### VIRTUALIZATION ########
    sudo dnf install -y virt-manager

    ###### NETWORKING ######
    sudo dnf install -y wireshark nmap curl wget

    ###### ZSH ######
    sudo dnf install -y zsh
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

    ##### VIDEO DRIVERS ######
    sudo dnf install -y mesa-vulkan-drivers mesa-vdpau-drivers mesa-libGLw mesa-libEGL \
        mesa-libGL mesa-libGLU mesa-libOpenCL libva libva-vdpau-driver libva-utils \
        libvdpau-va-gl gstreamer1-vaapi

    ##### OTHER PACKAGES ######
    sudo dnf install -y openssl zstd ncurses git power-profiles-daemon java-11-openjdk ncurses-libs stow google-roboto-fonts

    ##### FLATPAKS ######
    flatpak install com.discordapp.Discord com.github.tchx84.Flatseal com.jgraph.drawio.desktop \
        com.obsproject.Studio com.spotify.Client org.blender.Blender org.gtk.Gtk3theme.Arc-Dark \
        org.gtk.Gtk3theme.Arc-Dark-solid org.kde.KStyle.Adwaita org.libreoffice.LibreOffice \
        org.mozilla.Thunderbird org.mozilla.firefox org.qbittorrent.qBittorrent org.remmina.Remmina \
        org.signal.Signal org.videolan.VLC

    ##### BRAVE BROWSER ######
    sudo dnf install dnf-plugins-core
    sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
    sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
    sudo dnf install brave-browser

    ##### NEOVIM ######
    mkdir -p /Tools/AppImages
    wget -P ~/Tools/AppImages/ https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
    chmod u+x ~/Tools/AppImages/nvim.appimage
    sudo cp ~/Tools/AppImages/nvim.appimage /usr/local/bin/nvim
    sudo chown $USER:$USER /usr/local/bin/nvim

    ##### VSCODE #######
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
    sudo dnf install code

    ###### PYTHON #######
    sudo dnf install python3-devel python3-wheel python3-virtualenv
    pip install virtualenvwrapper

    ###### DOCKER #######
    # sudo dnf config-manager \
    #     --add-repo \
    #     https://download.docker.com/linux/fedora/docker-ce.repo

    # sudo dnf install docker-ce docker-ce-cli containerd.io
    # sudo usermod -aG docker $USER
    # sudo systemctl enable docker.service
    # sudo systemctl enable containerd.service
    sudo dnf install podman podman-compose podman-docker buildah

    ###### NODE JS #######
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    nvm install 'lts/*'
    nvm use default
    sudo npm install -g pyright

    ###### STOW STUFFS #######
    rm ~/.bash*
    rm ~/.zsh*
    git clone git@github.com:Deedss/dotfiles.git .dotfiles
    cd .dotfiles
    stow *
}

function install_podman(){
    sudo dnf install podman podman-compose podman-docker buildah
}

function grub_update(){
    sudo grub2-mkconfig -o /etc/grub2.cfg
    sudo grub2-mkconfig -o /etc/grub2-efi.cfg
}

function install_flutter(){
    sudo dnf install gtk3-devel -y
    mkdir -p ~/Tools
    cd ~/Tools
    git clone https://github.com/flutter/flutter.git -b stable
    flutter doctor
}

function install_espIdf(){
    sudo yum -y update && sudo yum install git wget flex bison gperf python3 python3-pip python3-setuptools cmake ninja-build ccache dfu-util libusbx
    mkdir -p ~/Tools
    cd ~/Tools
    git clone --recursive https://github.com/espressif/esp-idf.git
    cd esp-idf
    sh install.sh
}

function install_emscripten(){
    mkdir -p ~/Tools
    cd ~/Tools
    # Get the emsdk repo
    git clone https://github.com/emscripten-core/emsdk.git
    # Enter that directory
    cd emsdk
    # Fetch the latest version of the emsdk (not needed the first time you clone)
    git pull
    # Download and install the latest SDK tools.
    ./emsdk install latest
    # Make the "latest" SDK "active" for the current user. (writes .emscripten file)
    ./emsdk activate latest
}

function install_heroku(){
    curl https://cli-assets.heroku.com/install.sh | sh
}

function install_robotframework(){
    pip install robotframework robotframework-selenium2library pygame PyHamcrest pytest
}

function install_anaconda(){
    cd /tmp
    curl -0 https://repo.anaconda.com/archive/Anaconda3-2021.11-Linux-x86_64.sh
    sh Anaconda3-2021.11-Linux-x86_64.sh
}
