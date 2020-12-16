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