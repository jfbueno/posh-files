Add-Alias touch 'New-Item -ItemType File'

function glog {
	git log --oneline -$args
}