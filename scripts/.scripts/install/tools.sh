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

    ## Install cli tools
    if [[ $(lsb_release -is) == "Debian" || $(lsb_release -is) == "Ubuntu" ]]; then
        cargo install cargo-binstall
        cargo-binstall --no-confirm zoxide bat eza fd-find ripgrep sd procs just
    fi
}

###############################################################################
###### NODE JS                                                          #######
###############################################################################
install-npm() {
    echo "Install FNM and NodeJS"
    cargo-binstall --no-confirm fnm
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
    curl -L https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz -o /tmp/nvim-linux64.tar.gz
    rm -rf ~/Software/nvim-linux64
    tar -C ~/Software -xzf /tmp/nvim-linux64.tar.gz
}

###############################################################################
###### FZF                                                              #######
###############################################################################
install-fzf() {
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/Software/fzf
    ~/Software/fzf/install --bin
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
###### INSTALL IWD                                                      #######
###############################################################################
install-iwd() {
    echo "Install IWD for networking"
    if [[ $(lsb_release -is) == "Debian" || $(lsb_release -is) == "Ubuntu" ]]; then
        sudo apt install -y iwd
    elif [[ $(lsb_release -is) == "Fedora" ]]; then
        sudo dnf install -y iwd
    fi

    echo -e "[device]\nwifi.backend=iwd\nwifi.iwd.autoconnect=yes" | sudo tee /etc/NetworkManager/conf.d/10-iwd.conf
    echo -e "[connection]\nwifi.powersave=2" | sudo tee /etc/NetworkManager/conf.d/20-powersave.conf
    sudo systemctl mask wpa_supplicant
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
        sudo apt install -y python3-dev python3-wheel python3-virtualenv python3-pygments pipx
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
