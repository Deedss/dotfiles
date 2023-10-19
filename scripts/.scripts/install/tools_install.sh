#!/bin/bash
###############################################################################
###### RUST INSTALL                                                   #########
###############################################################################
function install-rust(){
    echo "Install rust and rust-analyzer"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source "$HOME"/.cargo/env
    rustup component add rust-src
    rustup component add rust-analyzer
    rustup component add rustfmt
    mkdir -p ~/.local/bin
    curl -sS https://starship.rs/install.sh | sh -s -- --bin-dir ~/.local/bin -y
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

    rm -f "$HOME/.zcompdump*"
}

###############################################################################
###### NODE JS                                                          #######
###############################################################################
function install-npm(){
    echo "Install NVM and NPM"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    source "$HOME"/.zshrc
    nvm install 'lts/*'
    nvm use default
}

###############################################################################
###### Emscripten Framework                                             #######
###############################################################################
function install-emscripten(){
    echo "Install Emscripten WebAssembly"
    mkdir -p ~/Software
    cd ~/Software || exit
    # Get the emsdk repo
    git clone https://github.com/emscripten-core/emsdk.git
    # Enter that directory
    cd emsdk || exit
    # Fetch the latest version of the emsdk (not needed the first time you clone)
    git pull
    # Download and install the latest SDK tools.
    ./emsdk install latest
    # Make the "latest" SDK "active" for the current user. (writes .emscripten file)
    ./emsdk activate latest
    cd ~ || exit
    echo ''
}

###############################################################################
###### INSTALL GO                                                       #######
###############################################################################
function install-go(){
    setopt LOCAL_OPTIONS RM_STAR_SILENT

    # Check if ~/Software/go already exists and remove it if it does
    if [ -d "$HOME/Software/go" ]; then
        echo "Removing existing ~/Software/go directory"
        sudo rm -rf ~/Software/go
    fi

    # Specify the version of Go to install
    GO_VERSION=1.21.0
    GO_PARENT_FOLDER=~/Software

    # Set the filename of the Go tarball
    TARBALL_FILENAME=go${GO_VERSION}.linux-amd64.tar.gz

    # Set the path to the Go tarball
    TARBALL_PATH=$(pwd)/$TARBALL_FILENAME

    # Check if the Go tarball already exists
    if [ -f "$TARBALL_PATH" ]; then
        echo "Removing existing Go tarball: $TARBALL_PATH"
        rm -f "$TARBALL_PATH"
    fi

    # Download the Go binary tarball
    wget https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz -P ~/Downloads

    # Extract the tarball and move it to directory of choice
    tar -C ${GO_PARENT_FOLDER} -xzf ~/Downloads/go${GO_VERSION}.linux-amd64.tar.gz

    # Check if the Go tarball already exists
    if [ -f "$TARBALL_PATH" ]; then
        echo "Removing existing Go tarball: $TARBALL_PATH"
        rm -f "$TARBALL_PATH"
    fi
}

###############################################################################
###### INSTALL BAZEL                                                    #######
###############################################################################
function install-bazel(){
    # Tools for bazel
    go install github.com/bazelbuild/bazelisk@latest
    go install github.com/bazelbuild/buildtools/buildifier@latest
    go install github.com/bazelbuild/buildtools/buildozer@latest
    go install github.com/bazelbuild/buildtools/unused_deps@latest

    local bazel_folder="$HOME/.oh-my-zsh/plugins/bazel"

    if [ ! -d "${bazel_folder}" ]; then
        mkdir -p ~/.oh-my-zsh/plugins/bazel
        wget -P ~/.oh-my-zsh/plugins https://raw.githubusercontent.com/bazelbuild/bazel/master/scripts/zsh_completion/_bazel
    fi
}

###############################################################################
###### FLUTTER AND DART                                                 #######
###############################################################################
function install-flutter(){
    echo "Install Flutter and Dart"
    if [[ $(lsb_release -is) == "Debian" || $(lsb_release -is) == "Ubuntu" ]]; then
        sudo apt install -y clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev
    elif [[ $(lsb_release -is) == "Fedora" ]]; then
        sudo dnf install gtk3-devel -y
    fi

    mkdir -p ~/Software
    cd ~/Software || exit
    git clone https://github.com/flutter/flutter.git -b stable
    flutter doctor
    cd ~ || exit
    echo ''
}

###############################################################################
###### INSTALL IWD                                                      #######
###############################################################################
function install-iwd(){
    echo "Install IWD for networking"
    if [[ $(lsb_release -is) == "Debian" || $(lsb_release -is) == "Ubuntu" ]]; then
        sudo apt install -y iwd
    elif [[ $(lsb_release -is) == "Fedora" ]]; then
        sudo dnf install -y iwd
    fi

    echo -e "[device]\nwifi.backend=iwd" | sudo tee /etc/NetworkManager/conf.d/10-iwd.conf
    sudo systemctl mask wpa_supplicant
}

###############################################################################
###### ESP-IDF Framework                                                #######
###############################################################################
function install-espIdf(){
    echo "Install ESP-IDF"
    if [[ $(lsb_release -is) == "Debian" || $(lsb_release -is) == "Ubuntu" ]]; then
        sudo apt install -y git wget flex bison gperf python3 python3-pip python3-venv \
            cmake ninja-build ccache libffi-dev libssl-dev dfu-util libusb-1.0-0
    elif [[ $(lsb_release -is) == "Fedora" ]]; then
        sudo dnf install -y git wget flex bison gperf python3 python3-pip python3-setuptools cmake ninja-build ccache dfu-util libusbx
    fi

    mkdir -p ~/Software
    cd ~/Software || exit
    git clone --recursive https://github.com/espressif/esp-idf.git
    cd esp-idf || exit
    sh install.sh
    cd ~ || exit
    echo ''
}

###############################################################################
###### PODMAN                                                           #######
###############################################################################
function install-podman(){
    echo "Install podman and buildah"
    if [[ $(lsb_release -is) == "Debian" || $(lsb_release -is) == "Ubuntu" ]]; then
        sudo apt install -y podman podman-compose podman-docker buildah distrobox
    elif [[ $(lsb_release -is) == "Fedora" ]]; then
        sudo dnf install -y podman podman-compose podman-docker buildah distrobox
    fi
    sudo touch /etc/containers/nodocker

    ###############################################################################
    ####### START PODMAN ROOTLESS                                           #######
    ###############################################################################
    systemctl --user enable podman.socket
    systemctl --user start podman.socket
    systemctl --user status podman.socket
}


###############################################################################
###### PYTHON                                                           #######
###############################################################################
function install-pythontools(){
    echo "Install Python-Devel"
    if [[ $(lsb_release -is) == "Debian" || $(lsb_release -is) == "Ubuntu" ]]; then
        sudo apt -y install python3-dev python3-wheel python3-virtualenv
    elif [[ $(lsb_release -is) == "Fedora" ]]; then
        sudo dnf -y install python3-devel python3-wheel python3-virtualenv
    fi

    echo "Installing python packages"
    pip install black install python-lsp-server cmake-language-server debugpy pynvim
}

###############################################################################
##### NEOVIM                                                            #######
###############################################################################
function install-neovim(){
    echo "Install Neovim"
    cd ~/.local/bin || exit
    curl -L https://github.com/neovim/neovim/releases/latest/download/nvim.appimage -o nvim
    chmod u+x nvim
    cd ~ || exit
    echo ''
}