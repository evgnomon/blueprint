<p align="center">
<img src="docs/assets/blueprint.png" width="256" height="256">
</p>

Blueprint prints your workstations on top of Linux, macOS and Windows using Ansible. This enables smooth transition for the user to a new machine or between existing machines.

# Getting Started
```
sudo ls # to let ansible become root when needed
ansible-playbook -i inventory main.yaml
```

# Coc Plugins

Run this after installation in vim to setup vim plugins:

```
:PlugInstall
:CocInstall coc-rust-analyzer coc-prettier coc-tsserver coc-go coc-pyright coc-snippets coc-go
```

# MacOS
Install XCode 15 or higher from App Store. Then open XCode and install macOS SDK.

# License
HGL, verified:
```
shasum -a 512 -c SHA512SUMS
```
