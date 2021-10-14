sudo dnf autoremove \akonadi* dnfdragora-2.1.0-3.fc34.noarch PackageKit-*
sudo dnf autoremove \akonadi* dnfdragora-2.1.0-3.fc34.noarch kwrite kmag kmousetool-20.12.2-1.fc34.x86_64 kruler kmouth-20.12.2-1.fc34.x86_64 kget kcolorchooser-21.04.1-1.fc34.x86_64 spectacle-21.04.1-1.fc34.x86_64 gnome-disk-utility-40.2-1.fc34.x86_64 gnome-desktop3-40.4-1.fc34.x86_64 
sudo dnf autoremove \akonadi* dnfdragora-2.1.0-3.fc34.noarch kwrite kmag kmousetool-20.12.2-1.fc34.x86_64 kruler kmouth-20.12.2-1.fc34.x86_64 kget kcolorchooser-21.04.1-1.fc34.x86_64 spectacle-21.04.1-1.fc34.x86_64 gnome-disk-utility-40.2-1.fc34.x86_64 
sudo dnf autoremove \akonadi* dnfdragora-2.1.0-3.fc34.noarch kwrite kmag kmousetool-20.12.2-1.fc34.x86_64 kruler kmouth-20.12.2-1.fc34.x86_64 kget kcolorchooser-21.04.1-1.fc34.x86_64 spectacle-21.04.1-1.fc34.x86_64 gnome-disk-utility-40.2-1.fc34.x86_64 -yy
sudo dnf autoremove gnome-desktop3-40.4-1.fc34.x86_64 
sudo dnf autoremove kcharselect-20.12.2-1.fc34.x86_64 ibus-libzhuyin-1.10.0-2.fc34.x86_64 ibus-libpinyin-1.12.0-3.fc34.x86_64 ibus-cangjie-* ibus-hangul-1.5.4-5.fc34.x86_64 
sudo vi /etc/dnf/dnf.conf 
sudo vi /etc/default/grub 
sudo nano /etc/systemd/logind.conf 
sudo grub2-mkconfig -o /etc/grub2.cfg 
sudo grub2-mkconfig -o /etc/grub2-efi.cfg 
reboot
ausearch -c 'sddm-greeter' --raw | audit2allow -M my-sddmgreeter
sudo ausearch -c 'sddm-greeter' --raw | audit2allow -M my-sddmgreeter
sudo semodule -i my-sddmgreeter.pp
ls
rm my-sddmgreeter.*
ls
exit
sudo dnf autoremove \*akonadi*
reboot
sudo dnf install clang llvm cmake ninja-build thunderbird arc-theme kde-arc
dnf search arc
sudo dnf install clang llvm cmake ninja-build thunderbird arc-theme arc-kde ark kate neovim 
sudo dnf install zstandard git curl wget
sudo dnf install zstd
sudo dnf install dnf-plugins-core
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sudo dnf install brave-browser
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
exit
rustup component add rls rust-analysis rust-src
sh -c "$(curl -fsSL https://starship.rs/install.sh)"
exit
eval $(ssh-agent -S) 
eval $(ssh-agent s-)
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
exit
sudo dnf install power-profiles-daemon virt-manager java-11-openjdk
exit
nvim
exit
ls
exit
reboot
sudo dnf autoremove discover
sudo dnf autoremove plasma-discover-*
sudo systemctl status packagekit
exit
sudo cp Pictures/nord_underwater.png /usr/share/wallpapers/
sudo rm -rf /usr/share/akonadi/
exit
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
ls
sudo dnf install virt-manager
groups gertjan 
sudo usermod -aG kvm $USER 
sudo usermod -aG libvirt $USER 
sudo usermod -aG dialout $USER 
exit
sudo yum install zlib.i686 ncurses-libs.i686 bzip2-libs.i686
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
dnf check-update
sudo dnf install code
sudo dnf install libva libva-vdpau-driver lldb clang-tools libvdpau-va-gl mesa-libEGL.x86_64 mesa-libGL.x86_64 mesa-libGLU.x86_64 mesa-libOpenCL.x86_64 mesa-libglapi.x86_64 mesa-vdpau-drivers.x86_64 mesa-vulkan-drivers.x86_64 mesa-libGLw.x86_64
sudo dnf install libva libva-vdpau-driver lldb libvdpau-va-gl mesa-libEGL.x86_64 mesa-libGL.x86_64 mesa-libGLU.x86_64 mesa-libOpenCL.x86_64 mesa-libglapi.x86_64 mesa-vdpau-drivers.x86_64 mesa-vulkan-drivers.x86_64 mesa-libGLw.x86_64
sudo dnf install clang-tools-extra.x86_64
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install vlc discord syncthing
sudo dnf install vlc discord -y
sudo dnf install podman podman-compose podman-docker podman-plugins
sudo dnf install python3-podman
sudo yum -y update && sudo yum install git wget flex bison gperf python3 python3-pip python3-setuptools cmake ninja-build ccache dfu-util libusbx
sudo dnf install ncurses ncurses-libs ncurses-devel
exit
sudo systemctl enable power-profiles-daemon.service 
sudo dnf search libva
sudo dnf search vaapi
sudo dnf search mesa
sudo dnf search clang
sudo dnf search podman
sudo dnf search ncurses
nvim .scripts/sources 
exit
sudo dnf install python-virtualenv
pip install python-language-server[all]
exit
git clone -b v4.3.1 --recursive https://github.com/espressif/esp-idf.git esp-idf-stable
cd esp-idf-stable
./install.sh 
exit
nvim .scripts/sources 
exit
sudo mv android-studio/ /opt/
sudo mv Telegram/ /opt/
cd /opt/
sudo dnf install openssl
exit
sudo dnf install yakuake
exit
chmod +x Downloads/qt-unified-linux-x64-4.1.1-online.run 
sudo ./Downloads/qt-unified-linux-x64-4.1.1-online.run 
exit
sudo dnf install ksnip
exit
sh /opt/android-studio/bin/studio.sh 
cd Tools/
ls
git clone https://github.com/emscripten-core/emsdk.git
cd emsdk/
git pull
./emsdk install latest
./emsdk activate latest
exit
groups gertjan 
exit
sudo dnf search fonts
dnf search roboto
sudo dnf install google-roboto-fonts
sudo dnf install google-roboto-mono-fonts
sudo dnf autoremove google-roboto-mono-fonts
flatpak install Spotify
flatpak install drawio gaphor
flatpak update
sudo flatpak update
exit
cat /proc/sys/fs/inotify/max_user_watches
exit
sudo dnf install wireshark nmap
powerprofilesctl 
exit
nvim Documents/fedora_init.sh
nvim Documents/fedora_init.txt
nvim Documents/fedora_init.sh
nvim .config/nvim/lua/lsp-config.lua 
nvim Documents/fedora_init.sh
nvim .config/nvim/lua/lsp-config.lua 
nvim Documents/fedora_init.sh
rm Documents/fedora_init.sh 
exit
podman --version
exit
history | grep dnf
xit
exit
htop
top
exit
pip install numpy
pip install abc
pip update
pip install update
exit
flatpak install kvantum
exit
dnf search wget2
exit
nvim .scripts/sources 
exit
sudo dnf update --refresh
exit
update
nvim .scripts/sources 
exit
nvim .scripts/sources 
exit
sudo flatpak remove --all
sudo flatpak install Spotify
echo $PATH
echo $XDG_DATA_DIRS 
sudo flatpak install gaphor drawio
~exit
exit
htop
sudo dnf install htop
htop
exit
sudo dnf update --refresh
exit
python main.py
cd Dev/
ls
mkdir TelegramBot
cd TelegramBot/
nvim main.lpy
nvim main.py
exit
podman search 
podman search ubuntu
podman search debian
podman search postgres
pip install python-telegram-bot --upgrade
exit
pip install 'python-lsp-server[all]'
exit
npm install -g pyright
sudo dnf install npm
npm install -g pyright
pip hlep
pip help
pip uninstall python-language-server[all]
pip uninstall 'python-lsp-server[all]'
exit
sudo npm install -g pyright
exit
nvim ~/.config/nvim/lua/lsp-config.lua 
exit
cd Dev/TelegramBot/
nvim main.py
exit
cd Dev/TelegramBot/
ls
nvim main.py
exit
cd Dev/
rm -rf TelegramBot/
ls
exit
ll
ls
exit
cd Dev/
ls
cd CO
cd ContainerScripts/
python main.py
exit
main.py
ll
exit
git init 
cd Dev/
ls
mkdir SomePython
cd SomePython/
ls
ll
nvim 
nvim main.py 
cd ../
mv SomePython/ NotePython
ls
cd NotePython/
ls
nvim main.py 
git status
git add -A
git commit -m "initial setup"
git config --global user.email gertjan.rolink@outlook.com
git config --global user.name Deedss
git commit -m "initial setup"
git push
git push 
git remote add origin git@github.com:Deedss/NotePython.git
git push
git push --set-upstream origin master 
git push
git push --set-upstream origin master 
git -b main
git checkout -b main
git push
git push --set-upstream origin main
git pull
git push --set-upstream origin main
git fetch
git push --set-upstream origin main
git push --set-upstream origin main --force
git branch rm master origin/master 
git branch -d master 
git push
git remote remove master
git remote remove -b master
git remote remove origin/master
git push origin --delete origin/master 
git push origin --delete master
exit
sudo npm i -g bash-language-server
exit
shutdown 0
exit
sudo nvim /etc/systemd/logind.conf 
exit
cd Dev/NotePython/
git pull
exit
sudo systemctl status packagekit
sudo systemctl disable packagekit
sudo systemctl status packagekit
sudo systemctl status packagekit.service 
sudo systemctl status packagekit-offline-update.service 
sudo systemctl disable packagekit-offline-update.service 
reboot
sudo systemctl status packagekit*
sudo systemctl status packagekit
sudo systemctl status packagekit-offline-update.service 
exit
conservation-mode 
exit
update
exit
shutdown 0
cd .ssh/
ls
rm id_*
ls
rm known_hosts 
ls
rm *
ls
ssh-add -D
ssh-keygen -t ed25519 -C gertjan.rolink@outlook.com
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
ssh -T git@github.com
exit
cd Dev/NotePython/
ls
git pull
exit
rustup list
rustup component 
rustup component list
rustup component add rust-analyzer
rustup component remove rls
$ chmod +x ~/.local/bin/rust-analyzer
chmod +x ~/.local/bin/rust-analyzer
echo $PATH
rust-analyzer --version
exit
nvim .config/nvim/lua/lsp-config.lua 
cd Dev/
mkdir RustEx
cd RustEx/
nvim main.rs
cd ../
rmdir RustEx/
ls
exit
cd ~
ls
cd .config/nvim/lua/
ls
nvim my_mappings.lua 
exit
nvim .config/nvim/lua/plugins.lua 
nvim 
nvim
cd Dev/NotePython/
ls
nvim main.py 
exit
cd Dev/NotePython/
ls
nvim main.py 
exit
nvim
exit
cd ~/.config/nvim/
cd lua/
nvim telescope_mappings.lua 
exit
nvim .config/nvim/lua/plugins.lua 
cd Dev/n
cd Dev/NotePython/
ls
nvim main.py
exit
nvim .config/nvim/lua/telescope_mappings.lua 
exit
sudo dnf install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
l
exit
sudo dnf install ffmpeg
exit
sudo dnf autoremove materia-*
exit
dotnet --help
exit
ll
sudo dnf autoremove dotnet--sdk-3.1
sudo dnf autoremove dotnet-sdk-3.1
exit
dnf list installed java-*
sudo dnf autoremove java-11-openjdk-jmods
sudo dnf autoremove java-11-openjdk*
sudo dnf install lua 
sudo dnf install java-11-openjdk
sudo dnf install stow
vim --version
git remove -v
git remote -v
git remote add origin git@github.com:Deedss/dotfiles.git
cd .dot
exit
stow zsh
exit
ll
exit
conservation-mode 
exit
ll
cd .dotfiles/
ll
git statu
git status
git diff scripts/.scripts/sources
ll
git status
git add .
git commit -m "removed dotnet/omnisharp"
git push
exit
ll
full_update 
exit
nvim .config/nvim/lua/lsp-config.lua 
nvim .scripts/sources 
exit
sudo dnf install dotnet
dotnet --version
exit
ll
exit
l
exit
cd .dotfiles/
ll
git status
git add .
git commit -m "update"
git diff
git diff nvim/.config/nvim/lua/lsp-config.lua
git push
exit
nvim .scripts/sources 
exit
nvim .config/nvim/lua/lsp-config.lua 
nvim
full_update 
exit
nvim
exit
nvim .config/nvim/lua/nvim-cmp.lua 
shutdown 0
cd .dotfiles
git status
git add .
git commit -m "test.vim was for trying out vscode/neovim plugin"
git push
full_update 
reboot
/bin/python /home/gertjan/Dev/LearningPython/NoteCmd/note.py
/bin/python
exit
cd NoteCmd/
python note.py 
python --debug note.py 
python -h
ll
python -d note.py 
python note.py 
exit
cd Dev/LearningPython/
ll
nvim NoteCmd/note.py 
l
exit
exit
full
full_update 
ffplay -o /dev/video
ffplay /dev/video
ffplay /dev/video0
ffplay --help /dev/video0 
exit
full
full_update 
cd .dotfiles/
ll
git status
cd ../Dev/LearningPython/
ll
git status
git add .
git commit -m "upd"
git push
cd ../
ll
cd Rust/
cd ../Scripts/
ll
exit
sudo dnf autoremove code
sudo dnf install code
echo $SHELL
echo $TERM 
echo $TERMINAL
ll
git status
exit
git add .
git commit - m 'Up"
'
git commit - m "upd"
git status
git push
git statsu
git status
git commit -m "update"
git push
exit
git add .
git commit -m "remove some stuff"
git push
cd NO
cd NoteCmd/
ll
python -d note.py 
pdb note.py
python
python note.py 
python -d note.py 
pdb note.py 
python -m pdb note.py 
exit
cd Dev/LearningPython/
nvim NoteCmd/note.py 
exit
cd NoteCmd/
ll
python -m pdb note.py 
exit
cd .config/nvim/
nvim lua/plugins.lua 
nvim
nvim lua/nvim-dap.lua 
nvim
exit
nvim 
exit
full_update 
cd Dev/LearningPython/
cd NoteCmd/
ll
nvim note.py 
exit
cd Dev/LearningPython/
nvim 
cd NoteCmd/
nvim note.py 
cd ~/.config/nvim/
cd lua/
nvim nvim-dap.lua 
nivm
nvim
nvim nvim-dap.lua 
exit
cd Dev/LearningPython/NoteCmd/
ll
nvim note.py 
ll
exit
cd .dot
cd .dotfiles/
ll
git status
git add .
git commit -m "initial setup of nvim-dap"
git push
exit
ll
python --version
pip install
pip help
sudo dnf install bash-copmletions
sudo dnf install bash-completions
sudo dnf search bash-completion
sudo dnf install bash-completion
exit
pip --help
$ sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
ll
ls
exit
cd ~
ll
nvim .zshrc.omz-uninstalled-2021-10-13_21-04-56 
cd Dev/LearningPython/
ll
