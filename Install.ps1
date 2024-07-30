winget install JanDeDobbeleer.OhMyPosh --source winget
winget install bat --source winget

Install-Module posh-git -Scope CurrentUser -AllowPrerelease -Force
Install-Module posh-cli -Scope CurrentUser    

Install-TabCompletion

Install-Module posh-dotnet
Install-Module DockerCompletion
Install-Module PSKubectlCompletion

# TODO: install nerd-font
# Trocar as cores do terminal