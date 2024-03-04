<p align="center">
<img src="docs/assets/blueprint.png" width="256" height="256">
</p>

Blueprint prints your workstations on top of Linux, macOS and Windows using Ansible. This enables smooth transition for the user to a new machine or between existing machines.

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

# YubiKey
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
