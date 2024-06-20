#!/bin/bash
###############################################################################
###### RUST INSTALL                                                   #########
###############################################################################
function install-rust() {
    echo "Install rust and rust-analyzer"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source "$HOME"/.cargo/env
    rustup component add rust-src
    rustup component add rust-analyzer
    rustup component add rustfmt

    mkdir -p ~/.local/bin
    cargo install starship
}

###############################################################################
###### OH-MY-ZSH                                                         ######
###############################################################################
function install-oh-my-zsh() {
    echo "Install OH-MY-ZSH"
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone https://github.com/zsh-users/zsh-completions "${ZSH_CUSTOM:-${ZSH:-$HOME/.oh-my-zsh}/custom}/plugins/zsh-completions"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
    git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
    git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab

    rm -f "$HOME/.zcompdump*"
}

###############################################################################
###### NODE JS                                                          #######
###############################################################################
function install-npm() {
    echo "Install NVM and NPM"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    source "$HOME"/.zshrc
    nvm install 'lts/*'
    nvm use default
}

###############################################################################
###### Emscripten Framework                                             #######
###############################################################################
function install-emscripten() {
    echo "Install Emscripten WebAssembly"
    git clone https://github.com/emscripten-core/emsdk.git ~/Software/emsdk
    sh ~/Software/emsdk/emsdk install latest
    sh ~/Software/emsdk/emsdk activate latest
    echo ''
}

function install-bazel() {
    curl -L https://github.com/bazelbuild/bazelisk/releases/latest/download/bazelisk-linux-amd64 -o ~/.local/bin/bazelisk
    cp ~/.local/bin/bazelisk ~/.local/bin/bazel
    chmod +x ~/.local/bin/bazelisk ~/.local/bin/bazel
}

###############################################################################
###### INSTALL IWD                                                      #######
###############################################################################
function install-iwd() {
    echo "Install IWD for networking"
    if [[ $(lsb_release -is) == "Debian" || $(lsb_release -is) == "Ubuntu" ]]; then
        sudo apt install -y iwd
    elif [[ $(lsb_release -is) == "Fedora" ]]; then
        sudo dnf install -y iwd
    elif [[ $(lsb_release -is) == "openSUSE" ]]; then
        sudo zypper -y install iwd
    fi

    echo -e "[device]\nwifi.backend=iwd" | sudo tee /etc/NetworkManager/conf.d/10-iwd.conf
    sudo systemctl mask wpa_supplicant

    echo -e "[connection]\nwifi.powersave=2" | sudo tee /etc/NetworkManager/conf.d/20-powersave.conf
}

###############################################################################
###### ESP-IDF Framework                                                #######
###############################################################################
function install-espIdf() {
    echo "Install ESP-IDF"

    if [[ $(lsb_release -is) == "Debian" || $(lsb_release -is) == "Ubuntu" ]]; then
        sudo apt install -y git wget flex bison gperf python3 python3-pip python3-venv \
            cmake ninja-build ccache libffi-dev libssl-dev dfu-util libusb-1.0-0
    elif [[ $(lsb_release -is) == "Fedora" ]]; then
        sudo dnf install -y git wget flex bison gperf python3 python3-pip python3-setuptools cmake ninja-build ccache dfu-util libusbx
    elif [[ $(lsb_release -is) == "openSUSE" ]]; then
        sudo zypper -y install git wget flex bison gperf python312-pip python312-setuptools ccache dfu-util libusbx
    fi

    git clone --recursive https://github.com/espressif/esp-idf.git ~/Software/esp-idf
    sh ~/Software/esp-idf/install.sh
    echo ''
}

###############################################################################
###### PODMAN                                                           #######
###############################################################################
function install-podman() {
    echo "Install podman and buildah"
    if [[ $(lsb_release -is) == "Debian" || $(lsb_release -is) == "Ubuntu" ]]; then
        sudo apt install -y podman podman-compose podman-docker buildah distrobox
    elif [[ $(lsb_release -is) == "Fedora" ]]; then
        sudo dnf install -y podman podman-compose podman-docker buildah distrobox
    elif [[ $(lsb_release -is) == "openSUSE" ]]; then
        sudo zypper -y install podman python312-podman-compose podman-remote \
            podman-docker buildah distrobox
    fi
    sudo touch /etc/containers/nodocker

    ###############################################################################
    ####### START PODMAN ROOTLESS                                           #######
    ###############################################################################
    systemctl --user enable --now podman.socket
    systemctl --user status podman.socket
}

