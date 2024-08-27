$username = Read-Host "Enter the new username"
$password = Read-Host "Enter new password" -AsSecureString 
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'
winget install --accept-source-agreements --accept-package-agreements --disable-interactivity --uninstall-previous -e --id dorssel.usbipd-win
winget install --accept-source-agreements --accept-package-agreements --disable-interactivity --uninstall-previous -e --id Python.Python.3.12
$passwordPlain = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))
net user $username $passwordPlain
net user /add $username
net localgroup Administrators $username /add
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
Set-ExecutionPolicy RemoteSigned
wsl --install -d Ubuntu-24.04
