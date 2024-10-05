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
    cargo install fnm
    fnm install --lts
    fnm completions --shell zsh >~/.local/share/fnm/completions.zsh
}

###############################################################################
###### ZED                                                              #######
###############################################################################
install-zed() {
    curl -f https://zed.dev/install.sh | sh
}

###############################################################################
###### NEOVIM                                                           #######
###############################################################################
install-neovim() {
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
    rm -rf ~/Software/nvim-linux64
    tar -C ~/Software -xzf nvim-linux64.tar.gz
    rm nvim-linux64.tar.gz
}

###############################################################################
###### BAZEL                                                            #######
###############################################################################
install-bazel() {
    curl -L https://github.com/bazelbuild/bazelisk/releases/latest/download/bazelisk-linux-amd64 -o ~/.local/bin/bazelisk
    cp ~/.local/bin/bazelisk ~/.local/bin/bazel
    chmod +x ~/.local/bin/bazelisk ~/.local/bin/bazel
}

###############################################################################
###### BAZEL                                                            #######
###############################################################################
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
    if [[ $(lsb_release -is) == "Debian" || $(lsb_release -is) == "Ubuntu" ]]; then
        sudo apt install -y iwd
    elif [[ $(lsb_release -is) == "Fedora" ]]; then
        sudo dnf install -y iwd
    fi

    echo -e "[device]\nwifi.backend=iwd" | sudo tee /etc/NetworkManager/conf.d/10-iwd.conf
    echo -e "[General]\nRoamThreshold=-70\nRoamThreshold5G=-70" | sudo tee /etc/iwd/main.conf
    echo -e "[connection]\nwifi.powersave=2" | sudo tee /etc/NetworkManager/conf.d/20-powersave.conf
    sudo systemctl mask wpa_supplicant
}

install-wpa_supplicant() {
    echo "Setup wpa_supplicant"

    sudo rm /etc/NetworkManager/conf.d/10-iwd.conf
    sudo systemctl unmask wpa_supplicant
    echo -e "[connection]\nwifi.powersave=2" | sudo tee /etc/NetworkManager/conf.d/20-powersave.conf
    echo -e 'bgscan="simple:30:-70:3600"' | sudo tee -a /etc/wpa_supplicant/wpa_supplicant.conf
}

###############################################################################
###### PODMAN                                                           #######
###############################################################################
install-podman() {
    echo "Install podman and buildah"

    if [[ $(lsb_release -is) == "Debian" || $(lsb_release -is) == "Ubuntu" ]]; then
        sudo apt install -y podman podman-docker buildah
        pipx install podman-compose
    elif [[ $(lsb_release -is) == "Fedora" ]]; then
        sudo dnf install -y podman podman-compose podman-docker buildah distrobox
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
install-pythontools() {
    echo "Install Python-Devel"
    if [[ $(lsb_release -is) == "Debian" || $(lsb_release -is) == "Ubuntu" ]]; then
        sudo apt install -y python3-devel python3-wheel python3-virtualenv python3-pygments
    elif [[ $(lsb_release -is) == "Fedora" ]]; then
        sudo dnf install -y python3-devel python3-wheel python3-virtualenv python3-pygments
    fi
}

##############################################################################
##### UDEV RULES                                                        ######
##############################################################################
fix-config() {
    echo "Setup UDEV rules"
    export USER_GID=$(id -g)
    sudo --preserve-env=USER_GID sh -c 'echo "KERNEL==\"hidraw*\", SUBSYSTEM==\"hidraw\", ATTRS{serial}==\"*vial:f64c2b3c*\", MODE=\"0660\", GROUP=\"$USER_GID\", TAG+=\"uaccess\", TAG+=\"udev-acl\"" > /etc/udev/rules.d/99-vial.rules && udevadm control --reload && udevadm trigger'
    sudo --preserve-env=USER_GID sh -c 'echo "KERNEL==\"hidraw*\", SUBSYSTEM==\"hidraw\", MODE=\"0660\", GROUP=\"$USER_GID\", TAG+=\"uaccess\", TAG+=\"udev-acl\"" > /etc/udev/rules.d/92-viia.rules && udevadm control --reload && udevadm trigger'

    echo "Add power support to bluetooth"
    sudo sed -i 's/# Experimental = false/Experimental = true/' /etc/bluetooth/main.conf

    echo -e "[connection]\nwifi.powersave=2" | sudo tee /etc/NetworkManager/conf.d/20-powersave.conf
    echo -e 'bgscan="simple:30:-70:3600"' | sudo tee -a /etc/wpa_supplicant/wpa_supplicant.conf
    sudo systemctl restart NetworkManager
    sudo systemctl restart wpa_supplicant
    sleep 10
}
