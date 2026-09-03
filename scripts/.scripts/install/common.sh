#!/bin/bash

install-rust() {
    echo "Install rust and rust-analyzer"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source "$HOME"/.cargo/env
    rustup component add rust-src
    rustup component add rust-analyzer
    rustup component add rustfmt
}

install-zed() {
    curl -f https://zed.dev/install.sh | sh
}

install-neovim() {
    latest_nvim_version=$(curl -L https://api.github.com/repos/neovim/neovim/releases/latest 2>/dev/null | jq -r '.tag_name')
    sudo curl -L https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage -o /usr/local/bin/nvim
    sudo chmod 755 /usr/local/bin/nvim
}

install-python-tools() {
    # Install uv
    curl -LsSf https://astral.sh/uv/install.sh | sh

    # install ty lsp for python
    uv tool install ty ruff
}

install-cli-tools() {
    ## Use mise 
    curl https://mise.run | sh
    mise use -g fzf starship lua-language-server stylua tree-sitter
}

fix-config() {
    echo "Setup UDEV rules"
    export USER_GID=$(id -g)
    sudo --preserve-env=USER_GID sh -c 'echo "KERNEL==\"hidraw*\", SUBSYSTEM==\"hidraw\", ATTRS{serial}==\"*vial:f64c2b3c*\", MODE=\"0660\", GROUP=\"$USER_GID\", TAG+=\"uaccess\", TAG+=\"udev-acl\"" > /etc/udev/rules.d/99-vial.rules && udevadm control --reload && udevadm trigger'
    sudo --preserve-env=USER_GID sh -c 'echo "KERNEL==\"hidraw*\", SUBSYSTEM==\"hidraw\", MODE=\"0660\", GROUP=\"$USER_GID\", TAG+=\"uaccess\", TAG+=\"udev-acl\"" > /etc/udev/rules.d/92-viia.rules && udevadm control --reload && udevadm trigger'

    echo "Add power support to bluetooth"
    [[ -f /etc/bluetooth/main.conf ]] && sudo sed -i 's/# Experimental = false/Experimental = true/' /etc/bluetooth/main.conf

    echo -e "[connection]\nwifi.powersave=2" | sudo tee /etc/NetworkManager/conf.d/20-powersave.conf
    sudo systemctl restart NetworkManager
    sudo systemctl restart wpa_supplicant
    sleep 20
}
