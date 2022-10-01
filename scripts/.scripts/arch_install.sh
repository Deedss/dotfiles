#!/usr/bin/env bash
###############################################################################
##### INSTALLATION GUIDE FOR MY ARCH INSTALL                             ######
###############################################################################
##### NETWORKING #####
#  ip a
#  iwctl => station <device_name> connect <network>
#  prompted to enter password
#  check network ping google.com
#  sync system clock: timedatectl set-ntp true


##### SETUP PARTITIONS #####
# fdisk /dev/vda
# 'n' to create new partition
# make 512MB for /boot
# rest for filesystem

##### LUKS ON LVM ######
# cryptsetup luksFormat /dev/vda2
# cryptsetup open /dev/vda2 luks
# pvcreate /dev/mapper/luks
# vgcreate vg /dev/mapper/luks
# lvcreate -L 16G vg -n swap
# lvcreate -L 100G vg -n root
# lvcreate -l 100%FREE vg -n home
# mkfs.btrfs /dev/vg/root
# mkfs.btrfs /dev/vg/home
# mkswap /dev/vg/swap
# mount /dev/vg/root /mnt
# mount --mkdir /dev/vg/home /mnt/home
# swapon /dev/vg/swap
# mkfs.fat -F32 /dev/vda1 (boot)
# mount --mkdir /dev/vda1 /mnt/boot

##### CONFIGURE MKINITPCIO ######
# Add udev, keyboard, keymap, encrypt, lvm2 to hooks in /etc/mkinitpcio.conf


##### INSTALL BASE PACKAGES    #####
# pacstrap /mnt base linux linux-firmware git btrfs-progs lvm2 vi amd-ucode 

##### GENERATE FSTAB #####
# genfstab -U /mnt >> /mnt/etc/fstab
# arch-chroot /mnt


###############################################################################
##### INITIAL SETUP OF LOCALE                                             #####
###############################################################################
# ln -sf /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime
# hwclock --systohc
# sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
# locale-gen
# echo "LANG=en_US.UTF-8" >> /etc/locale.conf
# echo "yogaslim" >> /etc/hostname
# echo "127.0.0.1 localhost" >> /etc/hosts
# echo "::1       localhost" >> /etc/hosts
# echo "127.0.1.1 yogaslim.localdomain yogaslim" >> /etc/hosts
# echo root:password | chpasswd

###############################################################################
##### ADD USER                                                            #####
###############################################################################
# useradd -m gertjan
# echo gertjan:password | chpasswd
# echo "gertjan ALL=(ALL) ALL" >> /etc/sudoers.d/gertjan

###############################################################################
##### SYSTEMD-BOOT                                                        #####
###############################################################################



###############################################################################
##### INSTALL BASE KDE DESKTOP                                           ######
###############################################################################
function install-kde(){
    ### Desktop Environment
    sudo pacman -S mesa-utils xf86-input-libinput xorg-xdpyinfo xorg-server \
    xorg-xinit xorg-xinput xorg-xkill xorg-xrandr xf86-video-amdgpu xf86-video-ati \
    dialogusb_modeswitch amd-ucode pkgfile accountsservice bash-completion \
    xdg-user-dirs xdg-utils efitools ntp cantarell-fonts noto-fonts \
    ttf-liberation ttf-opensans hwdetect power-profiles-daemon upower \
    grub-tools duf git vi wget 

    ### KDE packages
    sudo pacman -S ark audiocd-kio breeze-gtk dolphin gwenview kcalc kate \
    kde-gtk-config khotkeys kinfocenter kinit kio-fuse konsole kscreen \
    kwallet-pam okular plasma-desktop plasma-disks plasma-nm plasma-pa \
    powerdevil print-manager sddm-kcm solid spectacle xsettingsd

    ### Audio
    sudo pacman -S pipewire wireplumber

    ### Networking
    sudo pacman -S networkmanager firewalld

    ### Bluetooth
    sudo pacman -S bluez bluez-utils

    ### Printer
    sudo pacman -S cups cups-filters cups-pdf foomatic-db foomatic-db-engine foomatic-db-gutenprint-ppds \
    foomatic-db-nonfree foomatic-db-nonfree-ppds foomatic-db-ppds ghostscript gsfonts \
    gutenprint splix system-config-printer hplip python-pyqt5 python-reportlab xsane
}

###############################################################################
##### INSTALL PARU HELPER                                                ######
###############################################################################
function install-paru() {
    echo "install paru helper"
    sudo pacman -S --needed base-devel
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si
    cd 
}

###############################################################################
###  INSTALL DEVELOPMENT TOOLS                                              ###
###############################################################################
function main-packages(){
    echo "Install a selection of used applications"
    ###### CMAKE / CLANG #########
    sudo pacman -S --needed cmake ninja-build clang llvm clang-tools-extra

    ###### VIRTUALIZATION ########
    sudo pacman -S --needed virt-manager
    sudo usermod -aG kvm,libvirt,lp,dialout $USER

    ###### NETWORKING ######
    sudo pacman -S --needed wireshark nmap curl wget

    ##### VIDEO DRIVERS ######
    sudo pacman -S --needed mesa-vulkan-drivers mesa-vdpau-drivers mesa-libGLw mesa-libEGL \
        mesa-libGL mesa-libGLU mesa-libOpenCL libva libva-vdpau-driver libva-utils \
        libvdpau-va-gl gstreamer1-vaapi

    ##### OTHER PACKAGES ######
    sudo pacman -S --needed openssl zstd ncurses git power-profiles-daemon java-17-openjdk \
    ncurses-libs stow google-roboto-fonts ark kate zsh kitty starship neovim

}

###############################################################################
##### BRAVE BROWSER                                                      ######
###############################################################################
function install-brave(){
    echo "Install brave browser"
    paru -S brave-bin
}

###############################################################################
##### VSCODE                                                            #######
###############################################################################
function install-vscode(){
    echo "Install Visual Studio Code"
    paru -S visual-studio-code-bin
}

###############################################################################
###### PODMAN                                                           #######
###############################################################################
function install-podman(){
    echo "Install podman and buildah"
    sudo pacman -S podman podman-compose podman-docker buildah
}

###############################################################################
###### OH-MY-ZSH                                                         ######
###############################################################################
function install-oh_my_zsh(){
    echo "Install OH-MY-ZSH"
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH-CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-completions ${ZSH-CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH-CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
}

###############################################################################
###### RUST INSTALL                                                   #########
###############################################################################
function install-rust(){
    echo "Install rust and rust-analyzer"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source $HOME/.cargo/env
    rustup component add rust-src
    pacman -S --needed rust-analyzer
}

###############################################################################
###### PYTHON                                                           #######
###############################################################################
function install-pythontools(){
    echo "Install Python-Devel"
    sudo pacman -S --needed python-wheel python-virtualenv

    echo "Install Poetry"
    curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -

    echo "installing language servers"
    pip install python-lsp-server cmake-language-server
}


###############################################################################
###### ESP-IDF Framework                                                #######
###############################################################################
function install-espIdf(){
    echo "Install ESP-IDF"
    sudo pacman -S --needed gcc git make flex bison gperf python-pip cmake ninja ccache dfu-util libusb
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
    sudo pacman --needed -S gtk3
    mkdir -p ~/Software
    cd ~/Software
    git clone https://github.com/flutter/flutter.git -b stable
    flutter doctor
}