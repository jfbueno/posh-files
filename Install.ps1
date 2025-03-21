winget install -e --id Microsoft.WindowsTerminal
winget install JanDeDobbeleer.OhMyPosh --source winget
winget install bat --source winget
winget install dandavison.delta --source winget
winget install notepad++ --source winget
winget install --id Microsoft.PowerToys --source winget

Install-Module posh-git -Scope CurrentUser
Install-Module posh-cli -Scope CurrentUser

Install-TabCompletion

Install-Module posh-dotnet
Install-Module DockerCompletion
Install-Module PSKubectlCompletion