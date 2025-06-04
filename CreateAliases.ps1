Add-Alias touch 'New-Item -ItemType File'
Add-Alias g 'git'

function glog {
	git log --oneline -$args
}