# HGL/Blueprint

Print your workstation wherever you. The same thing, the same way, every time.

Supports Linux, macOS and Windows native and WSL2 and Docker container.

# Getting Started
## Linux
```
sudo -v
# In Debian/Ubuntu add your the user to sudo group:
usermod -aG sudo
./bootstrap-Linux.sh
# Checkout your `.blueprint` settings.
git clone git@github.com:YOURUSER/.blueprint.git ~/.blueprint
sudo -v
ansible-playbook -i inventory.py main.yaml
sudo -K
```

Caution: Don't run ansible process in root!
And don't forget to close your session if `sudo` is not needed anymore.

## Windows
To let ansible configure the windows node,
run this as Administrator in PowerShell on a fresh installed Windows node:
```
iex (iwr "https://raw.githubusercontent.com/evgnomon/blueprint/winboot/bootstrap-Windows.ps1")
```
Which restarts the Windows machine after installation.

To run WSL inside Hyper-V VM, enable nested virtualization in the host:
```
Set-VMProcessor -VMName "Windows 11" -ExposeVirtualizationExtensions $true
```
Install Ubuntu 24.04 from Microsoft Store:
```
wsl --install -d Ubuntu-24.04
```


Try `ssh` to the Windows node to verify the bootstrap:
```
ssh YOUR_USER@WIN_NODE -t powershell.exe
```
Which the ip address is printed by the bootstrap script.

Share the YubiKey with WSL2 for Windows,
Using an admin shell run this to install your Security,
```
# winget install usbipd
usbipd bind -i your_device_id
usbipd attach --wsl -i your_device_id
```

find the device id using `usbipd.exe list`.

## Hyper-V
Port forwarding should be enabled in host to configure Hyper-V VMs:
```
Get-NetIPInterface | where {$_.InterfaceAlias -eq 'vEthernet (WSL (Hyper-v firewall))' -or $_.InterfaceAlias -eq 'vEthernet (Default Switch)'} | Set-NetIPInterface -Forwarding Enabled
```


## MacOS
Install XCode 15 or higher from App Store. Then open XCode and install macOS SDK.

Docker has to be manually copied from attached disk image. This is to keep Alacritty unauthorized to access user `Applications`.

Make sure the computer doesn't sleep during the installation. We recommend to disable sleep after display off when connected to power.

# Vim Plugins

Run this after installation in vim to setup vim plugins:

```
:PlugInstall
```

# License
HGL, verified:
```
shasum -a 512 -c SHA512SUMS
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
sudo -v
ansible-playbook -i inventory.py main.ymal
sudo -K
```

# Secret Rotation

To rotate secrets, use `ansible-vault`:

```
ANSIBLE_VAULT_PASSWORD_FILE=<(vault -d vault) ansible-playbook -i inventory.py rotate.yaml

# or in Fish:
ANSIBLE_VAULT_PASSWORD_FILE=(vault -d vault | psub) ansible-playbook -i inventory.py rotate.yaml
```
