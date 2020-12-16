$root = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$localModulesDir = Join-Path $root Modules

Import-Module PSReadline

Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler –Key DownArrow -Function HistorySearchForward

Import-Module "$localModulesDir/posh-alias"
Import-Module "$localModulesDir/posh-git/src/posh-git.psd1"

if (-Not (Get-Module -ListAvailable -Name oh-my-posh)) {
    Install-Module oh-my-posh -Scope CurrentUser -AllowPrerelease -Force
}
Import-Module oh-my-posh
Set-PoshPrompt powerlevel10k_classic

. "$root/GitFlowIepro.Functions.ps1"
. "$root/CreateAliases.ps1"