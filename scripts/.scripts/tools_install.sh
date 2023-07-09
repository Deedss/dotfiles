#!/bin/bash
###############################################################################
###### RUST INSTALL                                                   #########
###############################################################################
function install-rust(){
    echo "Install rust and rust-analyzer"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source "$HOME"/.cargo/env
    rustup component add rust-src
    rustup component add rust-analyzer
    ln -s ~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/rust-analyzer ~/.cargo/bin/
    mkdir -p ~/.local/bin
    curl -sS https://starship.rs/install.sh | sh -s -- --bin-dir ~/.local/bin -y
}

###############################################################################
###### NODE JS                                                          #######
###############################################################################
function install-npm(){
    echo "Install NVM and NPM"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    source "$HOME"/.zshrc
    nvm install 'lts/*'
    nvm use default
}

###############################################################################
###### Emscripten Framework                                             #######
###############################################################################
function install-emscripten(){
    echo "Install Emscripten WebAssembly"
    mkdir -p ~/Software
    cd ~/Software || exit
    # Get the emsdk repo
    git clone https://github.com/emscripten-core/emsdk.git
    # Enter that directory
    cd emsdk || exit
    # Fetch the latest version of the emsdk (not needed the first time you clone)
    git pull
    # Download and install the latest SDK tools.
    ./emsdk install latest
    # Make the "latest" SDK "active" for the current user. (writes .emscripten file)
    ./emsdk activate latest
    cd ~ || exit
    echo ''
}

###############################################################################
###### INSTALL GO                                                       #######
###############################################################################
function install-go(){
    # Check if ~/Software/go already exists and remove it if it does
    if [ -d "$HOME/Software/go" ]; then
        echo "Removing existing ~/Software/go directory"
        rm -rf ~/Software/go
    fi

    # Specify the version of Go to install
    GO_VERSION=1.20.5
    GO_PARENT_FOLDER=~/Software

    # Set the filename of the Go tarball
    TARBALL_FILENAME=go${GO_VERSION}.linux-amd64.tar.gz

    # Set the path to the Go tarball
    TARBALL_PATH=$(pwd)/$TARBALL_FILENAME

    # Check if the Go tarball already exists
    if [ -f "$TARBALL_PATH" ]; then
        echo "Removing existing Go tarball: $TARBALL_PATH"
        rm "$TARBALL_PATH"
    fi

    # Download the Go binary tarball
    wget https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz -P ~/Downloads

    # Extract the tarball and move it to directory of choice
    tar -C ${GO_PARENT_FOLDER} -xzf ~/Downloads/go${GO_VERSION}.linux-amd64.tar.gz

    rm ~/Downloads/go${GO_VERSION}.linux-amd64.tar.gz
}

###############################################################################
###### INSTALL BAZEL                                                    #######
###############################################################################
function install-bazel(){
    # Tools for bazel
    go install github.com/bazelbuild/bazelisk@latest
    go install github.com/bazelbuild/buildtools/buildifier@latest
    go install github.com/bazelbuild/buildtools/buildozer@latest
    go install github.com/bazelbuild/buildtools/unused_deps@latest
}