#!/usr/bin/env bash
# This file contains most things that I run while installing the main fedora-kde
# install
###############################################################################
###  INITIAL REMOVAL KDE                                                    ###
###############################################################################
function first-cleanup-debian-kde(){
    sudo apt autoremove \
        konqueror \
        kwrite \
        kdeconnect \
        termit
}

###############################################################################
##### FLATPAKS                                                           ######
###############################################################################
function install-flathub(){
    echo "Add flathub repository"
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
}

###############################################################################
##### FLATPAKS                                                           ######
###############################################################################
function install-flatpak-packages(){
    echo "Install flatpak applications"
    flatpak -y install \
    com.github.tchx84.Flatseal

    ##### INTERNET #####
    flatpak -y install \
    com.discordapp.Discord \
    org.gnome.Evolution \
    org.libreoffice.LibreOffice \
    org.qbittorrent.qBittorrent \
    org.remmina.Remmina \
    org.telegram.desktop 

    ##### MUSIC & GRAPHICS #####
    flatpak install \
    com.obsproject.Studio \
    com.jgraph.drawio.desktop \
    org.blender.Blender \
    org.videolan.VLC


    ##### THEMES ######
    flatpak -y install \
    org.gtk.Gtk3theme.Arc-Dark \
    org.gtk.Gtk3theme.Arc-Dark-solid \
    org.kde.KStyle.Adwaita
}

###############################################################################
###  ETC/PROFILE                                                            ###
###############################################################################
## CONCAT /sbin:/usr/sbin:/usr/local/sbin to etc/profile

#############################################################################
##### NETWORKING                                                        #####
#############################################################################
# sudo ip link set wlp1s0 down
# sudo ip link set wlp1s0 up
# sudo wpa_supplicant -B -i wlp1s0 -c <(wpa_passphrase "SSID" "PASS")
# sudo dhclient wlp1s0

##############################################################################
#### KDE DESKTOP                                                        ######
##############################################################################
function install-kde-desktop(){
    echo "Install kde desktop"
    sudo apt -y install plasma-desktop plasma-workspace plasma-nm dolphin \
        kdialog kfind keditbookmarks konsole kate ark kcalc kde-spectacle \
        udisks2 upower kwin-x11 sddm xserver-xorg gwenview
}


###############################################################################
###  INSTALL DEVELOPMENT TOOLS                                              ###
###############################################################################
function main-packages(){
    echo "Install a selection of used applications"
    ###### CMAKE / CLANG #########
    sudo apt install -y cmake ninja-build clang llvm clang-tools

    ###### VIRTUALIZATION ########
    # sudo apt install -y virt-manager
    # sudo usermod -aG kvm,libvirt,lp,dialout $USER

    ###### NETWORKING ######
    sudo apt install -y wireshark nmap curl wget

    ##### VIDEO DRIVERS ######
    sudo apt install -y mesa-vulkan-drivers mesa-vdpau-drivers mesa-va-drivers \
        libvdpau1 libvdpau-va-gl1 libva2 libva-x11-2 libva-wayland2 libva-drm2 \
        libva-glx2 gstreamer1.0-vaapi

    ##### OTHER PACKAGES ######
    sudo apt install -y openssl zstd git openjdk-11-jdk stow \
        ark zsh libncurses5 libncurses5-dev libncurses6 libncurses-dev dolphin \
        fonts-roboto fonts-jetbrains-mono libssl-dev

}

function install-arc-theme(){
    sudo apt -y install arc-theme papirus-icon-theme
    wget -qO- https://raw.githubusercontent.com/PapirusDevelopmentTeam/arc-kde/master/install.sh | sh
}

###############################################################################
##### BRAVE BROWSER                                                      ######
###############################################################################
function install-brave(){
    echo "Install brave browser"
    sudo apt -y install apt-transport-https curl
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    sudo apt update
    sudo apt install brave-browser
}

##############################################################################
##### SPOTIFY                                                       ##########
##############################################################################
function install-spotify(){
    echo "Install spotify client"
    curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add -
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
    sudo apt-get update && sudo apt-get install spotify-client
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
    "Install vscode for linux"
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    rm -f packages.microsoft.gpg
    sudo apt install apt-transport-https
    sudo apt update
    sudo apt install code # or code-insiders
}

###############################################################################
###### PODMAN                                                           #######
###############################################################################
function install-podman(){
    echo "Install podman and buildah"
    sudo apt install podman podman-compose podman-docker buildah
}

###############################################################################
###### OH-MY-ZSH                                                         ######
###############################################################################
function install-oh-my-zsh(){
    "Install Oh-My-Zsh"
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
    mkdir -p $HOME/.local/bin
    curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86-64-unknown-linux-gnu.gz | gunzip -c - > ~/.local/bin/rust-analyzer
    chmod +x ~/.local/bin/rust-analyzer
    sh -c "$(curl -fsSL https://starship.rs/install.sh)"
    source $HOME/.cargo/env
    rustup component add rust-src
}

###############################################################################
###### KITTY                                                            #######
###############################################################################
function install-kitty(){
    echo "Install kitty appimage"
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
    # Create a symbolic link to add kitty to PATH (assuming ~/.local/bin is in
    # your PATH)
    ln -s ~/.local/kitty.app/bin/kitty ~/.local/bin/
    # Place the kitty.desktop file somewhere it can be found by the OS
    cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
    # Update the path to the kitty icon in the kitty.desktop file
    sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty.desktop
}

###############################################################################
###### PYTHON                                                           #######
###############################################################################
function install-pythontools(){
    echo "Install Python-Devel"
    sudo apt install python3-dev python3-wheel python3-venv

    echo "Install Poetry"
    curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3 -
}

###############################################################################
###### NODE JS                                                          #######
###############################################################################
function install-npm(){
    echo "Install NVM and NPM"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    nvm install 'lts/*'
    nvm use default
    npm install -g pyright --user
}

###############################################################################
###### ESP-IDF Framework                                                #######
###############################################################################
function install-espIdf(){
    echo "Install ESP-IDF"
    sudo apt-get install git wget flex bison gperf python3 python3-pip python3-setuptools \
        cmake ninja-build ccache libffi-dev libssl-dev dfu-util libusb-1.0-0
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
    sudo apt install gtk3-devel -y
    mkdir -p ~/Software
    cd ~/Software
    git clone https://github.com/flutter/flutter.git -b stable
    flutter doctor
}

###############################################################################
###### Heroku CLI                                                       #######
###############################################################################
function install-heroku(){
    echo "Install Heroku Cli"
    curl https://cli-assets.heroku.com/install.sh | sh
}
