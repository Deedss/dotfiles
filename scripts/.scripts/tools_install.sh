#!/bin/sh
###############################################################################
###### PODMAN                                                           #######
###############################################################################
function install-podman(){
    echo "Install podman and buildah"
    sudo dnf install -y podman podman-compose podman-docker buildah

    ###############################################################################
    ####### START PODMAN ROOTLESS                                           #######
    ###############################################################################
    systemctl --user enable podman.socket
    systemctl --user start podman.socket
    systemctl --user status podman.socket
}

###############################################################################
###### RUST INSTALL                                                   #########
###############################################################################
function install-rust(){
    echo "Install rust and rust-analyzer"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source $HOME/.cargo/env
    rustup component add rust-src
    rustup component add rust-analyzer
    ln -s ~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/rust-analyzer ~/.cargo/bin/
    mkdir -p ~/.local/bin
    curl -sS https://starship.rs/install.sh | sh -s -- --bin-dir ~/.local/bin -y
}

###############################################################################
###### PYTHON                                                           #######
###############################################################################
function install-pythontools(){
    echo "Install Python-Devel"
    sudo dnf -y install python3-devel python3-wheel python3-virtualenv

    echo "Installing python formatter"
    pip install black

    echo "installing language servers"
    pip install python-lsp-server cmake-language-server debugpy pynvim

    echo "Installing Poetry"
    curl -sSL https://install.python-poetry.org | python3 -
}

###############################################################################
###### NODE JS                                                          #######
###############################################################################
function install-npm(){
    echo "Install NVM and NPM"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    source ~/.zshrc
    nvm install 'lts/*'
    nvm use default
}

###############################################################################
###### ESP-IDF Framework                                                #######
###############################################################################
function install-espIdf(){
    echo "Install ESP-IDF"
    sudo dnf install -y git wget flex bison gperf python3 python3-pip python3-setuptools cmake ninja-build ccache dfu-util libusbx
    mkdir -p ~/Software
    cd ~/Software
    git clone --recursive https://github.com/espressif/esp-idf.git
    cd esp-idf
    sh install.sh
}

###############################################################################
###### Emscripten Framework                                             #######
###############################################################################
function install-emscripten(){
    echo "Install Emscripten WebAssembly"
    mkdir -p ~/Software
    cd ~/Software
    # Get the emsdk repo
    git clone https://github.com/emscripten-core/emsdk.git
    # Enter that directory
    cd emsdk
    # Fetch the latest version of the emsdk (not needed the first time you clone)
    git pull
    # Download and install the latest SDK tools.
    ./emsdk install latest
    # Make the "latest" SDK "active" for the current user. (writes .emscripten file)
    ./emsdk activate latest
}

###############################################################################
###### FLUTTER AND DART                                                 #######
###############################################################################
function install-flutter(){
    echo "Install Flutter and Dart"
    sudo dnf install gtk3-devel -y
    mkdir -p ~/Software
    cd ~/Software
    git clone https://github.com/flutter/flutter.git -b stable
    flutter doctor
}

###############################################################################
###### INSTALL ANDROID                                                  #######
###############################################################################
function install-android(){
    mkdir -p ~/Software/Android/Sdk

    # Install Udev Rules
    cd ~/Software/Android
    # Clone this repository
    git clone https://github.com/M0Rf30/android-udev-rules.git
    cd android-udev-rules
    # create a sym-link to the rules file
    sudo ln -sf "$PWD"/51-android.rules /etc/udev/rules.d/51-android.rules
    # Change file permissions
    sudo chmod a+r /etc/udev/rules.d/51-android.rules
    # Add the adbusers group if it's doesn't already exist
    sudo cp android-udev.conf /usr/lib/sysusers.d/
    sudo systemd-sysusers
    # Add your user to the adbusers group
    sudo gpasswd -a $(whoami) adbusers
    # Restart UDEV
    sudo udevadm control --reload-rules
    sudo systemctl restart systemd-udevd.service
    cd ~
}

###############################################################################
###### INSTALL GO                                                       #######
###############################################################################
function install-go(){
    # Check if ~/Software/go already exists and remove it if it does
    if [ -d "~/Software/go" ]; then
        echo "Removing existing ~/Software/go directory"
        rm -rf ~/Software/go
    fi

    # Specify the version of Go to install
    GO_VERSION=1.20.2
    GO_PARENT_FOLDER=~/Software
    GO_INSTALL_LOCATION=${GO_PARENT_FOLDER}/go

    # Set the filename of the Go tarball
    TARBALL_FILENAME=go${GO_VERSION}.linux-amd64.tar.gz

    # Set the path to the Go tarball
    TARBALL_PATH=$(pwd)/$TARBALL_FILENAME

    # Check if the Go tarball already exists
    if [ -f "$TARBALL_PATH" ]; then
        echo "Removing existing Go tarball: $TARBALL_PATH"
        rm $TARBALL_PATH
    fi
    
    # Download the Go binary tarball
    wget https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz -P ~/Downloads
    
    # Extract the tarball and move it to directory of choice
    tar -C ${GO_INSTALL_LOCATION} -xzf ~/Downloads/go${GO_VERSION}.linux-amd64.tar.gz
}

###############################################################################
###### INSTALL BAZEL                                                    #######
###############################################################################
function install-bazel(){
    # Set the directory where Bazelisk will be installed
    INSTALL_DIR=~/Software/bazel

    # Create the directory if it doesn't exist
    mkdir -p $INSTALL_DIR

    # Set the Bazel version to install
    BAZEL_VERSION=""

    # Check if a Bazel version was specified
    if [ -n "$BAZEL_VERSION" ]; then
        # Download the specified version of Bazel from GitHub
        curl -L -o $INSTALL_DIR/bazel https://github.com/bazelbuild/bazel/releases/download/$BAZEL_VERSION/bazel-$BAZEL_VERSION-linux-x86_64

        # Make the downloaded binary executable
        chmod +x $INSTALL_DIR/bazel
    else
        # Download the latest version of Bazelisk from GitHub
        curl -L -o $INSTALL_DIR/bazelisk https://github.com/bazelbuild/bazelisk/releases/latest/download/bazelisk-linux-amd64

        # Make the downloaded binary executable
        chmod +x $INSTALL_DIR/bazelisk
    fi

    # Check if GOPATH is set
    if [ -z "$GOPATH" ]; then
        echo "GOPATH is not set, setting it to ~/Software/go"
        export GOPATH=~/Software/go
    fi

    # Tools for bazel
    go install github.com/bazelbuild/buildtools/buildifier@latest
    go install github.com/bazelbuild/buildtools/buildozer@latest
    go install github.com/bazelbuild/buildtools/unused_deps@latest
}