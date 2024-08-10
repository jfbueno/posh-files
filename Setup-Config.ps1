#Requires -RunAsAdministrator

New-Item -ItemType SymbolicLink `
    -Target $env:USERPROFILE/Documents/Powershell/Configs/.gitconfig `
    -Path ~/.gitconfig

$packagesPath = "$env:LOCALAPPDATA\Packages"
$terminalPath = Get-ChildItem -Path $packagesPath -Directory `
    | Where-Object { $_.Name -like "Microsoft.WindowsTerminal*" }

New-Item -ItemType SymbolicLink `
    -Target $env:USERPROFILE/Documents/Powershell/Configs/terminal-settings.json `
    -Path $terminalPath/LocalState/settings.json `
    -Force