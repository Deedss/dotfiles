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
###### ZED                                                              #######
###############################################################################
install-zed() {
    curl -f https://zed.dev/install.sh | sh
}

install-neovim() {
    latest_nvim_version=$(curl -L https://api.github.com/repos/neovim/neovim/releases/latest 2>/dev/null | jq -r '.tag_name')
    doas curl -L https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage -o /usr/local/bin/nvim
    doas chmod 755 /usr/local/bin/nvim
}

###############################################################################
###### ASTRAL                                                           #######
###############################################################################
install-python-tools() {
    # Install uv
    curl -LsSf https://astral.sh/uv/install.sh | sh

    # install ty lsp for python
    uv tool install ty ruff
}

###############################################################################
###### Cli Tools                                                        #######
###############################################################################
install-cli-tools() {
    # Cargo binstall
    curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
    cargo binstall --no-confirm cargo-update starship yazi-fm yazi-cli watchexec-cli

    # Github App Installer https://github.com/get-gah/gah
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/get-gah/gah/refs/heads/master/tools/install.sh)"
    gah install lazygit --unattended
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
    doas dnf install -y iwd

    echo -e "[device]\nwifi.backend=iwd\nwifi.iwd.autoconnect=yes" | doas tee /etc/NetworkManager/conf.d/10-iwd.conf
    echo -e "[connection]\nwifi.powersave=2" | doas tee /etc/NetworkManager/conf.d/20-powersave.conf
    echo -e "[General]\nRoamThreshold=-70\nRoamThreshold5G=-76\n[Scan]\nDisablePeriodicScan=false" | doas tee -a /etc/iwd/main.conf
    doas systemctl mask wpa_supplicant
}

###############################################################################
###### PODMAN                                                           #######
###############################################################################
install-podman() {
    echo "Install podman and buildah"
    doas dnf install -y podman podman-compose podman-docker buildah distrobox
    doas touch /etc/containers/nodocker

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
    doas dnf install -y python3-devel python3-wheel python3-virtualenv python3-pygments
}

##############################################################################
##### UDEV RULES                                                        ######
##############################################################################
fix-config() {
    echo "Setup UDEV rules"
    export USER_GID=$(id -g)
    doas --preserve-env=USER_GID sh -c 'echo "KERNEL==\"hidraw*\", SUBSYSTEM==\"hidraw\", ATTRS{serial}==\"*vial:f64c2b3c*\", MODE=\"0660\", GROUP=\"$USER_GID\", TAG+=\"uaccess\", TAG+=\"udev-acl\"" > /etc/udev/rules.d/99-vial.rules && udevadm control --reload && udevadm trigger'
    doas --preserve-env=USER_GID sh -c 'echo "KERNEL==\"hidraw*\", SUBSYSTEM==\"hidraw\", MODE=\"0660\", GROUP=\"$USER_GID\", TAG+=\"uaccess\", TAG+=\"udev-acl\"" > /etc/udev/rules.d/92-viia.rules && udevadm control --reload && udevadm trigger'

    echo "Add power support to bluetooth"
    doas sed -i 's/# Experimental = false/Experimental = true/' /etc/bluetooth/main.conf

    echo -e "[connection]\nwifi.powersave=2" | doas tee /etc/NetworkManager/conf.d/20-powersave.conf
    echo -e 'bgscan="simple:30:-70:3600"' | doas tee -a /etc/wpa_supplicant/wpa_supplicant.conf
    doas systemctl restart NetworkManager
    doas systemctl restart wpa_supplicant
    sleep 10
}