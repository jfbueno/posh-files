$root = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$localModulesDir = Join-Path $root Modules

Import-Module PSReadline

Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler –Key DownArrow -Function HistorySearchForward

Import-Module "$localModulesDir/posh-git/src/posh-git.psd1"
Import-Module "$localModulesDir/posh-alias"
Import-Module "$localModulesDir/oh-my-posh"

Set-Theme Paradox.Jefh

$DefaultUser = 'jeferson.bueno'

. "$root/GitFlowIepro.Functions.ps1"
. "$root/CreateAliases.ps1"