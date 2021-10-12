#!/usr/bin/env bash
# This file contains most things that I run while installing the main fedora-kde
# install
function first_cleanup(){
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
