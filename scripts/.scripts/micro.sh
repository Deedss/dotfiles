#!/bin/sh
###############################################################################
###  INSTALLATION KDE                                                       ###
###############################################################################
function install-kde(){
    echo "Perform Installation for Fedora KDE"
    ### Clean up kde
    clean-kde

    ### Generic Setup
    install-rpmfusion
    install-layered-packages
    install-rust
    install-oh-my-zsh

    # install-espIdf
    # install-emscripten

    ##### FLATPAKS
    install-flatpak
}

###############################################################################
###  CLEAN UP KDE                                                           ###
###############################################################################
function clean-kde(){
    sudo transactional-update pkg remove \
        kate
}

###############################################################################
##### FLATPAKS                                                           ######
###############################################################################
function install-flatpak(){
    echo "Install flatpak applications"
    flatpak install -y \
    com.github.tchx84.Flatseal

    ##### INTERNET #####
    flatpak install -y \
    com.brave.Browser \
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
    flatpak install -y \
    org.wezfurlong.wezterm \
    org.kde.okular \
    org.kde.gwenview \
    org.kde.kcalc \
    org.gnome.Evolution \
    org.gtk.Gtk3theme.Arc-Dark \
    org.gtk.Gtk3theme.Arc-Dark-solid

}

###############################################################################
##### LAYERED PACKAGES                                                   ######
###############################################################################
function install-layered-packages(){
    echo "Install layered packages"
    sudo transactional-update pkg install \
    neovim virt-manager stow zsh autojump-zsh \
        openssl ripgrep system-group-wheel pam_kwallet \  
        gtk2-metatheme-arc gtk3-metatheme-arc gtk4-metatheme-arc \
        arc-icon-theme metatheme-arc-common

    sudo usermod -aG kvm,libvirt,lp,dialout $USER
    echo "Install Visual Studio Code"
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/zypp/repos.d/vscode.repo'
    sudo transactional-update install pkg code
}

###############################################################################
##### BRAVE BROWSER                                                      ######
###############################################################################
function install-brave(){
    echo "Install brave browser"
    sudo zypper install curl
    sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
    sudo zypper addrepo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
    sudo zypper install brave-browser
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
###  INSTALL DEVELOPMENT TOOLS                                              ###
###############################################################################
function install-development-packages(){
    echo "Install a selection of development tools"
    ###### CMAKE / CLANG #########
    sudo dnf install -y cmake ninja-build clang llvm clang-tools-extra lldb rust-lldb meson

    ###### NETWORKING ######
    sudo dnf install -y wireshark nmap curl wget

    ##### OTHER PACKAGES ######
    sudo dnf install -y openssl zstd ncurses git ripgrep \
        ncurses-libs zsh util-linux-user redhat-lsb-core autojump-zsh \
        java-17-openjdk
}