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

### GO
function install-go() {
    # Specify the version of Go to install
    GO_VERSION=1.22.5
    GO_PARENT_FOLDER=~/Software
    TARBALL_FILENAME=go${GO_VERSION}.linux-amd64.tar.gz
    TARBALL_PATH=~/Downloads/$TARBALL_FILENAME
    INSTALL_DIR=$GO_PARENT_FOLDER/go

    # Check if ~/Software/go already exists and remove it if it does
    if [ -d "$INSTALL_DIR" ]; then
        echo "Removing existing $INSTALL_DIR directory"
        rm -rf "$INSTALL_DIR"
    fi

    # Check if the Go tarball already exists and remove it if it does
    if [ -f "$TARBALL_PATH" ]; then
        echo "Removing existing Go tarball: $TARBALL_PATH"
        rm "$TARBALL_PATH"
    fi

    # Download the Go binary tarball
    echo "Downloading Go tarball to $TARBALL_PATH"
    wget -q https://dl.google.com/go/$TARBALL_FILENAME -P ~/Downloads

    # Verify the download
    if [ ! -f "$TARBALL_PATH" ]; then
        echo "Download failed or the tarball does not exist at $TARBALL_PATH"
        return 1
    fi

    # Extract the tarball and move it to the directory of choice
    echo "Extracting Go tarball to $GO_PARENT_FOLDER"
    tar -C $GO_PARENT_FOLDER -xzf $TARBALL_PATH

    # Check if extraction was successful
    if [ ! -d "$INSTALL_DIR" ]; then
        echo "Extraction failed"
        return 1
    fi

    # Clean up the downloaded tarball
    echo "Removing the downloaded tarball: $TARBALL_PATH"
    rm "$TARBALL_PATH"

    echo "Go $GO_VERSION has been installed successfully in $INSTALL_DIR"
    return 0
}

###############################################################################
###### INSTALL IWD                                                      #######
###############################################################################
function install-iwd() {
    echo "Install IWD for networking"
    sudo dnf install -y iwd

    echo -e "[device]\nwifi.backend=iwd" | sudo tee /etc/NetworkManager/conf.d/10-iwd.conf
    sudo systemctl mask wpa_supplicant

    echo -e "[connection]\nwifi.powersave=2" | sudo tee /etc/NetworkManager/conf.d/20-powersave.conf
}

###############################################################################
###### ESP-IDF Framework                                                #######
###############################################################################
function install-espIdf() {
    echo "Install ESP-IDF"
    sudo dnf install -y git wget flex bison gperf python3 python3-pip python3-setuptools cmake ninja-build ccache dfu-util libusbx

    git clone --recursive https://github.com/espressif/esp-idf.git ~/Software/esp-idf
    sh ~/Software/esp-idf/install.sh
    echo ''
}

###############################################################################
###### PODMAN                                                           #######
###############################################################################
function install-podman() {
    echo "Install podman and buildah"
    sudo dnf install -y podman podman-compose podman-docker buildah distrobox
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

    sudo dnf install -y python3-devel python3-wheel python3-virtualenv python3-pygments
}

###############################################################################
##### NEOVIM                                                            #######
###############################################################################
function install-neovim() {
    # Running neovim in devcontainer
    # "mounts": [
    #     "source=${localEnv:HOME}/.config/nvim,target=/home/celixdev/.config/nvim,type=bind",
    #     "source=${localEnv:HOME}/.local/share/nvim,target=/home/celixdev/.local/share/nvim,type=bind",
    #     "source=${localEnv:HOME}/.local/state/nvim,target=/home/celixdev/.local/state/nvim,type=bind",
    #     "source=${localEnv:HOME}/Software/nvim,target=/home/celixdev/Software/nvim,type=bind"
    # ],

    echo "Install Neovim"
    INSTALL_DIR="$HOME/Software/nvim"
    TAR_FILE="nvim-linux64.tar.gz"
    DOWNLOAD_URL="https://github.com/neovim/neovim/releases/latest/download/${TAR_FILE}"
    if [ -d "$INSTALL_DIR" ]; then
        rm -rf "$INSTALL_DIR"
    fi
    mkdir -p "$INSTALL_DIR"
    curl -L "$DOWNLOAD_URL" -o "$TAR_FILE"
    tar -xzf "$TAR_FILE" --strip-components=1 -C "$INSTALL_DIR"
    rm "$TAR_FILE"

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
    pip install --user black install python-lsp-server debugpy pynvim

    # CMake
    curl -L https://github.com/Decodetalkers/neocmakelsp/releases/latest/download/neocmakelsp-x86_64-unknown-linux-gnu -o ~/.local/bin/neocmakelsp && chmod +x ~/.local/bin/neocmakelsp

    # C / C++ / Rust
    sudo dnf install -y clang-extra-tools

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
