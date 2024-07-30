$root = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$localModulesDir = Join-Path $root Modules

Import-Module PSReadline

Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

Import-Module "$localModulesDir/posh-alias"
Import-Module posh-git
Import-Module posh-dotnet
Import-Module DockerCompletion
Import-Module PSKubectlCompletion

oh-my-posh init pwsh --config "$root/Themes/my-themes/jef-simple.omp.json" | Invoke-Expression

$env:POSH_GIT_ENABLED = $true

Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
    param($commandName, $wordToComplete, $cursorPosition)
        dotnet complete --position $cursorPosition "$wordToComplete" | ForEach-Object {
           [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
}

. "$root/GitFlowAbc.Functions.ps1"
. "$root/CreateAliases.ps1"