Add-Alias co 'git checkout'
Add-Alias gst 'git status'
Add-Alias grb 'git rebase'
Add-Alias glg 'git log --oneline -10'
Add-Alias fetch 'git fetch'
Add-Alias push 'git push'
Add-Alias pull 'git pull'
Add-Alias pushsync 'git push --set-upstream origin HEAD'
Add-Alias fush 'git push --force-with-lease'

function glog {
	git log --oneline -$args
}

function cg-th() {
	Change-Theme
}

<#
    .Synopsis
    Altera para um tema do OMP menos poluído 
#>
function Change-Theme(){
	(@(& 'C:/Users/bueno/AppData/Local/Programs/oh-my-posh/bin/oh-my-posh.exe' init pwsh --config='C:\Users\bueno\AppData\Local\Programs\oh-my-posh\themes\craver.omp.json' --print) -join "`n") | Invoke-Expression
}