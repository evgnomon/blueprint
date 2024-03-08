<p align="center">
<img src="docs/assets/evgnomon.svg" width="256" height="256">
</p>

HGL/Blueprint configures a dev workstation for Linux, macOS and Windows (WSL2) using Ansible. The project enables smooth transition for the user to a new machine or between existing machines which makes the machine and the operating system a plugable resource. Blueprint runs inside a container to provide a consistent virtual environment for the user in the cloud. This project is part of HGL/Zygote project to extend the concept of dev workstation to the cloud and to the edge. Using Blueprint, the user can easily switch between different cloud providers and edge devices without changing the development environment.

# Getting Started
```
sudo ls # to let ansible become root when needed
# In Debian/Ubuntu add your the user to sudo group:
usermod -aG sudo
./bootstrap-Linux.sh
# Checkout your `.blueprint` settings.
git clone git@github.com:evgnomon/.blueprint.git ~/.blueprint
ansible-playbook -i inventory --ask-become-pass main.yaml
```

Caution: Don't run ansible process in root!
And don't forget to close your session if `sudo` is not needed anymore.

# Coc Plugins

Run this after installation in vim to setup vim plugins:

```
:PlugInstall
:CocInstall coc-rust-analyzer coc-prettier coc-tsserver coc-go coc-pyright coc-snippets coc-go
```

# MacOS
Install XCode 15 or higher from App Store. Then open XCode and install macOS SDK.

Docker has to be manually copied from attached disk image. This is to keep Alacritty unauthorized to access user `Applications`.

# License
HGL, verified:
```
shasum -a 512 -c SHA512SUMS
```

# Security Pass
Share the YubiKey with WSL2 for Windows:
https://learn.microsoft.com/en-us/windows/wsl/connect-usb

Use YubiKey for password less `sudo`:

```
mkdir -p ~/.config/Yubico
pamu2fcfg > ~/.config/Yubico/u2f_keys
pamu2fcfg -n >> ~/.config/Yubico/u2f_keys # with the spare key
sudo mv ~/.config/Yubico/u2f_keys /etc/Yubico/u2f_keys
sudo chown root:root -R /etc/Yubico/u2f_keys
```
