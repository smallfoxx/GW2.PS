<#
.SYNOPSIS
Get total count of Imperial Favor on account
.PARAMETER TargetFavor 
How many Imperial Favors your aiming to get
.PARAMETER IncludeCharacterInventory
This will go through the bags of all your characters. WARNING!! This can cause quite a delay from the API
.PARAMETER IncludeDetail
Grab the details about the items as well.
.PARAMETER FilePath
Path to a file to put the remaining total in
.PARAMETER ReplaceFilter
RegEx filter to use to find string to replace
.PARAMETER ReplaceFormat
String used to place content into file. {0} represents remaining amount, {1} is first match in $ReplaceFilter
#>
param([int]$TargetFavor = 10000,
    [switch]$IncludeCharacterInventory,
    [switch]$IncludeDetail,
    [string]$FilePath,
    [string]$ReplaceFilter="(To Go:\D*)(\d+)",
    [string]$ReplaceFormat="{1}{0}")

If (-not (Get-Module -ListAvailable GW2.PS.API)) {
    Write-Warning "GW2.PS.API Module not found on local system"
    $response = Read-Host "Install GW2.PS.API from PowerShellGallery? (y/N)"
    If ($response -match "^y") {
        Install-Module -Name GW2.PS.API -Force
    } else {
        Write-Error "Module not available. Come back after installing GW2.PS.API"
        break
    }
}

Import-Module GW2.PS.API
If (-not (Get-GW2APIKey)) {
    Write-Warning "APIKey missing. You will need an API Key from Arena Net account with access to your account."
    Set-GW2APIKey
}

$ImperialFavorID = '97233'
$ImperialFavorCurrID = '68'
$WritIDs = @('95692', '96561', '96533', '96680')

$All = @{
    'Favors'=@{}
    'Writs'=@{}
}
$Wallet = Get-GW2AccountWallet
$All.Favors.Wallet = ($Wallet | Where-Object { $_.ID -eq $ImperialFavorCurrID }).Value

$Bank = Get-GW2AccountBank

$All.Favors.Bank = $Bank | ? { $_.Id -eq $ImperialFavorID }
$All.Writs.Bank = $Bank | ? { $_.Id -in $WritIDs }
$All.Writs.Material = Get-GW2AccountMaterial |? { $_.id -in $WritIDs }

If ($IncludeCharacterInventory) {
    $Characters = Get-GW2Character
    $Inventories = @{}
    ForEach ($Char in $Characters) {
        $Inventories.$Char = Get-GW2CharacterInventory -CharacterID $Char
    }
    $All.Writs.Bags = $Inventories.Values.Bags.Inventory | ?{ $_.ID -in $WritIDs }
    $All.Favors.Bags = $Inventories.Values.Bags.Inventory | ?{ $_.ID -in $ImperialFavorID }
}

$Total = [PSCustomObject]@{
    'Favors' = $All.Favors.Wallet +  (@($all.Writs.'Bags',$all.writs.'bank') | measure-object -sum -Property Count).Sum
    'Writs' = ($All.Writs.values | %{ $_  } | Measure-Object -Sum -Property Count).Sum
    'Target' = $TargetFavor
}

$Total | Add-Member ScriptProperty Complete { $this.Favors + $this.Writs*5 } -Force
$Total | Add-Member ScriptProperty Remaining { $this.Target - $this.Complete }

If ($IncludeDetail) {
    $Total | Add-Member NoteProperty Details ([PSCustomObject]@{
        'ImperialFavor' = Get-GW2Item -Id $ImperialFavorID
        'CurrencyIF' = Get-GW2Currency -id $ImperialFavorCurrID
        'Writs' = Get-GW2Item -Id ($WritIDs -join ',')
    })
}

If ($FilePath) {
    $content = Get-Content $FilePath
    $replaced = ForEach ($line in $content) {
        If ($line -match $ReplaceFilter) {
            $Prefix = $matches[1]
            $line -replace $ReplaceFilter,($ReplaceFormat -f $Total.Remaining,$Prefix)
        } else {
            $line
        }
    }
    $replaced | Set-Content $FilePath
}

$Total