###############################################################################
###### PYTHON                                                           #######
###############################################################################
function install-pythontools() {
    echo "Install Python-Devel"

    if [[ $(lsb_release -is) == "Debian" || $(lsb_release -is) == "Ubuntu" ]]; then
        sudo apt -y install python3-dev python3-wheel python3-virtualenv python3-pip pipx
        pip install --user --break-system-packages pynvim
    elif [[ $(lsb_release -is) == "Fedora" ]]; then
        sudo dnf -y install python3-devel python3-wheel python3-virtualenv python3-pygments
        pip install --user pynvim
    elif [[ $(lsb_release -is) == "openSUSE" ]]; then
        sudo zypper -y install python312-devel python312-wheel python312-virtualenv
        pip install --user pynvim
    fi
}

###############################################################################
##### NEOVIM                                                            #######
###############################################################################
function install-neovim() {
    echo "Install Neovim"
    sudo curl -L https://github.com/neovim/neovim/releases/latest/download/nvim.appimage -o /usr/bin/nvim
    sudo chmod 755 /usr/bin/nvim
    echo ''
}

###############################################################################
##### FUZZY FILE FINDER                                                 #######
###############################################################################
function install-fzf() {
    git clone https://github.com/junegunn/fzf.git ~/Software/fzf
    sh ~/Software/fzf/install --xdg --no-update-rc --completion --key-bindings
}

##############################################################################
##### UDEV RULES                                                        ######
##############################################################################
function fix-config() {
    echo "Setup UDEV rules"
    export USER_GID=$(id -g)
    sudo --preserve-env=USER_GID sh -c 'echo "KERNEL==\"hidraw*\", SUBSYSTEM==\"hidraw\", ATTRS{serial}==\"*vial:f64c2b3c*\", MODE=\"0660\", GROUP=\"$USER_GID\", TAG+=\"uaccess\", TAG+=\"udev-acl\"" > /etc/udev/rules.d/99-vial.rules && udevadm control --reload && udevadm trigger'
    export USER_GID=$(id -g)
    sudo --preserve-env=USER_GID sh -c 'echo "KERNEL==\"hidraw*\", SUBSYSTEM==\"hidraw\", MODE=\"0660\", GROUP=\"$USER_GID\", TAG+=\"uaccess\", TAG+=\"udev-acl\"" > /etc/udev/rules.d/92-viia.rules && udevadm control --reload && udevadm trigger'

    echo "Add power support to bluetooth"
    sudo sed -i 's/# Experimental = false/Experimental = true/' /etc/bluetooth/main.conf

    echo -e "[connection]\nwifi.powersave=2" | sudo tee /etc/NetworkManager/conf.d/20-powersave.conf
    sudo systemctl restart NetworkManager
    sleep 10
}

###############################################################################
#### FZF                                                                  #####
###############################################################################
function install-fzf() {
    mkdir -p ~/Software
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/Software/fzf
    ~/Software/fzf/install --xdg --no-bash --completion --key-bindings --no-update-rc
}

##############################################################################
##### Language Servers                                                  ######
##############################################################################
function install-language-servers() {
    # Python
    if [[ $(lsb_release -is) == "Debian" || $(lsb_release -is) == "Ubuntu" ]]; then
        pip install --user --break-system-packages black install python-lsp-server debugpy pynvim
    elif [[ $(lsb_release -is) == "Fedora" ]]; then
        pip install --user black install python-lsp-server debugpy pynvim
    elif [[ $(lsb_release -is) == "openSUSE" ]]; then
        pip install --user black install python-lsp-server debugpy pynvim
    fi

    # CMake
    curl -L https://github.com/Decodetalkers/neocmakelsp/releases/latest/download/neocmakelsp-x86_64-unknown-linux-gnu -o ~/.local/bin/neocmakelsp && chmod +x ~/.local/bin/neocmakelsp

    # C / C++ / Rust
    if [[ $(lsb_release -is) == "Debian" || $(lsb_release -is) == "Ubuntu" ]]; then
        # nothing yet
        sudo apt update
    elif [[ $(lsb_release -is) == "Fedora" ]]; then
        sudo dnf install -y clang-extra-tools
    elif [[ $(lsb_release -is) == "openSUSE" ]]; then
        sudo zypper install -y clang-tools
    fi

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
