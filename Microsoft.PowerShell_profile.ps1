$root = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$localModulesDir = Join-Path $root Modules

Import-Module PSReadline

Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

Import-Module "$localModulesDir/posh-alias"

if (-Not (Get-Module -ListAvailable -Name posh-git)) {
    Install-Module posh-git -Scope CurrentUser -AllowPrerelease -Force
}
Import-Module posh-git

oh-my-posh --init --shell pwsh --config "$root/Themes/my-themes/default.omp.json" | Invoke-Expression

$env:POSH_GIT_ENABLED = $true

. "$root/GitFlowIepro.Functions.ps1"
. "$root/CreateAliases.ps1"