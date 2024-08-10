# 🎃 Arquivos do Powershell

Este repositório contém algumas funções e módulos que normalmente uso no Powershell.

Para instalar, execute:

## Pré-requisitos

1. Git

    ```pwsh
    winget install -e --id Git.Git --accept-package-agreements
    ```

1. Powershell

    ```pwsh
    winget install -e --id Microsoft.PowerShell --accept-package-agreements
    ```

## Instalação

1. Clonar o repositório

    ```pwsh
    git clone --recursive https://github.com/jfbueno/posh-files.git $env:UserProfile/Documents/PowerShell
    ```

1. Após clonar o repositório, executar os scripts de instalação usando o Powershell

    1. NerdFonts - Necessário para exibição do tema do OhMyPosh

        ```pwsh
        cd $env:UserProfile/Documents/Powershell
        ./Install-Fonts.ps1
        ```

    1. Instalar os pacotes e módulos do Powershell 

        ```pwsh   
        ./Install.ps1
        ```

    1. Criar symlinks de configurações (git e Windows Terminal)

        ```pwsh
        ./SetupConfig.ps1
        ```