#!/bin/bash

sudo apt update && sudo apt install -y git

function install_pyenv(){
	git clone https://github.com/pyenv/pyenv.git ~/.pyenv
	echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
	echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
	echo 'eval "$(pyenv init -)"' >> ~/.bashrc

	PYENV_ROOT="$HOME/.pyenv"
	export PATH="$PYENV_ROOT/bin:$PATH"
	eval "$(pyenv init --path)"
}


[ ! ~/.pyenv ] && install_pyenv


sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev curl libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev linux-tools-virtual hwdata yubikey-manager scdaemon scdaemon ykcs11 libpcsclite-dev swig pcscd libpam-u2f pinentry-tty libpam-yubico usbutils unzip

sudo update-alternatives --install /usr/local/bin/usbip usbip $(command -v ls /usr/lib/linux-tools/*/usbip | tail -n1) 20
curl -sSL https://raw.githubusercontent.com/Yubico/libfido2/main/udev/70-u2f.rules | sudo tee /etc/udev/rules.d/70-u2f.rules > /dev/null

PYTHON_CONFIGURE_OPTS="--enable-shared" pyenv install 3.12.0 2.7.18
pyenv global 3.12.0 2.7.18
pip install --upgrade pip
pip install --upgrade ansible pyyaml

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"
[ ! -d $HOME/.local/bin ] && mkdir -p $HOME/.local/bin


echo '
polkit.addRule(function(action, subject) {
    if ((action.id == "org.debian.pcsc-lite.access_pcsc" || action.id == "org.debian.pcsc-lite.access_card" ) && subject.isInGroup("plugdev")) {
        return polkit.Result.YES;
    }
    
});
' | sudo tee /etc/polkit-1/rules.d/90-pcscd.rule > /dev/null
