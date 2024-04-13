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
    cargo install starship neocmakelsp 
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
    git clone https://github.com/emscripten-core/emsdk.git ~/Software/emsdk
    sh ~/Software/emsdk/emsdk install latest
    sh ~/Software/emsdk/emsdk activate latest
    echo ''
}

###############################################################################
###### INSTALL GO                                                       #######
###############################################################################
function install-go(){
    # Check if ~/Software/go already exists and remove it if it does
    if [ -d "$HOME/Software/go" ]; then
        echo "Removing existing ~/Software/go directory"
        sudo rm -rf ~/Software/go
    fi

    # Specify the version of Go to install
    # Use the first argument, or default to "1.22.1" if not provided
    GO_VERSION=${1:-1.22.1}

    # Download the Go binary tarball
    curl -L https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz -o /tmp/go.tar.gz

    # Extract the tarball and move it to directory of choice
    tar -C ~/Software -xzf /tmp/go.tar.gz
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
    elif [[ $(lsb_release -is) == "openSUSE" ]]; then
        sudo zypper install -y iwd
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
    elif [[ $(lsb_release -is) == "openSUSE" ]]; then
        sudo zypper install -y git wget flex bison gperf python312-pip python312-setuptools ccache dfu-util libusbx
    fi

    git clone --recursive https://github.com/espressif/esp-idf.git ~/Software/esp-idf
    sh ~/Software/esp-idf/install.sh
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
    elif [[ $(lsb_release -is) == "openSUSE" ]]; then
        sudo zypper install -y podman python312-podman-compose podman-docker buildah
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
        sudo dnf -y install python3-devel python3-wheel python3-virtualenv python3-pygments
    elif [[ $(lsb_release -is) == "openSUSE" ]]; then
        sudo zypper -y install python312-devel python312-wheel python312-virtualenv
    fi

    pip install pynvim
}

###############################################################################
##### NEOVIM                                                            #######
###############################################################################
function install-neovim(){
    echo "Install Neovim"
    sudo curl -L https://github.com/neovim/neovim/releases/latest/download/nvim.appimage -o /usr/bin/nvim
    sudo chmod 755 /usr/bin/nvim
    echo ''
}

##############################################################################
##### UDEV RULES                                                        ######
##############################################################################
function fix-config(){
    echo "Setup UDEV rules"
    export USER_GID=`id -g`; sudo --preserve-env=USER_GID sh -c 'echo "KERNEL==\"hidraw*\", SUBSYSTEM==\"hidraw\", ATTRS{serial}==\"*vial:f64c2b3c*\", MODE=\"0660\", GROUP=\"$USER_GID\", TAG+=\"uaccess\", TAG+=\"udev-acl\"" > /etc/udev/rules.d/99-vial.rules && udevadm control --reload && udevadm trigger'
    export USER_GID=`id -g`; sudo --preserve-env=USER_GID sh -c 'echo "KERNEL==\"hidraw*\", SUBSYSTEM==\"hidraw\", MODE=\"0660\", GROUP=\"$USER_GID\", TAG+=\"uaccess\", TAG+=\"udev-acl\"" > /etc/udev/rules.d/92-viia.rules && udevadm control --reload && udevadm trigger' 

    echo "Add power support to bluetooth"
    sudo sed -i 's/# Experimental = false/Experimental = true/' /etc/bluetooth/main.conf
}

##############################################################################
##### Language Servers                                                  ######
##############################################################################
function install-language-servers(){
    # Python 
    pip install black install python-lsp-server debugpy pynvim

    # CMake
    curl -L https://github.com/Decodetalkers/neocmakelsp/releases/latest/download/neocmakelsp-x86_64-unknown-linux-gnu -o ~/.local/bin/neocmakelsp && chmod +x ~/.local/bin/neocmakelsp

    # C / C++ / Rust
    sudo dnf install clang-extra-tools
    curl -L https://github.com/vadimcn/codelldb/releases/latest/download/codelldb-x86_64-linux.vsix -o /tmp/codelldb.zip
    unzip -u /tmp/codelldb.zip -d ~/.local/bin/codelldb

    # Lua
    LUA_VERSION=$(curl -H "Accept: application/vnd.github+json" https://api.github.com/repos/LuaLS/lua-language-server/releases/latest | jq -r '.tag_name')
    curl -L "https://github.com/LuaLS/lua-language-server/releases/latest/download/lua-language-server-${LUA_VERSION}-linux-x64.tar.gz" -o /tmp/lua-language-server.tar.gz
    tar -C ~/.local/bin/lua-language-server -xzf /tmp/lua-language-server.tar.gz

    # Bash
    npm i -g bash-language-server

    # Markdown
    curl -L https://github.com/artempyanykh/marksman/releases/latest/download/marksman-linux-x64 -o ~/.local/bin/marksman && chmod +x ~/.local/bin/marksman

    # Json / Yaml
    npm i --save-dev --save-exact @biomejs/biome

    # Bazel
    curl -JL https://get.bzl.io/linux_amd64/bzl -o ~/.local/bin/bzl && chmod +x ~/.local/bin/bzl
}
