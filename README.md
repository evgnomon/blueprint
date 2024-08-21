# HGL/Blueprint

Print your workstation wherever you. The same thing, the same way, every time.

Supports Linux, macOS and Windows native and WSL2 and Docker container.

# Getting Started
```
sudo -v
# In Debian/Ubuntu add your the user to sudo group:
usermod -aG sudo
./bootstrap-Linux.sh
# Checkout your `.blueprint` settings.
git clone git@github.com:YOURUSER/.blueprint.git ~/.blueprint
ansible-playbook -i inventory --ask-become-pass main.yaml
```

Caution: Don't run ansible process in root!
And don't forget to close your session if `sudo` is not needed anymore.

# Coc Plugins

Run this after installation in vim to setup vim plugins:

```
:PlugInstall
```

# MacOS
Install XCode 15 or higher from App Store. Then open XCode and install macOS SDK.

Docker has to be manually copied from attached disk image. This is to keep Alacritty unauthorized to access user `Applications`.

Make sure the computer doesn't sleep during the installation. We recommend to disable sleep after display off when connected to power.

# License
HGL, verified:
```
shasum -a 512 -c SHA512SUMS
```

# Security Key
Share the YubiKey with WSL2 for Windows:

Using an admin shell run this:
```
# winget install usbipd
usbipd bind -i 1050:0407
usbipd attach --wsl -i 1050:0407
```

Which is the device if of the YubiKey, find the device id using:
```
usbipd list
```


Use YubiKey for password less `sudo`:

```
mkdir -p ~/.config/Yubico
pamu2fcfg > ~/.config/Yubico/u2f_keys
pamu2fcfg -n >> ~/.config/Yubico/u2f_keys # with the spare key
sudo mv ~/.config/Yubico/u2f_keys /etc/Yubico/u2f_keys
sudo chown root:root -R /etc/Yubico/u2f_keys
```
Add a new key using:
```
pamu2fcfg -n | sudo tee -a /etc/Yubico/u2f_keys
```

# Git signing

Add pubkeys to `allowed_signers` for git verification:
```
echo "$(git config --get user.email) namespaces=\"git\" $(cat ~/.ssh/vortex.pub)" >> ~/.ssh/allowed_signers
```

# Windows
Run ansible in WSL2 for to run ansible on Windows native host:
```
export WIN_USER=YOUR_WINDOWS_USER
ansible-playbook -i inventory -e ansible_become_user=$WIN_USER -e ansible_user=$WIN_USER -e ansible_python_interpreter="C:\Users\$WIN_USER\.pyenv\pyenv-win\versions\3
.12.0\python.exe" main-Windows.yml
```

# Secret Rotation

To rotate secrets, use `ansible-vault`:

```
ANSIBLE_VAULT_PASSWORD_FILE=<(vault -d vault) ansible-playbook -i inventory rotate.yaml

# or in Fish:
ANSIBLE_VAULT_PASSWORD_FILE=(vault -d vault | psub) ansible-playbook -i inventory rotate.yaml
```
