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
    sudo curl -L https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage -o /usr/local/bin/nvim
    sudo chmod 755 /usr/local/bin/nvim
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
    ## Use mise 
    curl https://mise.run | sh
    mise use -g lazygit fzf starship yazi watchexec
}

###############################################################################
###### KITTY                                                            #######
###############################################################################
install-kitty() {
    # kitty installer script
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin launch=n
    # Create symbolic links to add kitty and kitten to PATH (assuming ~/.local/bin is in your system-wide PATH)
    ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten ~/.local/bin/
    # Place the kitty.desktop file somewhere it can be found by the OS
    cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
    # If you want to open text files and images in kitty via your file manager also add the kitty-open.desktop file
    cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
    # Update the paths to the kitty and its icon in the kitty desktop file(s)
    sed -i "s|Icon=kitty|Icon=$(readlink -f ~)/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
    sed -i "s|Exec=kitty|Exec=$(readlink -f ~)/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop
    # Make xdg-terminal-exec (and hence desktop environments that support it use kitty)
    echo 'kitty.desktop' > ~/.config/xdg-terminals.list
}

###############################################################################
###### INSTALL IWD                                                      #######
###############################################################################
install-iwd() {
    echo "Install IWD for networking"
    sudo dnf swap -y wpa_supplicant iwd

    echo -e "[device]\nwifi.backend=iwd\n" | sudo tee /etc/NetworkManager/conf.d/10-iwd.conf
    echo -e "[connection]\nwifi.powersave=2" | sudo tee /etc/NetworkManager/conf.d/20-powersave.conf
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
    # echo -e 'bgscan="simple:30:-70:3600"' | sudo tee -a /etc/wpa_supplicant/wpa_supplicant.conf
    sudo systemctl restart NetworkManager
    sudo systemctl restart wpa_supplicant
    sleep 10
}