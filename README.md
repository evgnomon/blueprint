# HGL/Blueprint

Print your workstation wherever you. The same thing, the same way, every time.

Supports Linux, macOS and Windows native and WSL2 and Docker container.

# Getting Started
```
sudo ls # to let ansible become root when needed
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

# Security Key
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

# Windows
Run ansible in WSL2 for to run ansible on Windows native host:
```
export WIN_USER=YOUR_WINDOWS_USER
ansible-playbook -i inventory -e ansible_become_user=$WIN_USER -e ansible_user=$WIN_USER -e ansible_python_interpreter="C:\Users\$WIN_USER\.pyenv\pyenv-win\versions\3
.12.0\python.exe" main-Windows.yml
```
