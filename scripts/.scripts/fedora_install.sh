#!/bin/sh
# This file contains most things that I run while installing the main fedora-kde
# install
###############################################################################
###  INSTALLATION KDE                                                       ###
###############################################################################
function install-kde(){
    echo "Perform Installation for Fedora KDE"
    ### Set the correct DNF settings
    setup-dnf

    ### Clean up kde
    clean-kde

    ### Generic Setup
    install-rpmfusion
    default-packages
    install-brave
    install-vscode
    install-pythontools
    install-rust
    install-oh-my-zsh
    install-podman
    install-espIdf
    install-emscripten

    ### THEME
    install-arc-theme

    ##### FLATPAKS
    install-flatpak
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
        plasma-discover plasma-drkonqi okular gwenview kcalc

    ### Packages on kde spin =>> not on minimal install
    sudo dnf autoremove -y \
        elisa-player dragon mediawriter kmahjongg \
        kmines kpat ksudoku kamoso krdc libreoffice-* \
        kdeconnectd krfb kolourpaint-* konversation

    ### Excess gnome packages
    sudo dnf autoremove -y \
        gnome-keyring gnome-desktop3 gnome-desktop4 gnome-abrt

    ### Install packages that are kde specific
    sudo dnf install -y \
        ark
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
        https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
        https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
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
    org.freedesktop.Platform.ffmpeg-full

    ##### KDE #####
    if [[ "$XDG_SESSION_DESKTOP" == "KDE" ]];
    then
        flatpak install -y \
        org.wezfurlong.wezterm \
        org.kde.okular \
        org.kde.gwenview \
        org.kde.kcalc \
        org.gnome.Evolution \
        org.gtk.Gtk3theme.Arc-Dark \
        org.gtk.Gtk3theme.Arc-Dark-solid
    fi

    ##### GNOME #####
    if [[ "$XDG_SESSION_DESKTOP" == "gnome" ]];
    then
        flatpak install -y \
        org.gtk.Gtk3theme.Adwaita-dark \
        org.gtk.Gtk3theme.adw-gtk3-dark
    fi
}

###############################################################################
###  INSTALL DEVELOPMENT TOOLS                                              ###
###############################################################################
function default-packages(){
    echo "Install a selection of used applications"
    ###### CMAKE / CLANG #########
    sudo dnf install -y cmake ninja-build clang llvm clang-tools-extra lldb rust-lldb meson

    ###### VIRTUALIZATION ########
    sudo dnf install -y virt-manager
    sudo usermod -aG kvm,libvirt,lp,dialout $USER

    ###### NETWORKING ######
    sudo dnf install -y wireshark nmap curl wget

    ##### VIDEO DRIVERS ######
    sudo dnf install -y mesa-vulkan-drivers mesa-va-drivers \
        mesa-vdpau-drivers mesa-libGLw mesa-libEGL libva-utils \
        mesa-libGL mesa-libGLU mesa-libOpenCL libva libva-vdpau-driver libva-utils \
        libvdpau-va-gl gstreamer1-vaapi mesa-libGL-devel libglvnd-devel
    sudo dnf swap -y mesa-va-drivers mesa-va-drivers-freeworld
    sudo dnf swap -y mesa-vdpau-drivers mesa-vdpau-drivers-freeworld

    ##### OTHER PACKAGES ######
    sudo dnf install -y openssl zstd ncurses git power-profiles-daemon ripgrep \
        ncurses-libs stow zsh util-linux-user redhat-lsb-core neovim autojump-zsh \
        java-17-openjdk
}

###############################################################################
##### BRAVE BROWSER                                                      ######
###############################################################################
function install-arc-theme(){
    echo "Install arc theme"
    sudo dnf -y install arc-theme arc-kde
}

###############################################################################
##### BRAVE BROWSER                                                      ######
###############################################################################
function install-brave(){
    echo "Install brave browser"
    sudo dnf install -y dnf-plugins-core
    sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
    sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
    sudo dnf -y install brave-browser
}

