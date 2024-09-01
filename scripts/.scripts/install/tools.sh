#!/bin/bash
###############################################################################
###### RUST INSTALL                                                   #########
###############################################################################
install-rust() {
    echo "Install rust and rust-analyzer"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source "$HOME"/.cargo/env
    rustup component add rust-src
    rustup component add rust-analyzer
    rustup component add rustfmt

}

###############################################################################
###### NODE JS                                                          #######
###############################################################################
install-npm() {
    echo "Install NVM and NPM"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    source "$HOME"/.zshrc
    nvm install 'lts/*'
    nvm use default
}

install-bazel() {
    curl -L https://github.com/bazelbuild/bazelisk/releases/latest/download/bazelisk-linux-amd64 -o ~/.local/bin/bazelisk
    cp ~/.local/bin/bazelisk ~/.local/bin/bazel
    chmod +x ~/.local/bin/bazelisk ~/.local/bin/bazel
}

### GO
install-go() {
    # Specify the version of Go to install
    GO_VERSION=1.22.5
    GO_PARENT_FOLDER=~/Software
    TARBALL_FILENAME=go${GO_VERSION}.linux-amd64.tar.gz
    TARBALL_PATH=~/Downloads/$TARBALL_FILENAME
    INSTALL_DIR=$GO_PARENT_FOLDER/go

    # Check if ~/Software/go already exists and remove it if it does
    if [ -d "$INSTALL_DIR" ]; then
        echo "Removing existing $INSTALL_DIR directory"
        sudo rm -rf "$INSTALL_DIR"
    fi

    # Check if the Go tarball already exists and remove it if it does
    if [ -f "$TARBALL_PATH" ]; then
        echo "Removing existing Go tarball: $TARBALL_PATH"
        sudo rm "$TARBALL_PATH"
    fi

    # Download the Go binary tarball
    echo "Downloading Go tarball to $TARBALL_PATH"
    wget -q https://dl.google.com/go/$TARBALL_FILENAME -P ~/Downloads

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
install-iwd() {
    echo "Install IWD for networking"
    sudo dnf install -y iwd

    echo -e "[device]\nwifi.backend=iwd" | sudo tee /etc/NetworkManager/conf.d/10-iwd.conf
    sudo systemctl mask wpa_supplicant

    echo -e "[General]\nRoamThreshold=-70\nRoamThreshold5G=-70" | sudo tee /etc/iwd/main.conf

    echo -e "[connection]\nwifi.powersave=2" | sudo tee /etc/NetworkManager/conf.d/20-powersave.conf
}

install-wpa_supplicant() {
    echo "Setup wpa_supplicant"

    sudo rm /etc/NetworkManager/conf.d/10-iwd.conf
    sudo systemctl unmask wpa_supplicant
    echo -e "[connection]\nwifi.powersave=2" | sudo tee /etc/NetworkManager/conf.d/20-powersave.conf
    echo -e 'bgscan="simple:30:-70:3600"' | sudo tee -a /etc/wpa_supplicant/wpa_supplicant.conf
}

###############################################################################
###### ESP-IDF Framework                                                #######
###############################################################################
install-espIdf() {
    echo "Install ESP-IDF"
    sudo dnf install -y git wget flex bison gperf python3 python3-pip python3-setuptools cmake ninja-build ccache dfu-util libusbx

    git clone --recursive https://github.com/espressif/esp-idf.git ~/Software/esp-idf
    sh ~/Software/esp-idf/install.sh
    echo ''
}

###############################################################################
###### PODMAN                                                           #######
###############################################################################
install-podman() {
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
install-pythontools() {
    echo "Install Python-Devel"

    sudo dnf install -y python3-devel python3-wheel python3-virtualenv python3-pygments
}

###############################################################################
##### NEOVIM                                                            #######
###############################################################################
install-neovim() {
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

##############################################################################
##### UDEV RULES                                                        ######
##############################################################################
fix-config() {
    echo "Setup UDEV rules"
    export USER_GID=$(id -g)
    for rule in "99-vial:*vial:f64c2b3c*" "92-viia:"; do
        filename=${rule%%:*}
        serial=${rule##*:}
        echo "KERNEL==\"hidraw*\", SUBSYSTEM==\"hidraw\", ATTRS{serial}==\"*${serial}*\", MODE=\"0660\", GROUP=\"$USER_GID\", TAG+=\"uaccess\", TAG+=\"udev-acl\"" >/etc/udev/rules.d/${filename}.rules
    done
    sudo udevadm control --reload && sudo udevadm trigger
    echo "Add power support to bluetooth"
    sudo sed -i 's/# Experimental = false/Experimental = true/' /etc/bluetooth/main.conf

    mkdir -p ~/.local/bin
}
