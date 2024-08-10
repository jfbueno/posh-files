#Requires -RunAsAdministrator

$fontUrl = "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/CascadiaCode.zip"
$regKey = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts"

$tempPath = "${env:Temp}/init-script"
$extractedFontsFolder = "$tempPath/cascadia"
$tempFontsPath = "$tempPath/cascadia-kove.zip"

$systemFontsPath = "${env:SystemRoot}\Fonts"

Write-Host "Baixando fonte de $fontUrl"

Remove-Item -Recurse $tempPath
New-Item -Path $extractedFontsFolder -ItemType Directory -Force | Out-Null 
Invoke-WebRequest -Uri $fontUrl -OutFile $tempFontsPath

Write-Host "Extraindo fontes em $extractedFontsFolder"

Expand-Archive -Path $tempFontsPath `
    -DestinationPath $extractedFontsFolder -Force

$fontFiles = Get-ChildItem -Path $extractedFontsFolder -Filter *.ttf

foreach ($fontFile in $fontFiles) {
    Copy-Item -Path $fontFile.FullName -Destination $systemFontsPath
    $fontName = $fontFile.BaseName
    
    Write-Host "Registrando fonte '$fontName'"

    Set-ItemProperty -Path $regKey -Name $fontName `
        -Value $fontFile.Name
}

