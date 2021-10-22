#!/usr/bin/env bash
# This file contains most things that I run while installing the main fedora-kde
# install
function first_cleanup_kde(){
    sudo dnf autoremove -y \
        \*akonadi* \
        dnfdragora \
        kwrite \
        kmag \
        kmouth \
        kmousetool \
        kget \
        kruler \
        kcolorchooser \
        gnome-disk-utility \
        ibus-libpinyin \
        ibus-libzhuyin \
        ibus-cangjie-* \
        ibus-hangul \
        kcharselect \
        kde-spectacle \
        firefox \
        plasma-browser-integration plasma-discover
}

function first_cleanup_gnome(){
    sudo dnf autoremove -y \
        gnome-tour \
        gnome-contacts \
        gnome-maps \
        gnome-weather \
        gnome-boxes \
        gnome-connections
}

function add_rpmfusion(){
    sudo dnf install -y \
        https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
        %https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
}

function main_packages(){
    sudo dnf install -y \
        cmake \
        ninja-build \
        clang \
        llvm \
        thunderbird \
        virt-manager\
        wireshark \
        nmap \
        qbittorrent \
        neovim \
        ncurses \
        git \
        curl \
        wget
}

function install_oh_my_zsh(){
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting \
        git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions \
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
}

function install_rust(){
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    \ sh -c "$(curl -fsSL https://starship.rs/install.sh)"
}

function install_brave(){
    sudo dnf install dnf-plugins-core \
    sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/ \
    sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc \
    sudo dnf install brave-browser
}

function install_kitty(){
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin \
    # Create a symbolic link to add kitty to PATH (assuming ~/.local/bin is in
    # your PATH)
    ln -s ~/.local/kitty.app/bin/kitty ~/.local/bin/ \
    # Place the kitty.desktop file somewhere it can be found by the OS
    cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/ \
    # Update the path to the kitty icon in the kitty.desktop file
    sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty.desktop
}