###############################################################################
##### NEOVIM                                                             ######
###############################################################################
function install-neovim(){
    echo "Install Neovim Appimage"
    mkdir -p /Software/AppImages
    wget -P ~/Software/AppImages/ https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
    chmod u+x ~/Software/AppImages/nvim.appimage
    sudo cp ~/Software/AppImages/nvim.appimage /usr/local/bin/nvim
    sudo chown $USER:$USER /usr/local/bin/nvim
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

###############################################################################
###### PODMAN                                                           #######
###############################################################################
function install-podman(){
    echo "Install podman and buildah"
    sudo dnf install -y podman podman-compose podman-docker buildah

    ###############################################################################
    ####### START PODMAN ROOTLESS                                           #######
    ###############################################################################
    systemctl --user enable podman.socket
    systemctl --user start podman.socket
    systemctl --user status podman.socket
}

###############################################################################
###### OH-MY-ZSH                                                         ######
###############################################################################
function install-oh-my-zsh(){
    echo "Install OH-MY-ZSH"
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
        git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
}

###############################################################################
###### RUST INSTALL                                                   #########
###############################################################################
function install-rust(){
    echo "Install rust and rust-analyzer"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source $HOME/.cargo/env
    rustup component add rust-src
    rustup component add rust-analyzer
    ln -s ~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/rust-analyzer ~/.cargo/bin/
    mkdir -p ~/.local/bin
    curl -sS https://starship.rs/install.sh | sh -s -- --bin-dir ~/.local/bin -y
}

###############################################################################
###### PYTHON                                                           #######
###############################################################################
function install-pythontools(){
    echo "Install Python-Devel"
    sudo dnf -y install python3-devel python3-wheel python3-virtualenv

    echo "Installing python formatter"
    pip install black

    echo "installing language servers"
    pip install python-lsp-server cmake-language-server debugpy pynvim

    echo "Installing Poetry"
    curl -sSL https://install.python-poetry.org | python3 -
}

###############################################################################
###### NODE JS                                                          #######
###############################################################################
function install-npm(){
    echo "Install NVM and NPM"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    source ~/.zshrc
    nvm install 'lts/*'
    nvm use default
}

###############################################################################
###### ESP-IDF Framework                                                #######
###############################################################################
function install-espIdf(){
    echo "Install ESP-IDF"
    sudo dnf install -y git wget flex bison gperf python3 python3-pip python3-setuptools cmake ninja-build ccache dfu-util libusbx
    mkdir -p ~/Software
    cd ~/Software
    git clone --recursive https://github.com/espressif/esp-idf.git
    cd esp-idf
    sh install.sh
}

###############################################################################
###### Emscripten Framework                                             #######
###############################################################################
function install-emscripten(){
    echo "Install Emscripten WebAssembly"
    mkdir -p ~/Software
    cd ~/Software
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

###############################################################################
###### FLUTTER AND DART                                                 #######
###############################################################################
function install-flutter(){
    echo "Install Flutter and Dart"
    sudo dnf install gtk3-devel -y
    mkdir -p ~/Software
    cd ~/Software
    git clone https://github.com/flutter/flutter.git -b stable
    flutter doctor
}

###############################################################################
###### INSTALL IWD                                                      #######
###############################################################################
function install-iwd(){
    sudo dnf install -y iwd
    echo -e "[device]\nwifi.backend=iwd" | sudo tee /etc/NetworkManager/conf.d/10-iwd.conf
    sudo systemctl mask wpa_supplicant
}

###############################################################################
###### INSTALL ANDROID                                                  #######
###############################################################################
function install-android(){
    mkdir -p ~/Software/Android/Sdk

    # Install Udev Rules
    cd ~/Software/Android
    # Clone this repository
    git clone https://github.com/M0Rf30/android-udev-rules.git
    cd android-udev-rules
    # create a sym-link to the rules file
    sudo ln -sf "$PWD"/51-android.rules /etc/udev/rules.d/51-android.rules
    # Change file permissions
    sudo chmod a+r /etc/udev/rules.d/51-android.rules
    # Add the adbusers group if it's doesn't already exist
    sudo cp android-udev.conf /usr/lib/sysusers.d/
    sudo systemd-sysusers
    # Add your user to the adbusers group
    sudo gpasswd -a $(whoami) adbusers
    # Restart UDEV
    sudo udevadm control --reload-rules
    sudo systemctl restart systemd-udevd.service
    cd ~
}
