function IeproFlow-Help() {
    Write-Host "New-FeatureBranch" -ForegroundColor Yellow -NoNewline
    Write-Host " (alias: new-ft)`n  Cria uma nova feature branch"`n    

    Write-Host "New-TaskBranch" -ForegroundColor Yellow  -NoNewline
    Write-Host " (alias: new-tsk)`n  Cria uma nova branch de tarefa"`n 
    
    Write-Host "Checkout-FeatureBranch" -ForegroundColor Yellow -NoNewline
    Write-Host " (alias: co-ft)`n  Faz checkout para feature branch especificada"`n  

    Write-Host "Checkout-TaskBranch" -ForegroundColor Yellow -NoNewline
    Write-Host " (alias: co-tsk)`n  Faz checkout para a branch de tarefa especificada"`n

    Write-Host "Rebase-From-Origin" -ForegroundColor Yellow -NoNewline
    Write-Host " (alias: rbo)`n  Faz rebase de origin/[branch] para [branch] onde [branch] é o nome da branch atual"`n

    Write-Host "Rebase-From-Main" -ForegroundColor Yellow -NoNewline
    Write-Host " (alias: rbd)`n  Faz rebase da main para a branch atual"`n

    Write-Host "Rebase-From-Feature" -ForegroundColor Yellow -NoNewline
    Write-Host " (alias: rbft)`n  Faz rebase da feature branch para a branch atual"`n

    Write-Host "Para informações sobre uma função específica (como definição de parâmetros), execute o comando Get-Help NomeDaFuncao"
}

function new-ft {
    New-FeatureBranch @args
}

function new-tsk {
    New-TaskBranch @args
}

function co-ft {
    Checkout-FeatureBranch @args
}

function co-tsk {
    Checkout-TaskBranch @args
}

function rbo {
    Rebase-From-Origin
}

function rbm {
    Rebase-From-Main
}

function rbft {
    Rebase-From-Feature
}

<#
    .Synopsis
    Cria uma nova feature branch no formato story-[IdFeature]/feature

    .Parameter feature
    Id da feature

    .Parameter from
    Define a branch que será usada como origem para criar a nova branch. 
    Se não for informada, toma 'main' como padrão
#>
function New-FeatureBranch {
    param (
        [Parameter(Mandatory = $true)]
        [int]$feature,
        [Parameter(Mandatory = $false)]
        [string]$from = 'main'
    )
    git checkout -b "us-$feature/feat" $from
}

<#
    .Synopsis
    Cria uma nova feature branch de tarefa no formato story-Id/task/[Tarefa].
    É possível especificar a feature de origem usando o parâmetro -feature ou criar automaticamente com base na branch atual desde que ela respeite o padrão story-id/feature. 
    Também é possível criar a feature (a partir da main) usando o switch -createFeature

    .Parameter task
    Id da tarefa

    .Parameter feature
    [Opcional] Id da feature que a tarefa pertence. 
    Caso não seja informado será usada a branch atual (desde que ela respeite o padrão de nome de uma feature).
    Caso seja informado, mas a feature não existir será retornado um erro, a não ser que seja usado o switch -createFeature

    .Parameter createFeature
    [Opcional] Define se a branch feature deve ser criada também (com base na branch 'main')
#>
function New-TaskBranch {
    param (
        [Parameter(Mandatory = $true)]
        [Alias("t")]
        [int]$task,
        [Parameter(Mandatory = $false)]
        [Alias("f")]
        [int]$feature,
        [Parameter(Mandatory = $false)]
        [Alias("c")]
        [switch]$createFeature
    )

    if (!$feature) {
        $featureBranch = Get-Current-Feature
        if (!$featureBranch) {
            Write-Error "Não foi possível identificar a feature de origem."
            Return
        }

        $featurePrefix = $featureBranch.Replace('/feat', '')
    }
    else {
        $featurePrefix = "us-$feature"
        $featureBranch = "$featurePrefix/feat"

        $featureCommit = $(git rev-parse --verify --quiet $featureBranch)

        if (!$featureCommit) {
            if ($createFeature) {
                New-FeatureBranch $feature 'main'
            }
            else {
                Write-Error "Não foi possível encontrar a branch feature $featureBranch. Para criá-la use o mesmo comando com o parâmetro -createFeature"
                Return
            }
        }
    }
    
    git checkout -b "$featurePrefix/task-$task" $featureBranch
}

<#
    .Synopsis
    Faz checkout para a feature branch informada ou para a feature branch referente à branch atual
    
    .Parameter feature
    (Opcional) Id da feature. Caso não seja informado, a feature branch será inferida a partir da
    branch atual (desde que ela siga o padrão story-[IdFeature]/task/[IdTask])    
#>
function Checkout-FeatureBranch {
    param (
        [Alias("f")]
        [int]$feature
    )

    if (-Not $feature) {
        $featureBranchName = Get-Current-Feature

        if (-Not $featureBranchName) { 
            Return
        }

        git checkout $featureBranchName
        Return
    }

    git checkout "us-$feature/feat"
}

<#
    .Synopsis
    Faz checkout para a task branch informada

    .Parameter task
    Id da task

    .Parameter feature
    (Opcional) Id da feature. Caso não seja informado, a feature branch será inferida a partir da
    branch atual (desde que ela siga o padrão story-[IdFeature]/task/[IdTask])
#>
function Checkout-TaskBranch {
    param (
        [Parameter(Mandatory = $true)]
        [Alias("t")]
        [int]$task,
        [Alias("f")]
        [int]$feature
    )

    if (!$feature) {
        $featureBranch = Get-Current-Feature

        if (!$featureBranch) {
            Write-Error "Não foi possível identificar a feature de origem. É preciso especificá-la usando o parâmetro -feature ou fazer um checkout para a branch"
            Return
        }

        $featurePrefix = $featureBranch.Replace('/feat', '')
    }
    else {
        $featurePrefix = "us-$feature"
    }

    git checkout "$featurePrefix/task-$task"
}

<#
    .Synopsis
    Faz rebase de origin/[Branch] para [Branch] onde [Branch] é o nome da branch atual
#>
function Rebase-From-Origin {
    $branch = Get-Current-Branch-Name

    git rebase "origin/$branch"
}

<#
    .Synopsis
    Faz rebase da main para a branch atual

    .Parameter origin
    (Opcional) Se informado o rebase é feito da origin/main. Caso contrário, é feito da main
#>
function Rebase-From-Main {
    param (
        [Parameter(Mandatory = $false)]
        [Alias("o")]
        [switch] $origin
    ) 

    $branch = "main"
    if ($origin) {
        $branch = "origin/main"
    }
    
    git rebase $branch
}

<#
    .Synopsis
    Faz rebase da feature branco para a branch atual

    .Parameter origin
    (Opcional) Se informado o rebase é feito da origin. Caso contrário, é feito da branch local.
#>
function Rebase-From-Feature {
    param (
        [Parameter(Mandatory = $false)]
        [Alias("o")]
        [switch] $origin
    ) 

    $branch = Get-Current-Feature

    if ($origin) {
        $branch = "origin/$branch"
    }

    git rebase $branch
}

function Get-Current-Feature {
    $currentBranch = Get-Current-Branch-Name

    if ($currentBranch -Match "us-(\d+)/feat") {
        Return $currentBranch
    }

    if ($currentBranch -Match "us-(\d+)/task-(\d+)") {
        $featurePrefix = [regex]::Match($currentBranch, 'us-(\d{1,})/').Groups[0].Value
        $featureBranch = -Join ($featurePrefix, 'feat')

        if (-Not $(git show-ref "refs/heads/$featureBranch")) {
            Write-Error "Branch $featureBranch não encontrada"
            Return
        }

        Return $featureBranch
    }

    Return
}

function Get-Current-Branch-Name {
    Return $(git rev-parse --abbrev-ref HEAD)
}