$ansiCodes = @(30..37) + (90..97)
foreach ($code in $ansiCodes) {
    $esc = [char]27
    Write-Host "$esc[${code}m ANSI $code - Teste de cor $esc[0m"
}
